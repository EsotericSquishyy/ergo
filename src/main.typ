#import "theme/theme.typ": *






//-----Setup-----//
#let problem_counter = counter("problem")

#let thmS-init(
  body,
  colors: "bootstrap",
  headers: "tab",
) = context {
  if(colors in env_colors_list) {
    env_colors.update(colors)
  }
  if(headers in env_headers_list) {
    env_headers.update(headers)
  }

  let theme        = env_colors.get()

  let h1_color     = get_colors(theme, "opts", "h1", default: rgb("#020004"))
  let h2_color     = get_colors(theme, "opts", "h2", default: rgb("#16428e"))
  let strong_color = get_colors(theme, "opts", "strong", default: rgb("#020004"))

  show strong: it => {
    set text(fill: strong_color)
    it
  }

  show heading.where(level: 1): it => {
    set text(fill: h1_color)
    it
  }

  show heading.where(level: 2): it => {
    set text(fill: h2_color)
    it
  }

  set text(get_text_color(theme, 1))
  set page(fill: get_page_color(theme))

  body
}






//-----Misc-----//
#let correction(body) = {
  text(fill: rgb("#ea4120"), weight: "semibold", body)
}

#let qed = [#v(0.2em) #h(90%) $square.big$]

// add option of changing : to .
#let proof(body) = {
  [*Proof:* ]; body; qed
}

#let bookmark(
  title,
  info,
) = context {
  let theme       = env_colors.get()

  let bgcolor     = get_colors(theme, "bookmark", "bgcolor")
  let strokecolor = get_colors(theme, "bookmark", "strokecolor")

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






//-----Theorem Environments-----//
#let proof_env(
  statement:       [],
  proof_statement: [],
  name:            [],
  kind:            [],
  breakable:       false,
  id:              "",
  formal:          true,
  problem:         false,
  width:           100%,
  height:          auto,
  ..args
) = context {
  let argv = args.pos()
  let argc = argv.len()

  if argc < 2 {
    panic("Must pass in at least two positional arguments")
  } else if argc > 3 {
    panic("Must pass in at most 3 positional arguments")
  }

  let name = if argc == 3 {argv.at(0)} else {name}
  let statement = if argc == 2 {argv.at(0)} else {argv.at(1)}
  let proof_statement = if argc == 2 {argv.at(1)} else {argv.at(2)}

  let theme         = env_colors.get()

  let bgcolor1      = get_colors(theme, id, "bgcolor1")
  let bgcolor2      = get_colors(theme, id, "bgcolor2")
  let strokecolor1  = get_colors(theme, id, "strokecolor1")
  let strokecolor2  = get_colors(theme, id, "strokecolor2")

  show raw.where(block: false): r => {
    box(
      fill: bgcolor1.saturate(ratios(theme, "raw", "saturation")),
      outset: (x: 1pt, y: 3pt),
      inset: (x: 2pt),
      radius: 2pt,
      r
    )
  }

  let name_content
  if formal {
    name_content = [=== _ #kind _]
    if name != [] {
      name_content = [=== _ #kind: _ #name]
    }

  } else {
    let suffix = [:]

    if problem {
      problem_counter.step()
      if name == [] {
        name = [#context { problem_counter.display() }]
        suffix = []
      }

    } else {
      if name == [] { suffix = [] }
    }

    let kind_content = kind + suffix
    name_content = [=== #kind_content #name]
  }

  let block_inset
  let top_pad
  let side_pad
  if env_headers.get() == "tab" {
    name_content = block(
      fill: strokecolor1,
      inset: 7pt,
      width: 100%,
      text(get_text_color(theme, 2))[#name_content]
    )

    block_inset = 0pt
    top_pad = 8pt
    side_pad = 12pt

  } else if env_headers.get() == "classic" {
    block_inset = 8pt
    top_pad = 12pt
    side_pad = 0pt
  }

  let statement_content = pad(
    top: top_pad,
    right: 12pt,
    left: 12pt,
    bottom: 12pt,
    block(
      fill: bgcolor2,
      inset: 8pt,
      radius: 2pt,
      width: width,
      stroke: (
        left: strokecolor2 + 6pt
      ),
      statement
    )
  )
  let proof_content = []

  if proof_statement != [] {
    if formal {
      proof_content = pad(proof(proof_statement), side_pad)
    } else {
      proof_content = stack(
        pad([*Solution*], top: 12pt, left: side_pad),
        pad(proof_statement, left: side_pad, right: side_pad, bottom: side_pad, top: 12pt)
      )
    }

  }

  block(
    fill: bgcolor1,
    width: width,
    height: height,
    inset: block_inset,
    radius: 7pt,
    stroke: strokecolor1,
    breakable: breakable,
    clip: true,
    stack(
      name_content,
      statement_content,
      proof_content,
    )
  )
}

#let theorem = proof_env.with(
  kind: [Theorem],
  id:   "theorem"
)

#let lemma = proof_env.with(
  kind: [Lemma],
  id:   "lemma"
)

#let corollary = proof_env.with(
  kind: [Corollary],
  id:   "corollary"
)

#let proposition = proof_env.with(
  kind: [Proposition],
  id:   "proposition"
)

#let problem = proof_env.with(
  kind:    [Problem],
  id:      "problem",
  formal:  false,
  problem: true
)

