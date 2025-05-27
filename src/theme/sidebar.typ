#import "reqs.typ": *

#let sidebar_proof_env(
  statement,
  proof_statement,
  name_content,
  colors,
  opts_colors,
  breakable,
  formal,
  width,
  height,
) = {
  let bgcolor = rgb(colors.at("bgcolor1"))
  let strokecolor = rgb(colors.at("strokecolor1"))

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
  name_content,
  statement,
  colors,
  opts_colors,
  breakable,
  width,
  height
) = {
  let bgcolor = rgb(colors.at("bgcolor"))
  let strokecolor = rgb(colors.at("strokecolor"))

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
      text(fill: strokecolor, weight: "bold")[#name_content],
      statement,
    ),
  )
}

