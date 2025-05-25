#let qed = [#v(0.2em) #h(90%) $square.big$]
#let proof(body) = {
  [*Proof:* ]; body; qed
}

#let problem_counter = counter("problem")

