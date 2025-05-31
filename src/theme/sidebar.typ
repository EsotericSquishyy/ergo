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

  show raw.where(block: false): r => highlight_raw(r, bgcolor.saturate(colors.raw))

  let name_content = get_name_content(kwargs.kind, name, problem: kwargs.problem)

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

  show raw.where(block: false): r => highlight_raw(r, bgcolor.saturate(colors.raw))

  let name_content = get_name_content(kwargs.kind, name)

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

