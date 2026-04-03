#import "src/main.typ": (
  ergo-init,
  ergo-colors,
  ergo-styles,

  // Custom
  ergo-box,
)

#import "src/style/helpers.typ": (
  ergo-title-selector,
)

// TODO: explicitly import ergo.presets to access all the below
#import "src/main.typ": (
  bookmark,
  equation-box,
)

#import "src/style/cosmetic-envs.typ": (
  correction,
  proof,
  solution
)

#import "src/presets.typ": (
  theorem,
  lemma,
  corollary,
  proposition,
  note,
  warning,
  definition,
  remark,
  example,
  problem,
  exercise,
)

#let eqbox     = equation-box

#let thm       = theorem
#let lem       = lemma
#let cor       = corollary
#let prop      = proposition

#let defn      = definition
#let rem       = remark
#let rmk       = remark
#let ex        = example

#let prob      = problem
#let excs      = exercise

#let pf        = proof
#let sol       = solution
