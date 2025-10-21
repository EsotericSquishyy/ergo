#let custom-solution(
  title,
  statement,
  proof-statement,
  colors,
  ..argv
) = {
  let kwargs = argv.named()
  block(
    stroke: rgb(colors.env.strokecolor1) + 5pt,
    fill:   rgb(colors.env.bgcolor1),
    inset:  5pt,
    kwargs.preheader + title + statement + proof-statement,
  )
}

#let custom-statement(
  title,
  statement,
  colors,
  ..argv
) = {
  let kwargs = argv.named()
  block(
    stroke: rgb(colors.env.strokecolor) + 5pt,
    fill:   rgb(colors.env.bgcolor),
    inset:  5pt,
    kwargs.preheader + title + statement
  )
}

#let custom-styles = (
  "solution": custom-solution,
  "statement": custom-statement,
)
