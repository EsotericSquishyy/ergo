#let ergo-styles-names = (
  "tab",
  "classic",
  "sidebar",
)
#let ergo-styles = (:)

// Initialize default styles
#for styles-name in ergo-styles-names {
  import styles-name + ".typ": custom-solution, custom-statement
  ergo-styles.insert(styles-name, (
    "solution": custom-solution,
    "statement": custom-statement,
  ))
}

#let valid-styles(colors) = {
  // TODO
  return true
}
