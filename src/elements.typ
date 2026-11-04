// Elements for USP theses and dissertations

#let cover(
  institution: none,
  author: none,
  title: none,
  subtitle: none,
  volumes: none,
  local: none,
  year: none,
) = {
  set page(margin: 3cm)
  set align(center)
  set text(size: 12pt)

  if institution != none {
    upper(institution)
    v(1cm)
  }

  v(3cm)
  upper(author)

  v(4cm)
  text(14pt, strong(upper(title)))
  if subtitle != none {
    [: ]
    text(14pt, strong(upper(subtitle)))
  }

  if volumes != none {
    v(1cm)
    [Volume #volumes]
  }

  v(1fr)
  [#local \ #year]
  
  pagebreak()
}

/// Title page (folha de rosto), laid out as in the IME-USP model: author and
/// title in normal case, then a right-aligned block with the nature of the work,
/// the program, the advisor, and the city and month/year at the foot.
/// - version (content or none): A bold label under the title, for versions
///   without their own page; none omits it.
/// - program (string or none): The program line, already labelled.
/// - date (content): Month and year.
#let title-page(
  author: none,
  title: none,
  subtitle: none,
  version: none,
  volumes: none,
  nature: none,
  program: none,
  area: none,
  area-label: "Área de Concentração: ",
  advisor: none,
  coadvisor: none,
  local: none,
  date: none,
) = {
  set page(margin: 3cm)
  set align(center)

  author

  v(4cm)
  text(14pt, strong(title))
  if subtitle != none {
    text(14pt, strong[: ])
    text(14pt, strong(subtitle))
  }

  if version != none {
    v(2cm)
    strong(version)
  }

  v(2cm)
  align(right)[
    #box(width: 50%)[
      #set align(left)
      #set text(size: 10pt)
      #nature

      #if program != none [#program]

      #if area != none [#area-label #area]

      #advisor
      #if coadvisor != none [\ #coadvisor]
    ]
  ]

  v(1fr)
  [#local \ #date]

  pagebreak()
}

/// "Original version" page, as in the IME-USP model: it repeats the author and
/// the title of the title page, with the statement in a right-aligned block.
/// - statement (content): The sentence of the block.
#let version-page(
  author: none,
  title: none,
  subtitle: none,
  statement: none,
) = {
  set page(margin: 3cm)
  set align(center)

  author

  v(4cm)
  text(14pt, strong(title))
  if subtitle != none {
    text(14pt, strong[: ])
    text(14pt, strong(subtitle))
  }

  v(2cm)
  align(right)[
    #box(width: 50%)[
      #set align(left)
      #set text(size: 10pt)
      #statement
    ]
  ]

  pagebreak()
}

#let approval-sheet(
  author: none,
  title: none,
  subtitle: none,
  nature: none,
  date: "____/____/____",
  banca: (),
  labels: (
    author: "Autor",
    title: "Título",
    approved-on: "Aprovado em",
    banca: "Banca Examinadora",
    judgement: "Julgamento",
  ),
  is-branded: false,
) = {
  set page(margin: 3cm)
  set text(size: 12pt)
  
  [#labels.author: #author \ ]
  [#labels.title: #strong(title)]
  if subtitle != none [: #strong(subtitle)]
  
  v(1cm)
  nature
  if not nature.ends-with(".") [.]
  
  v(1cm)
  [#labels.approved-on: #date]
  
  v(1cm)
  align(center)[#labels.banca]
  v(0.5cm)
  
  for membro in banca [
    #v(1cm)
    #line(length: 100%, stroke: 0.5pt)
    #membro.nome \
    #membro.instituicao \
    #labels.judgement: #line(length: 3cm, stroke: 0.5pt)
  ]
  
  pagebreak()
}

#let abstract-page(
  title,
  body,
  keywords-list: (),
  keywords-label: "Palavras-chave: ",
  reference: none,
) = {
  heading(level: 1, numbering: none, outlined: false)[#title]
  
  set align(left)
  if reference != none {
    set text(size: 10pt)
    reference
    v(1cm)
  }
  
  set par(justify: true, leading: 0.5em)
  body
  
  v(1cm)
  strong([#keywords-label])
  keywords-list.join([. ])
  [.]
  
  pagebreak()
}
