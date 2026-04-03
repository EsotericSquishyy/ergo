#import "@preview/elembic:2.1.1" as e
#import "@preview/oxifmt:1.0.0": strfmt

#import "color/color.typ": (
  ergo-base-color,
  ergo-color-scheme,
  ergo-color-schemes,
  get-environment-theming,
  get-document-theming,
  get-ratio,
)
#import "style/style.typ": (
  ergo-style,
  ergo-styles,
)






//-----Setup-----//
// box-kinds enum construction
#let box-kinds = (
  "PROOF",
  "SOLUTION",
  "STATEMENT",
)
#let ergo-box-kind = e.types.union(..box-kinds)
#let ergo-box-kinds = (:)
#for box-kind in box-kinds {
  ergo-box-kinds.insert(box-kind, box-kind)
}

#let ergo-config-state = state("ergo-config", (
  color-scheme: ergo-color-schemes.bootstrap,
  style:        ergo-styles.tab2,
  breakable:    true,
  inline-qed:   false,
))

// Unset state

// The main reason we need this is that we can't read state while declaring an elembic type
// so we need to defer identifying default values for particular arguments until actually
// displaying them. It's also useful for avoiding having to define default values in ergo-init
// twice.
#let unset-param = e.types.declare(
  "unset",
  prefix: "@preview/ergo:0.3.0",
  fields: (),
)

#let validate(value, target-type, name) = {
  if e.types.is(value, ergo-unset) { return value }
  let (ok, result) = e.types.cast(value, target-type)
  if not ok { panic(strfmt("ergo-init: invalid {}: {}", name, result)) }

  result
}

#let enforce-default(value, default) = {
  if e.types.is(value, ergo-unset) { return default }
  return value
}




#let ergo-init(
  body,
  color-scheme:           unset-param(),
  style:                  unset-param(),
  breakable:              unset-param(),
  inline-qed:             unset-param(),
  apply-document-theming: false,
) = context {

  let validated-fields = (
    color-scheme: validate(color-scheme, ergo-color-scheme, "color-scheme"),
    style:        validate(style,        ergo-style,        "style"),
    breakable:    validate(breakable,    bool,              "breakable"),
    inline-qed:   validate(inline-qed,   bool,              "inline-qed"),
  )

  ergo-config-state.update(old => {
    let new = old

    // note the implicit update here
    for (key, value) in validated-fields {
      if not e.types.is(value, unset-param) {
        new.insert(key, value)
      }
    }

    new
  })

  if apply-document-theming {
    let document-theming = get-document-theming(ergo-config-state.get().at("color-scheme"))

    show strong: set text(fill: document-theming.at("strong"))
    show heading.where(level: 1): set text(fill: document-theming.at("h1"))
    show heading.where(level: 2): set text(fill: document-theming.at("h2"))

    set text(fill: document-theming.at("text1"))
    set page(fill: document-theming.at("fill"))

    body
  } else {
    body
  }
}






//-----Environments-----//
#let bookmark(
  title,
  info,
) = context {
  let colors          = colors-state.get()
  let bookmark-colors = get-colors(colors, "bookmark")
  let bgcolor         = rgb(bookmark-colors.at("bgcolor"))
  let strokecolor     = rgb(bookmark-colors.at("strokecolor"))

  block(
    fill: bgcolor,
    width: 100%,
    inset: 8pt,
    stroke: strokecolor,
    breakable: false,
    grid(
      columns: (1fr, 1fr),
      align(left)[#title],
      align(right)[#info],
    )
  )
}




#let equation-box(
  equation,
) = context {
  let colors      = colors-state.get()
  let opts-colors = get-opts-colors(colors)
  let text1       = rgb(opts-colors.at("text1"))

  align(center)[
    #rect(stroke: text1)[
      #equation
    ]
  ]
}




