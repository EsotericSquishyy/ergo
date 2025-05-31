#let qed = [#v(0.2em) #h(90%) $square.big$]
#let proof(body) = {
  [*Proof:* ]; body; qed
}

#let problem_counter = counter("problem")

#let get_name_content(kind, name, problem: false) = {
  if problem {
    problem_counter.step()
    let count = [#context { problem_counter.display() }]

    if name == [] {
      return [=== #kind #count: #name]
    } else {
      return [=== #kind #count: #name]
    }
  } else {
    if name == [] {
      return [=== _ #kind _]
    } else {
      return [=== _ #kind: _ #name]
    }
  }

}

#let highlight_raw(content, raw_color) = {
  box(
    fill: raw_color.saturate(50%),
    outset: (x: 1pt, y: 3pt),
    inset: (x: 2pt),
    radius: 2pt,
    content
  )
}
