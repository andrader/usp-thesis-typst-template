#import "../src/lib.typ": *

// Only the chapters, without cover, abstracts or table of contents: handy for
// sharing a draft chapter. Set `front-matter: true` (the default) for the thesis.
#show: usp-thesis.with(
  title: [Amostra das Funcionalidades do Modelo USP],
  author: "Candidato Exemplar",
  advisor: "Prof. Dr. Orientador Sábio",
  program: "Ciência da Computação",
  front-matter: false,
)

#show: thm-rules

= Introdução <cap:intro>

Este documento contém apenas o texto, no mesmo layout da tese. O @cap:metodo
descreve o método.

#theorem[Teorema Fundamental][
  Se uma função é contínua, então ela é integrável.
]

= Método <cap:metodo>

A aceleração da gravidade é aproximadamente #qty(9.81, "m/s^2").

#show: appendix
= Demonstrações

A prova segue por indução no número de sub-intervalos.