#let exercise = proof_env.with(
  kind:   [Exercise],
  id:     "exercise",
  formal: false
)






//-----Definition Environments-----//
#let statement_env(
  name:         [],
  statement:    [],
  kind:         [],
  breakable:    false,
  id:           "",
  width:           100%,
  height:          auto,
  ..args
) = context {
  let argv = args.pos()
  let argc = argv.len()

  if argc < 1 {
    panic("Must pass in at least one positional argument")
  } else if argc > 2 {
    panic("Muss pass in at most 2 positional arguments")
  }

  let name = if argc == 2 {argv.at(0)} else {name}
  let statement = if argc == 1 {argv.at(0)} else {argv.at(1)}

  let theme       = env_colors.get()

  let bgcolor     = get_colors(theme, id, "bgcolor")
  let strokecolor = get_colors(theme, id, "strokecolor")

  let name_content = [=== #kind]
  if name != [] {
    name_content = [=== #kind: #name]
  }

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(ratios(theme, "raw", "saturation")),
      outset: (x: 1pt, y: 3pt),
      inset: (x: 2pt),
      radius: 2pt,
      r
    )
  }

  let block_inset
  let top_pad
  let side_pad
  let bottom_pad
  if env_headers.get() == "tab" {
    name_content = block(
      fill: strokecolor,
      inset: 7pt,
      width: 100%,
      text(get_text_color(theme, 2))[#name_content]
    )

    block_inset = 0pt
    top_pad = 8pt
    side_pad = 12pt
    bottom_pad = 10pt

  } else if env_headers.get() == "classic" {
    block_inset = 8pt
    top_pad = 12pt
    side_pad = 0pt
    bottom_pad = 3pt
  }

  block(
    fill: bgcolor,
    width: width,
    height: height,
    inset: block_inset,
    radius: 7pt,
    stroke: strokecolor,
    breakable: breakable,
    clip: true,
    stack(
      name_content,
      pad(
        top: top_pad,
        bottom: bottom_pad,
        left: side_pad,
        right: side_pad,
        statement
      )
    )
  )
}

#let note = statement_env.with(
  kind: [Note],
  id:   "note"
)

#let definition = statement_env.with(
  kind: [Definition],
  id:   "definition"
)

#let remark = statement_env.with(
  kind: [Remark],
  id:   "remark"
)

#let notation = statement_env.with(
  kind: [Notation],
  id:   "notation"
)

#let example = statement_env.with(
  kind: [Example],
  id:   "example"
)

#let concept = statement_env.with(
  kind: [Concept],
  id:   "concept"
)

#let computational_problem = statement_env.with(
  kind: [Computational Problem],
  id:   "computational_problem"
)

#let algorithm = statement_env.with(
  kind: [Algorithm],
  id:   "algorithm"
)

#let runtime = statement_env.with(
  kind: [Runtime Analysis],
  id:   "runtime"
)
