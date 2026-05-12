#import "usp-thesis.typ": usp-thesis
#import "layout.typ": quote-long, todo, toprule, midrule, bottomrule
#import "math.typ": *

// Re-exporting common packages for the user
#import "@preview/unify:0.6.0": num, qty
#import "@preview/subpar:0.2.2" as subpar

// --- Constants (Pseudo-Enums) ---

/// Document languages
#let langs = (
  pt: "pt",
  en: "en",
)

/// Degree levels (Official USP Nomenclature)
#let degrees = (
  msc: "Mestre em Ciências",
  phd: "Doutor em Ciências",
)

/// Document versions
#let versions = (
  original: "Original",
  revised: "Corrigida",
)
