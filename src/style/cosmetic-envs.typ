#let correction(body) = {
  text(fill: rgb("#ea4120"), weight: "semibold", body)
}

#let proof(body, inline-qed: false, color: none) = {
  let content = if (color != none) {text(fill: color, weight: "bold")[Proof: ]} else {[*Proof: * ]}

  if inline-qed {
    content; body; [$square.big$]
  } else {
    content; body; [#v(0.2em) #h(90%) $square.big$]
  }
}

#let solution(body, color: none) = {
  let content = if (color != none) {text(fill: color, weight: "bold")[Solution: ]} else {[*Solution: *]}
  content; body
}
