#import "helpers.typ": (
  problem-counter,
  highlight-raw,
  get-title-content,
  get-solution-content,
  get-statement-content,
)


#let custom-solution(
  title,
  statement-body,
  solution-body,
  colors,
  ..argv
) = {
  let kwargs        = argv.named()

  let title-content = get-title-content(
    kwargs.preheader,
    title,
    is-proof:  kwargs.is-proof,
    prob-nums: kwargs.prob-nums,
    pad-env:   false
  )

  let solution-content = get-solution-content(
    solution-body,
    kwargs.is-proof,
    kwargs.inline-qed,
    pad-env: false,
  )

  title-content; statement-body; linebreak(); solution-content
}

#let custom-statement(
  title,
  statement-body,
  colors,
  ..argv
) = {
  let kwargs       = argv.named()

  let title-content     = get-title-content(kwargs.preheader, title, pad-env: false)
  let statement-content = get-statement-content(statement-body, pad-env: false)

  title-content; statement-content
}
