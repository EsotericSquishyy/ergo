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
  let bgcolor1      = rgb(colors.env.bgcolor1)
  let bgcolor2      = rgb(colors.env.bgcolor2)
  let strokecolor1  = rgb(colors.env.strokecolor1)
  let strokecolor2  = rgb(colors.env.strokecolor2)

  show raw.where(block: false): r => highlight-raw(r, bgcolor1.saturate(colors.raw))

  let title-content = get-title-content(
    kwargs.preheader,
    title,
    is-proof: kwargs.is-proof,
    prob-nums: kwargs.prob-nums,
    pad-env: false
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
  let bgcolor      = rgb(colors.env.bgcolor)
  let strokecolor  = rgb(colors.env.strokecolor)

  show raw.where(block: false): r => highlight-raw(r, bgcolor.saturate(colors.raw))

  let title-content     = get-title-content(kwargs.preheader, title)
  let statement-content = get-statement-content(statement-body)

  block(
    stroke:     strokecolor,
    fill:       bgcolor,
    inset:      (y: 4pt),
    width:      kwargs.width,
    height:     kwargs.height,
    breakable:  kwargs.breakable,
    radius:     6pt,
    clip:       true,
    stack(
      title-content,
      statement-content
    )
  )
}
