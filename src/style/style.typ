#let ergo-styles-list = (
  "tab",
  "classic",
  "sidebar",
)
#let ergo-styles = (:)

// Initialize default styles
#for style-name in ergo-styles-list {
  import style-name + ".typ": proof-env, statement-env
  ergo-styles.insert(style-name, (
    "proof": proof-env,
    "statement": statement-env,
  ))
}

#let valid-styles(colors) = {
  // TODO
  return true
}
