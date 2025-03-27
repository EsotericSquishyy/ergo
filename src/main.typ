#import "theme/theme.typ": *






//-----Setup-----//
#let problem_counter = counter("problem")

#let thmS-init(
  body,
  colors: "classic",
  headers: "tab",
) = context {
  if(colors in env_colors_list) {
    env_colors.update(colors)
  }
  if(headers in env_headers_list) {
    env_headers.update(headers)
  }

  let theme = env_colors.get()

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
  let theme = env_colors.get()
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
  name,
  statement,
  proof_statement,
  kind:         [],
  breakable:    false,
  id:           "",
) = context {
  let theme = env_colors.get()

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

  let name_content = [=== _ #kind _]
  if name != [] {
    name_content = [=== _ #kind: _ #name]
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
      width: 100%,
      stroke: (
        left: strokecolor2 + 6pt
      ),
      statement
    )
  )
  let proof_content = []

  if proof != [] {
    proof_content = pad(proof(proof_statement), side_pad)
  }

  block(
    fill: bgcolor1,
    width: 100%,
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

#let theorem(statement, proof, name: [], breakable: false) = {
  proof_env(
    name,
    statement,
    proof,
    kind:         [Theorem],
    breakable:    breakable,
    id:           "theorem",
  )
}

#let lemma(statement, proof, name: [], breakable: false) = {
  proof_env(
    name,
    statement,
    proof,
    kind:         [Lemma],
    breakable:    breakable,
    id:           "lemma",
  )
}

#let corollary(statement, proof, name: [], breakable: false) = {
  proof_env(
    name,
    statement,
    proof,
    kind:         [Corollary],
    breakable:    breakable,
    id:           "corollary",
  )
}

#let proposition(statement, proof, name: [], breakable: false) = {
  proof_env(
    name,
    statement,
    proof,
    kind:         [Proposition],
    breakable:    breakable,
    id:           "proposition",
  )
}






//-----Definition Environments-----//
#let statement_env(
  name,
  statement,
  kind:         [],
  breakable:    false,
  id:           "",
) = context {
  let theme = env_colors.get()

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
    width: 100%,
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

#let note(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Note],
    breakable:    breakable,
    id:           "note",
  )
}

#let definition(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Definition],
    breakable:    breakable,
    id:           "definition",
  )
}

#let remark(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Remark],
    breakable:    breakable,
    id:           "remark",
  )
}

#let notation(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Notation],
    breakable:    breakable,
    id:           "notation",
  )
}

#let example(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Example],
    breakable:    breakable,
    id:           "example",
  )
}

#let concept(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Concept],
    breakable:    breakable,
    id:           "concept",
  )
}

#let computational_problem(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Computational Problem],
    breakable:    breakable,
    id:           "computational_problem",
  )
}

#let algorithm(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Algorithm],
    breakable:    breakable,
    id:           "algorithm",
  )
}

#let runtime(statement, name: [], breakable: false) = {
  statement_env(
    name,
    statement,
    kind:         [Runtime Analysis],
    breakable:    breakable,
    id:           "runtime",
  )
}






//-----Problem Environments-----//
#let prob_env(
  name,
  statement,
  solution,
  kind:         [],
  breakable:    false,
  id:           "",
  width:        100%,
  height:       auto,
) = context {
  let theme = env_colors.get()

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

  let name_content = [=== #kind #name]
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
    bottom: 12pt,
    left: 12pt,
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
      pad([*Solution*], top: 12pt, left: side_pad),
      pad(solution, left: side_pad, right: side_pad, bottom: side_pad, top: 12pt)
    )
  )
}

// proof param?
#let problem(
  statement,
  solution,
  name:       [],
  breakable:  false,
  width:      100%,
  height:     auto,
) = {
  problem_counter.step()

  let suffix = [:]
  if name == [] {
    name = [#context { problem_counter.display() }]
    suffix = []
  }

  prob_env(
    name,
    statement,
    solution,
    kind:         [Problem] + suffix,
    breakable:    breakable,
    id:           "problem",
    width:        width,
    height:       height,
  )
}

#let exercise(
  statement,
  solution,
  name:       [],
  breakable:  false,
  width:      100%,
  height:     auto,
) = {
  let suffix = [:]
  if name == [] { suffix = [] }

  prob_env(
    name,
    statement,
    solution,
    kind:         [Exercise] + suffix,
    breakable:    breakable,
    id:           "exercise",
    width:        width,
    height:       height,
  )
}
