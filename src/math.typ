#import "@preview/ctheorems:1.1.3": *

#let argmax = math.op("argmax")
#let argmin = math.op("argmin")
#let bm(x) = math.bold(x)
#let tr = math.op("tr")
#let diag = math.op("diag")
#let Cov = math.op("Cov")
#let Var = math.op("Var")
#let EE = math.bb("E")
#let RR = math.bb("R")

// Theorem environments setup
#let thm-rules(body) = {
  show: thmrules
  body
}

#let theorem = thmbox("theorem", "Teorema", fill: rgb("#eeeeeef0"))
#let lemma = thmbox("lemma", "Lema", fill: rgb("#eeeeeef0"))
#let corollary = thmplain("corollary", "Corolário", base: "theorem", titlefmt: strong)
#let definition = thmbox("definition", "Definição", inset: (x: 1.2em, y: 1em))
#let proof = thmproof("proof", "Prova")

// English aliases
#let en-theorem = thmbox("theorem", "Theorem", fill: rgb("#eeeeeef0"))
#let en-lemma = thmbox("lemma", "Lemma", fill: rgb("#eeeeeef0"))
#let en-corollary = thmplain("corollary", "Corollary", base: "theorem", titlefmt: strong)
#let en-definition = thmbox("definition", "Definition", inset: (x: 1.2em, y: 1em))
#let en-proof = thmproof("proof", "Proof")
