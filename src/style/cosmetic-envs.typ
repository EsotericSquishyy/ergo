#let correction(body) = {
  text(fill: rgb("#ea4120"), weight: "semibold", body)
}

#let proof(body, inline-qed: false) = {
  if inline-qed {
    [*Proof:* ]; body; [$square.big$]
  } else {
    [*Proof:* ]; body; [#v(0.2em) #h(90%) $square.big$]
  }
}

#let solution(body) = {
  [*Solution:* ]; body
}
