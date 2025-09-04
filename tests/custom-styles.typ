#let custom-proof-env(
  name,
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
    kwargs.kind + name + statement + proof-statement,
  )
}

#let custom-statement-env(
  name,
  statement,
  colors,
  ..argv
) = {
  let kwargs = argv.named()
  block(
    stroke: rgb(colors.env.strokecolor) + 5pt,
    fill:   rgb(colors.env.bgcolor),
    inset:  5pt,
    kwargs.kind + name + statement
  )
}

#let custom-styles = (
  "proof": custom-proof-env,
  "statement": custom-statement-env,
)
