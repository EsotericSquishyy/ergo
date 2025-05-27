#import "reqs.typ": *

#let sidebar_proof_env(
  name,
  statement,
  proof_statement,
  breakable,
  formal,
  width,
  height,
  kind,
  problem,
  colors,
  opts_colors,
  raw_ratio
) = {
  let bgcolor = rgb(colors.at("bgcolor1"))
  let strokecolor = rgb(colors.at("strokecolor1"))

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(raw_ratio),
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

  let block_inset = 10pt
  let elem_spacing = 12pt

  let proof_content = none
  if proof_statement != [] {
    proof_content = if formal { proof(proof_statement) } else { [*Solution:* #proof_statement] }
  }

  block(
    fill: bgcolor,
    width: width,
    height: height,
    inset: block_inset,
    stroke: (left: strokecolor + 3pt),
    breakable: breakable,
    clip: true,
    stack(
      spacing: elem_spacing,
      text(strokecolor)[#name_content],
      statement,
      proof_content,
    ),
  )
}

#let sidebar_statement_env(
  name,
  statement,
  breakable,
  width,
  height,
  kind,
  colors,
  opts_colors,
  raw_ratio
) = {
  let bgcolor = rgb(colors.at("bgcolor"))
  let strokecolor = rgb(colors.at("strokecolor"))

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(raw_ratio),
      outset:  (x: 1pt, y: 3pt),
      inset:   (x: 2pt),
      radius:  2pt,
      r
    )
  }

  let name_content = [=== #kind]
  if name != [] {
    name_content = [=== #kind: #name]
  }


  let block_inset = 10pt
  let elem_spacing = 12pt

  block(
    fill: bgcolor,
    inset: block_inset,
    stroke: (left: strokecolor + 3pt),
    breakable: breakable,
    clip: true,
    width: width,
    height: height,
    stack(
      spacing: elem_spacing,
      text(fill: strokecolor)[#name_content],
      statement,
    ),
  )
}

