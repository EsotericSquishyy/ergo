#import "cosmetic-envs.typ": (
  proof,
  solution
)

#let ergo-title-selector = <__ergo_title>
#let ergo-title(content) = {
  set text(weight: "bold")
  [#content#ergo-title-selector]
}

#let problem-counter = counter("problem")

#let highlight-raw(content, raw-color) = {
  box(
    fill:   raw-color,
    outset: (x: 1pt, y: 3pt),
    inset:  (x: 2pt),
    radius: 2pt,
    content
  )
}

#let get-title-content(preheader, title, is-proof: false, prob-nums: false, pad-env: true) = {
  let xpad = 12pt
  let ypad = 6pt
  let title-content = none

  let count = if prob-nums [ #{problem-counter.step(); context problem-counter.display()}] else []

  if title == [] {
    if is-proof {
      title-content = ergo-title[#emph[#preheader#count]]
    } else {
      title-content = ergo-title[#preheader#count]
    }
  } else {
    if is-proof {
      title-content = ergo-title[#emph[#preheader#count: ]#title]
    } else {
      title-content = ergo-title[#preheader#count: #title]
    }
  }

  if pad-env {
    return pad(x: xpad, y: ypad, title-content)
  } else {
    return title-content
  }
}

#let get-solution-content(solution-body, is-proof, inline-qed, sol-color: none, pad-env: true) = {
  let xpad = 12pt
  let ypad = 6pt
  let solution-content

  if solution-body == [] {
    return none
  } else {
    if is-proof {
      solution-content = proof(solution-body, inline-qed: inline-qed, color: sol-color)
    } else {
      solution-content = proof(solution-body, color: sol-color)
    }
  }

  if pad-env {
    return pad(x: xpad, y: ypad, solution-content)
  } else {
    return solution-content
  }
}

#let get-statement-content(statement) = {
  let xpad = 12pt
  let ypad = 6pt

  if statement == [] {
    return none
  } else {
    return pad(x: xpad, y: ypad, statement)
  }
}
