#let ergo-title-selector = <__ergo_title>
#let ergo-title(content) = {
  set text(weight: "bold")
  [#content#ergo-title-selector]
}

#let proof(body, inline-qed) = {
  if inline-qed {
    [*Proof:* ]; body; [$square.big$]
  } else {
    [*Proof:* ]; body; [#v(0.2em) #h(90%) $square.big$]
  }
}
#let solution(body) = {
  [*Solution:* ]; body
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

#let get-title-content(preheader, title, is-proof: false, prob-nums: false) = {
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

  return pad(x: xpad, y: ypad, title-content)
}

#let get-solution-content(solution-body, is-proof, inline-qed) = {
  let xpad = 12pt
  let ypad = 6pt

  if solution-body == [] {
    return none
  } else {
    if is-proof {
      return pad(x: xpad, y: ypad, proof(solution-body, inline-qed))
    } else {
      return pad(x: xpad, y: ypad, solution(solution-body))
    }
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
