#import "../helpers.typ": (
  get-title-content,
  get-solution-content,
  get-statement-content,
)


#let custom-box(
  preheader,
  box-kind,
  title,
  statement-body,
  solution-body,
  box-theming,
  inline-qed,
  breakable,
  width,
  height,
) = {
  let title-content = get-title-content(
    preheader,
    title,
    pad-env: false,
    title-style: "parens",
  )

  if box-kind == "STATEMENT" {
    let statement-content = get-statement-content(statement-body, pad-env: false)

    return title-content; statement-content

  } else {
    let solution-content = get-solution-content(
      solution-body,
      box-kind,
      inline-qed,
      pad-env: false,
      title-style: "parens",
    )

    if box-kind == "PROOF" {
      return title-content; emph[#statement-body]; v(0.3em); solution-content
    } else {
      return title-content; statement-body; v(0.3em); solution-content
    }
  }
}
