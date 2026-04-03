#import "@preview/elembic:1.1.1" as e: field, types

// TODO allow dictionary casting
#let ergo-style = types.declare(
  "ergo-style",
  prefix: "@preview/ergo:0.3.0",
  doc: "Style of Ergo boxes",
  fields: (
    field("custom-box", function, doc: "The function returning the custom box environment to use.", required: true),
  )
)

#let ergo-styles-names = (
  "tab1",
  "tab2",
  "sidebar1",
  "sidebar2",
  "classic",
  "basic",
)
#let ergo-styles = (:)

// Initialize default styles
#for styles-name in ergo-styles-names {
  import "templates/" + styles-name + ".typ": custom-box
  ergo-styles.insert(
    styles-name,
    types.cast(
      ("custom-box": custom-box,),
      ergo-style,
    ),
  )
}
