#import "../src/lib.typ": *

// Latex-style font
#set text(font: "New Computer Modern")

#show: usp-thesis.with(
  title: [Development of Typst Templates for USP],
  title-alt: [Desenvolvimento de Templates Typst para a USP],
  author: "Joã da Silva",
  advisor: "Prof. Dr. Exemplary Advisor",
  institute: "Institute of Mathematics and Statistics",
  program: "Graduate Program in Statistics",
  degree: degrees.msc,
  local: "São Paulo",
  year: "2024",
  lang: langs.en,
  version: versions.original,
  abstract-pt: [
    Este trabalho descreve a criação de um template Typst para dissertações e teses seguindo as diretrizes da USP. O template automatiza a formatação de capas, resumos e elementos pré-textuais.
  ],
  keywords-pt: ("Typst", "USP", "Dissertação", "Automação"),
  abstract-en: [
    This work describes the creation of a Typst template for theses and dissertations following USP guidelines. The template automates the formatting of covers, abstracts, and pre-textual elements.
  ],
  keywords-en: ("Typst", "USP", "Thesis", "Automation"),
  dedication: [To my family.],
  acknowledgments: [I would like to thank USP and CAPES for their support.],
  epigraph: ["Success is the sum of small efforts, repeated day in and day out." \ --- Robert Collier],
  errata: [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      [Page], [Line], [Read], [Correction],
      [10], [5], [Typstt], [Typst],
    )
  ],
  abbreviations: [
    #grid(
      columns: (100pt, 1fr),
      row-gutter: 1em,
      [ABNT], [Brazilian Association of Technical Standards],
      [USP], [University of São Paulo],
      [IME], [Institute of Mathematics and Statistics],
    )
  ],
  symbols: [
    #grid(
      columns: (100pt, 1fr),
      row-gutter: 1em,
      [$sigma$], [Standard deviation],
      [$mu$], [Population mean],
    )
  ],
  banca: (
    (nome: "Prof. Dr. Examiner 1", instituicao: "IME-USP"),
    (nome: "Prof. Dr. Examiner 2", instituicao: "IME-USP"),
    (nome: "Prof. Dr. External Examiner", instituicao: "UNICAMP"),
  ),
)

= Introduction

USP requires strict formatting for academic works. This template aims to facilitate this process for English speakers @typst.

#figure(
  rect(width: 100pt, height: 50pt, fill: blue.lighten(80%))[Logo],
  caption: [Example illustration],
) <fig-example>

= Methodology

We used the Typst language for its speed and ease of use compared to LaTeX.

#figure(
  table(
    columns: (auto, auto),
    [Feature], [Benefit],
    [Speed], [Instant compilation],
    [Syntax], [Easy to read and write],
  ),
  caption: [Feature comparison],
) <tab-features>

= Results

The template can generate PDFs compatible with the ABNT standards adopted by USP.

= Conclusion

Typst is a viable alternative for writing theses at USP.

#bibliography("refs.bib")

// --- Post-textual ---

= Glossary

/ Typst: A new markup-based typesetting system that is designed to be as powerful as LaTeX while being much easier to learn and use.

#set heading(numbering: "A.1")
#counter(heading).update(0)

= Appendix A - Implementation Details
This appendix contains technical details about the layout functions.

#set heading(numbering: "I.1")
#counter(heading).update(0)

= Annex I - Graduate Regulations
Official USP documentation.
