#import "reqs.typ": *

#let sidebar_proof_env(
  name,
  statement,
  proof_statement,
  colors,
  ..argv
) = {
  let kwargs      = argv.named()
  let bgcolor     = rgb(colors.env.bgcolor1)
  let strokecolor = rgb(colors.env.strokecolor1)

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(colors.raw),
      outset: (x: 1pt, y: 3pt),
      inset: (x: 2pt),
      radius: 2pt,
      r
    )
  }

  let name_content
  let kind = kwargs.kind
  if kwargs.problem {
    problem_counter.step()
    let count = [#context { problem_counter.display() }]

    if name == [] {
      name_content = [=== #kind #count: #name]
    } else {
      name_content = [=== #kind #count: #name]
    }
  } else {
    if name == [] {
      name_content = [=== _ #kind _]
    } else {
      name_content = [=== _ #kind: _ #name]
    }
  }

  let block_inset = 10pt
  let elem_spacing = 12pt

  let proof_content = none
  if proof_statement != [] {
    proof_content = if kwargs.problem  { [*Solution:* #proof_statement] } else { proof(proof_statement) }
  }

  block(
    stroke:     (left: strokecolor + 3pt),
    fill:       bgcolor,
    inset:      block_inset,
    width:      kwargs.width,
    height:     kwargs.height,
    breakable:  kwargs.breakable,
    clip:       true,
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
  colors,
  ..argv
) = {
  let kwargs      = argv.named()
  let bgcolor     = rgb(colors.env.bgcolor)
  let strokecolor = rgb(colors.env.strokecolor)

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(colors.raw),
      outset:  (x: 1pt, y: 3pt),
      inset:   (x: 2pt),
      radius:  2pt,
      r
    )
  }

  let name_content
  let kind = kwargs.kind
  if name == [] {
    name_content = [=== _ #kind _]
  } else {
    name_content = [=== _ #kind: _ #name]
  }

  let block_inset = 10pt
  let elem_spacing = 12pt

  block(
    stroke:     (left: strokecolor + 3pt),
    fill:       bgcolor,
    inset:      block_inset,
    width:      kwargs.width,
    height:     kwargs.height,
    breakable:  kwargs.breakable,
    clip:       true,
    stack(
      spacing: elem_spacing,
      text(fill: strokecolor)[#name_content],
      statement,
    ),
  )
}

