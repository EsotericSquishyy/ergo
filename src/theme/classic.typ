#import "reqs.typ": *

#let classic_proof_env(
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
  let bgcolor1      = rgb(colors.at("bgcolor1"))
  let bgcolor2      = rgb(colors.at("bgcolor2"))
  let strokecolor1  = rgb(colors.at("strokecolor1"))
  let strokecolor2  = rgb(colors.at("strokecolor2"))

  show raw.where(block: false): r => {
    box(
      fill: bgcolor.saturate(raw_ratio),
      outset:  (x: 1pt, y: 3pt),
      inset:   (x: 2pt),
      radius:  2pt,
      r,
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

#let classic_statement_env(
  name_content,
  statement,
  colors,
  opts_colors,
  breakable,
  width,
  height
) = {
  let bgcolor      = rgb(colors.at("bgcolor"))
  let strokecolor  = rgb(colors.at("strokecolor"))

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

  let block_inset = 8pt
  let top_pad = 12pt
  let side_pad = 0pt
  let bottom_pad = 3pt

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

