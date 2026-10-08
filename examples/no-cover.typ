#import "../src/lib.typ": *

// Abstract, table of contents and text, without the cover and title page.
#show: usp-thesis.with(
  title: [Amostra das Funcionalidades do Modelo USP],
  author: "Candidato Exemplar",
  advisor: "Prof. Dr. Orientador Sábio",
  program: "Ciência da Computação",
  cover: false,
  title-page: false,
  abstract-pt: [Este documento omite a capa e a folha de rosto.],
  keywords-pt: ("Typst", "Modelo"),
)

= Introdução

O sumário e o resumo continuam presentes.

= Conclusão

Fim.
