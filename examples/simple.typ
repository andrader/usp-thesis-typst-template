#import "../src/lib.typ": *

#show: usp-thesis.with(
  title: [Amostra das Funcionalidades do Modelo USP],
  author: "Candidato Exemplar",
  advisor: "Prof. Dr. Orientador Sábio",
  institute: "Instituto de Matemática e Estatística",
  program: "Ciência da Computação",
  degree: "Mestre",
  local: "São Paulo",
  year: "2024",
)

// Applying theorem rules
#show: thm-rules

= Introdução

Este documento demonstra as novas funcionalidades (os "goodies") portados do modelo LaTeX original para Typst. #todo[Adicionar mais exemplos de subfiguras.]

== Matemática e Teoremas

Podemos definir teoremas e definições facilmente:

#definition[
  Um *Espaço Topológico* é um par $(X, tau)$ onde $X$ é um conjunto e $tau$ é uma coleção de subconjuntos de $X$ satisfazendo os axiomas de união e interseção.
]

#theorem[Teorema Fundamental][
  Se uma função é contínua, então ela é integrável.
]

#proof[
  A prova segue por indução no número de sub-intervalos.
]

== Unidades e Números

Utilizando o pacote `unify`, garantimos a formatação correta de grandezas científicas:
- A aceleração da gravidade é aproximadamente #qty(9.81, "m/s^2").
- O valor de $pi$ com muitas casas decimais é #num(3.14159265).

== Subfiguras

Podemos usar o pacote `subpar` para agrupar figuras:

#subpar.grid(
  figure(rect(width: 80%, height: 2cm, fill: blue), caption: [Subfigura A]),
  figure(rect(width: 80%, height: 2cm, fill: red), caption: [Subfigura B]),
  columns: (1fr, 1fr),
  caption: [Exemplo de figuras lado a lado.],
  label: <fig:grid>,
)

== Tabelas Acadêmicas

Utilizamos ajudantes para criar tabelas com o estilo `booktabs`:

#figure(
  table(
    columns: 3,
    toprule,
    [Item], [Quantidade], [Preço],
    midrule,
    [Papel], [100], [R\$ 5,00],
    [Caneta], [10], [R\$ 2,00],
    bottomrule,
  ),
  caption: [Exemplo de tabela com estilos acadêmicos.],
)
