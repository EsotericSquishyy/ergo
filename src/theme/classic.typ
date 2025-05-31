#import "reqs.typ": *

#let classic_proof_env(
  name,
  statement,
  proof_statement,
  colors,
  ..argv
) = {
  let kwargs        = argv.named()
  let bgcolor1      = rgb(colors.env.bgcolor1)
  let bgcolor2      = rgb(colors.env.bgcolor2)
  let strokecolor1  = rgb(colors.env.strokecolor1)
  let strokecolor2  = rgb(colors.env.strokecolor2)

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(colors.raw),
      outset:  (x: 1pt, y: 3pt),
      inset:   (x: 2pt),
      radius:  2pt,
      r,
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

  let block_inset = 8pt
  let top_pad     = 12pt
  let side_pad    = 0pt

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

  if proof_statement != [] {
    if kwargs.problem {
      proof_content = stack(
        pad([*Solution*], top: 12pt, left: side_pad),
        pad(proof_statement, left: side_pad, right: side_pad, bottom: side_pad, top: 12pt)
      )
    } else {
      proof_content = pad(proof(proof_statement), side_pad)
    }
  }

  block(
    stroke:     strokecolor1,
    fill:       bgcolor1,
    inset:      block_inset,
    width:      kwargs.width,
    height:     kwargs.height,
    breakable:  kwargs.breakable,
    radius:     7pt,
    clip:       true,
    stack(
      name_content,
      statement_content,
      proof_content,
    )
  )
}

#let classic_statement_env(
  name,
  statement,
  colors,
  ..argv
) = {
  let kwargs       = argv.named()
  let bgcolor      = rgb(colors.env.bgcolor)
  let strokecolor  = rgb(colors.env.strokecolor)

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

  let block_inset = 8pt
  let top_pad = 12pt
  let side_pad = 0pt
  let bottom_pad = 3pt

  block(
    stroke:     strokecolor,
    fill:       bgcolor,
    inset:      block_inset,
    width:      kwargs.width,
    height:     kwargs.height,
    breakable:  kwargs.breakable,
    radius:     7pt,
    clip:       true,
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

