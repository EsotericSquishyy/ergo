#let ergo-styles-names = (
  "tab1",
  "tab2",
  "sidebar",
)
#let ergo-styles = (:)

// Initialize default styles
#for styles-name in ergo-styles-names {
  import styles-name + ".typ": custom-solution, custom-statement
  ergo-styles.insert(styles-name, (
    "solution":  custom-solution,
    "statement": custom-statement,
  ))
}

#let valid-styles(styles) = {
  let solution-env = styles.remove("solution", default: none)
  if type(solution-env) != function { return false }

  let statement-env = styles.remove("statement", default: none)
  if type(statement-env) != function { return false }

  if styles.len() != 0 { return false }

  return true
}
