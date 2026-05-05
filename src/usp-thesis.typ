#import "layout.typ": setup-layout, quote-long
#import "elements.typ": cover, title-page, approval-sheet, abstract-page

/// Main template function for USP theses and dissertations.
/// - title (content): The title of the thesis (in the main language).
/// - title-alt (content): The title in the secondary language (Mandatory for USP).
/// - subtitle (content): The subtitle of the thesis.
/// - author (string): The author's name.
/// - advisor (string): The advisor's name.
/// - coadvisor (string): The co-advisor's name.
/// - degree (string): The degree (e.g., "Mestre", "Doutor").
/// - program (string): The graduate program name.
/// - area (string): The concentration area.
/// - institute (string): The USP institute name.
/// - local (string): The city.
/// - year (string): The year of deposit.
/// - version (string): "Original" or "Corrigida".
/// - nature (string): "Dissertação" or "Tese".
/// - lang (string): Main document language ("pt" or "en").
/// - abstract-pt (content): The abstract in Portuguese (Mandatory).
/// - keywords-pt (array): List of keywords in Portuguese (Mandatory).
/// - abstract-en (content): The abstract in English (Mandatory).
/// - keywords-en (array): List of keywords in English (Mandatory).
/// - dedication (content): Optional dedication.
/// - acknowledgments (content): Optional acknowledgments.
/// - epigraph (content): Optional epigraph.
/// - errata (content): Optional errata content.
/// - list-of-figures (bool): Whether to include the list of figures.
/// - list-of-tables (bool): Whether to include the list of tables.
/// - abbreviations (content): Optional list of abbreviations.
/// - symbols (content): Optional list of symbols.
/// - banca (array): List of jury member dictionaries ((nome: "", instituicao: "")).
/// - body (content): The document body.
#let usp-thesis(
  title: [Título da Dissertação],
  title-alt: none, 
  subtitle: none,
  author: "Nome do Autor",
  advisor: "Nome do Orientador",
  coadvisor: none,
  degree: "Mestre",
  program: "Programa de Pós-Graduação",
  area: none,
  institute: "Instituto de Matemática e Estatística",
  local: "São Paulo",
  year: "2024",
  version: "Original",
  nature: none, 
  lang: "pt",
  abstract-pt: none,
  keywords-pt: (),
  abstract-en: none,
  keywords-en: (),
  dedication: none,
  acknowledgments: none,
  epigraph: none,
  errata: none,
  list-of-figures: false,
  list-of-tables: false,
  abbreviations: none,
  symbols: none,
  banca: (),
  body,
) = {
  // Set global language for hyphenation and built-in terms (e.g. outline title)
  set text(lang: lang)

  // Dictionary for custom localized strings
  let i18n = (
    pt: (
      version: " Versão",
      advisor: "Orientador: ",
      coadvisor: "Coorientador: ",
      acknowledgments: "AGRADECIMENTOS",
      nature-msc: "Dissertação",
      nature-phd: "Tese",
      errata: "ERRATA",
      figures: "Lista de Ilustrações",
      tables: "Lista de Tabelas",
      abbreviations: "Lista de Abreviaturas e Siglas",
      symbols: "Lista de Símbolos",
    ),
    en: (
      version: " Version",
      advisor: "Advisor: ",
      coadvisor: "Co-advisor: ",
      acknowledgments: "ACKNOWLEDGMENTS",
      nature-msc: "Master's Dissertation",
      nature-phd: "Doctoral Thesis",
      errata: "ERRATA",
      figures: "List of Figures",
      tables: "List of Tables",
      abbreviations: "List of Abbreviations and Acronyms",
      symbols: "List of Symbols",
    ),
  ).at(lang)

  // Infer nature if not provided
  let actual-nature = if nature != none { nature } 
                      else if degree == "Mestre" { i18n.nature-msc } 
                      else { i18n.nature-phd }

  let version-text = version + i18n.version

  // IMEUSP specific nature text
  let nature-text = if institute.contains("Matemática e Estatística") {
    if degree == "Mestre" {
      "Dissertação apresentada para o IME-USP para obtenção do grau de mestre"
    } else {
      "Tese apresentada para o IME-USP para obtenção do grau de doutor"
    }
  } else {
    actual-nature + " apresentada ao " + institute + " da Universidade de São Paulo para obtenção do título de " + degree + " em " + program
  }

  // 1. Cover
  cover(
    institution: "Universidade de São Paulo\n" + institute,
    author: author,
    title: title,
    subtitle: subtitle,
    local: local,
    year: year,
  )

  // 2. Title Page
  title-page(
    author: author,
    title: title,
    subtitle: subtitle,
    version: version-text,
    nature: nature-text,
    institute: institute,
    degree: degree,
    program: program,
    area: area,
    advisor: i18n.advisor + advisor,
    coadvisor: if coadvisor != none { i18n.coadvisor + coadvisor } else { none },
    local: local,
    year: year,
  )
  
  // 3. Errata (Optional)
  if errata != none {
    set page(margin: 3cm)
    align(center, strong[#i18n.errata])
    v(1cm)
    errata
    pagebreak()
  }

  // 4. Approval Sheet
  if banca.len() > 0 {
    approval-sheet(
      author: author,
      title: title,
      subtitle: subtitle,
      nature: nature-text,
      banca: banca,
    )
  }

  // 5. Pre-textual elements
  if dedication != none {
    set page(margin: 3cm)
    v(1fr)
    align(right)[#box(width: 60%, dedication)]
    pagebreak()
  }

  if acknowledgments != none {
    set page(margin: 3cm)
    align(center, strong[#i18n.acknowledgments])
    v(1cm)
    acknowledgments
    pagebreak()
  }

  if epigraph != none {
    set page(margin: 3cm)
    v(1fr)
    align(right)[#box(width: 60%, epigraph)]
    pagebreak()
  }

  if abstract-pt != none {
    abstract-page(
      title: "RESUMO",
      lang: "pt",
      keywords: keywords-pt,
      abstract-pt
    )
  }

  if abstract-en != none {
    abstract-page(
      title: "ABSTRACT",
      lang: "en",
      keywords: keywords-en,
      abstract-en
    )
  }
  
  // Lists
  if list-of-figures {
    outline(title: i18n.figures, target: figure.where(kind: image))
    pagebreak()
  }
  
  if list-of-tables {
    outline(title: i18n.tables, target: figure.where(kind: table))
    pagebreak()
  }
  
  if abbreviations != none {
    align(center, strong[#i18n.abbreviations])
    v(1cm)
    abbreviations
    pagebreak()
  }
  
  if symbols != none {
    align(center, strong[#i18n.symbols])
    v(1cm)
    symbols
    pagebreak()
  }

  // Table of Contents
  outline(title: auto, indent: auto)
  pagebreak()

  // 6. Main Content Layout
  show: setup-layout.with(lang: lang)
  
  // Page numbering starts counting from title page (page 2), but visible from here
  set page(numbering: "1", number-align: right + top)
  counter(page).update(1)

  body
}
