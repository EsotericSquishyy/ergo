#import "color/color.typ": *
#import "theme/theme.typ": *





//-----Setup-----//
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

  let colors       = env_colors.get()
  let opts_colors  = get_opts_colors(env_colors.get())

  let bg_color     = rgb(opts_colors.at("fill"))
  let t1_color     = rgb(opts_colors.at("text1"))
  let t2_color     = rgb(opts_colors.at("text2"))
  let h1_color     = rgb(opts_colors.at("h1"))
  let h2_color     = rgb(opts_colors.at("h2"))
  let strong_color = rgb(opts_colors.at("strong"))

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

  set text(t1_color)
  set page(fill: bg_color)

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
  let colors      = get_colors(theme, "bookmark")

  let bgcolor     = rgb(colors.at("bgcolor"))
  let strokecolor = rgb(colors.at("strokecolor"))

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

  let name            = if argc == 3 {argv.at(0)} else {name}
  let statement       = if argc == 2 {argv.at(0)} else {argv.at(1)}
  let proof_statement = if argc == 2 {argv.at(1)} else {argv.at(2)}

  let colors      = get_colors(env_colors.get(), id)
  let opts_colors = get_opts_colors(env_colors.get())
  let raw_ratio   = get_ratio(env_colors.get(), "raw", "saturation")
  let theme       = env_headers.get()

  if (theme == "tab") {
    return tab_proof_env(
      statement,
      proof_statement,
      name,
      colors,
      opts_colors,
      raw_ratio,
      kind,
      breakable,
      formal,
      problem,
      width,
      height
    )
  } else if (theme == "classic") {
    return classic_proof_env(
      statement,
      proof_statement,
      name,
      colors,
      opts_colors,
      raw_ratio,
      kind,
      breakable,
      formal,
      problem,
      width,
      height
    )
  }
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

  let colors      = get_colors(env_colors.get(), id)
  let opts_colors = get_opts_colors(env_colors.get())
  let raw_ratio   = get_ratio(env_colors.get(), "raw", "saturation")
  let theme       = env_headers.get()

  if (theme == "tab") {
    return tab_statement_env(
      name,
      statement,
      colors,
      opts_colors,
      raw_ratio,
      kind,
      breakable,
      width,
      height
    )
  } else if (theme == "classic") {
    return classic_statement_env(
      name,
      statement,
      colors,
      opts_colors,
      raw_ratio,
      kind,
      breakable,
      width,
      height
    )
  }
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