#let display-ergo-box(
  preheader,
  base-color,
  box-kind,
  title,
  statement,
  solution,
  color-scheme,
  style,
  inline-qed,
  breakable,
  width,
  height,
) = context {
  let enforced-style        = enforce-default(style,        ergo-config-state.get().at("style"))
  let enforced-color-scheme = enforce-default(color-scheme, ergo-config-state.get().at("color-scheme"))

  let colors = (
    "environment":      get-environment-colors(enforced-color-scheme, base-color),
    "document-theming": get-document-theming(enforced-color-scheme),
    "raw":              get-ratio(enforced-color-scheme, "raw", "saturation"),
  )

  return (enforced-style.custom-box)(
    preheader:    preheader,
    box-kind:     box-kind,
    title:        title,
    statement:    statement,
    solution:     solution,
    box-colors:   box-colors,
    inline-qed:   enforce-default(inline-qed,   ergo-config-state.get().at("inline-qed")),
    breakable:    enforce-default(breakable,    ergo-config-state.get().at("breakable")),
    width:        width,
    height:       height,
  )
}

#let ergo-box(preheader, base-color, box-kind, ..argv) = context {
  assert(argv.pos() == (), message: "ergo-box factory only accepts named arguments")
  let factory-named = argv.named()

  return e.element.declare(
    preheader,
    prefix:  "@preview/ergo:0.3.0",
    doc:     strfmt("Formats a {} statement.", preheader),
    display: it => {
      display-ergo-box(
        preheader,
        base-color,
        box-kind,
        it.title,
        it.statement,
        it.solution,
        it.color-scheme,
        it.style,
        it.inline-qed,
        it.breakable,
        it.width,
        it.height,
      )
    },
    fields: (
      e.field(
        "title",
        content,
        doc: "The title of the box.",
        default: none,
      ),
      e.field(
        "statement",
        content,
        doc: "The statement of the box.",
        required: true,
      ),
      e.field(
        "solution",
        content,
        doc: "The proof or solution corresponding to the statement.",
        default: none,
      ),
      e.field(
        "color-scheme",
        e.types.union(ergo-color-scheme, ergo-unset),
        doc: "The box's color scheme.",
        default: factory-named.at("color-scheme", default: unset-param()),
      ),
      e.field(
        "style",
        e.types.union(ergo-style, ergo-unset),
        doc: "The box's style.",
        default: factory-named.at("style", default: unset-param()),
      ),
      e.field(
        "inline-qed",
        e.types.union(bool, ergo-unset),
        doc: "(Only when box-kind is proof) Whether the QED symbol is inline.",
        default: factory-named.at("inline-qed", default: unset-param()),
      ),
      e.field(
        "breakable",
        e.types.union(bool, ergo-unset),
        doc: "Whether the box can be broken and continue onto the next page.",
        default: factory-named.at("breakable", default: unset-param()),
      ),
      e.field(
        "width",
        length,  // TODO: can also be a ratio or auto
        doc: "The width of the box.",
        default: factory-named.at("width", default: 100%),
      ),
      e.field(
        "height",
        length,
        doc: "The height of the box.",
        default: factory-named.at("height", default: auto),
      ),
    ),
    parse-args: (default-parser, fields: none, typecheck: none) => (args, include-required: false) => {
      if include-required {
        let pos = args.pos()
        let named = args.named()

        let new-args = if box-kind == "STATEMENT" {
          if pos.len() == 1 {
            arguments(statement: pos.at(0), ..named)
          } else if pos.len() == 2 {
            arguments(title: pos.at(0), statement: pos.at(1), ..named)
          } else {
            return (false, strfmt("box '{}' of kind {}: expected 1-2 positional arguments, got {}", id, box-kind, str(pos.len())))
          }
        } else if box-kind == "SOLUTION" or box-kind == "PROOF" {
          if pos.len() == 1 {
            arguments(statement: pos.at(0), ..named)
          } else if pos.len() == 2 {
            arguments(title: pos.at(0), statement: pos.at(1), ..named)
          } else if pos.len() == 3 {
            arguments(title: pos.at(0), statement: pos.at(1), solution: pos.at(2), ..named)
          } else {
            return (false, strfmt("box '{}' of kind {}: expected 1-3 positional arguments, got {}", id, box-kind, str(pos.len())))
          }
        } else {
          return (false, strfmt("box-kind '{}' not recognized", box-kind))
        }

        default-parser(new-args, include-required: include-required)
      } else {
        // We are in a set rule
        if args.pos() != () {
          return (false, strfmt("box '{}': unexpected position argument(s) in set rule", id))
        }

        default-parser(args, include-required: include-required)
      }
    }
  )
}
