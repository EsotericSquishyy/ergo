#import "main.typ": ergo-box, ergo-box-kinds
#import "color/color.typ": ergo-base-colors


#let theorem     = ergo-box("Theorem",     ergo-base-colors.PURPLE, ergo-box-kinds.PROOF)
#let lemma       = ergo-box("Lemma",       ergo-base-colors.YELLOW, ergo-box-kinds.PROOF)
#let corollary   = ergo-box("Corollary",   ergo-base-colors.PURPLE, ergo-box-kinds.PROOF)
#let proposition = ergo-box("Proposition", ergo-base-colors.RED,    ergo-box-kinds.PROOF)
#let problem     = ergo-box("Problem",     ergo-base-colors.GREEN,  ergo-box-kinds.SOLUTION)
#let exercise    = ergo-box("Exercise",    ergo-base-colors.ORANGE, ergo-box-kinds.PROOF)
#let note        = ergo-box("Note",        ergo-base-colors.INDIGO, ergo-box-kinds.STATEMENT)
#let warning     = ergo-box("Warning",     ergo-base-colors.YELLOW, ergo-box-kinds.STATEMENT)
#let definition  = ergo-box("Definition",  ergo-base-colors.BLUE,   ergo-box-kinds.STATEMENT)
#let remark      = ergo-box("Remark",      ergo-base-colors.INDIGO, ergo-box-kinds.STATEMENT)
#let example     = ergo-box("Example",     ergo-base-colors.GREEN,  ergo-box-kinds.STATEMENT)
