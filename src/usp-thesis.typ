#import "layout.typ": setup-layout, quote-long
#import "elements.typ": cover, title-page, approval-sheet, abstract-page

/// Main template function for USP theses and dissertations.
/// - title (content): The title of the thesis (in the main language).
/// - title-alt (content): The title in the secondary language (Mandatory for USP).
/// - subtitle (content): The subtitle of the thesis.
/// - author (string): The author's name.
/// - advisor (string): The advisor's name.
/// - coadvisor (string): The co-advisor's name.
/// - degree (string): The degree level ("Mestre" or "Doutor"), or a full title such as "Mestre em Engenharia".
/// - program (string): The graduate program name, e.g. "Estatística" (printed after "Programa: ").
/// - area (string): The concentration area.
/// - institute (string): The USP institute name.
/// - local (string): The city.
/// - year (string, int or auto): The year of deposit (auto: the current year).
/// - version (string): "Original" or "Corrigida".
/// - nature (string): Overrides the inferred "Dissertação" or "Tese".
/// - lang (string): Main document language ("pt" or "en").
/// - abstract-pt (content): The abstract in Portuguese (Mandatory).
/// - keywords-pt (array): List of keywords in Portuguese (Mandatory).
/// - abstract-en (content): The abstract in English (Mandatory).
/// - keywords-en (array): List of keywords in English (Mandatory).
/// - dedication (content): Optional dedication.
/// - acknowledgments (content): Optional acknowledgments.
/// - epigraph (content): Optional epigraph.
/// - errata (content): Optional errata content.
/// - list-of-figures (bool or auto): Whether to include the list of figures (auto: show if >= 5).
/// - list-of-tables (bool or auto): Whether to include the list of tables (auto: show if >= 5).
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
  program: "Nome do Programa",
  area: none,
  institute: "Instituto de Matemática e Estatística",
  local: "São Paulo",
  year: auto,
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
  list-of-figures: auto,
  list-of-tables: auto,
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
      abstract-title: "RESUMO",
      abstract-title-en: "ABSTRACT",
      summary-title: "Sumário",
      cover: "Capa",
      chapter: "Capítulo",
      keywords: "Palavras-chave: ",
      area: "Área de Concentração: ",
      title-msc: "Mestre em Ciências",
      title-phd: "Doutor em Ciências",
      labels: (
        author: "Autor",
        title: "Título",
        approved-on: "Aprovado em",
        banca: "Banca Examinadora",
        judgement: "Julgamento",
      ),
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
      abstract-title: "RESUMO",
      abstract-title-en: "ABSTRACT",
      summary-title: "Contents",
      cover: "Cover",
      chapter: "Chapter",
      keywords: "Keywords: ",
      area: "Concentration Area: ",
      title-msc: "Master of Science",
      title-phd: "Doctor of Science",
      labels: (
        author: "Author",
        title: "Title",
        approved-on: "Approved on",
        banca: "Examination Committee",
        judgement: "Judgement",
      ),
    ),
  ).at(lang)

  // Infer nature and institute-specifics
  // We check for "Mestre" or "Master" to identify Master's degrees
  let is-msc = degree.contains(regex("Mestr|Master"))
  let is-ime = institute.contains(regex("Matemática e Estatística|Mathematics and Statistics"))

  let actual-nature = if nature != none { nature } 
                      else if is-msc { i18n.nature-msc } 
                      else { i18n.nature-phd }

  // A bare degree level ("Mestre", "Doutor") gets the usual USP title
  // ("Mestre em Ciências"); a full title ("Mestre em Engenharia") is kept as is.
  let degree-title = if degree.contains(regex("\s(em|in|of)\s")) { degree }
                     else if is-msc { i18n.title-msc }
                     else { i18n.title-phd }

  let year = if year == auto { str(datetime.today().year()) } else { str(year) }

  let version-text = version + i18n.version

  // Nature text, e.g. "Dissertação apresentada ao IME-USP para obtenção do
  // título de Mestre em Ciências. Programa: Estatística"
  let nature-text = if is-ime {
    if lang == "pt" {
      actual-nature + " apresentada ao IME-USP para obtenção do título de " + degree-title + ". Programa: " + program
    } else {
      actual-nature + " presented to IME-USP in order to obtain the title of " + degree-title + ". Program: " + program
    }
  } else {
    if lang == "pt" {
      let article = if institute.starts-with(regex("Escola|Faculdade")) { " apresentada à " } else { " apresentada ao " }
      actual-nature + article + institute + " da Universidade de São Paulo para obtenção do título de " + degree-title + ". Programa: " + program
    } else {
      actual-nature + " presented to the " + institute + " of the University of São Paulo in order to obtain the title of " + degree-title + ". Program: " + program
    }
  }

  // 1. Cover
  // The cover has no heading: an invisible one gives it a PDF bookmark.
  {
    show heading: none
    heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.cover]
  }
  cover(
    institution: if lang == "pt" { "Universidade de São Paulo\n" + institute } else { "University of São Paulo\n" + institute },
    author: author,
    title: title,
    subtitle: subtitle,
    local: local,
    year: year,
  )

  // Page numbering starts counting from title page (ABNT)
  counter(page).update(1)

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
    area-label: i18n.area,
    advisor: i18n.advisor + advisor,
    coadvisor: if coadvisor != none { i18n.coadvisor + coadvisor } else { none },
    local: local,
    year: year,
  )
  
  // Setup layout for pre-textual elements (margins and heading styles)
  show: setup-layout.with(lang: lang)
  
  // Hide page numbering until Introduction
  set page(numbering: none)

  // 3. Errata (Optional)
  if errata != none {
    heading(level: 1, numbering: none, outlined: false)[#i18n.errata]
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
      labels: i18n.labels,
    )
  }

  // 5. Pre-textual elements
  if dedication != none {
    v(1fr)
    align(right)[#box(width: 60%, dedication)]
    pagebreak()
  }

  if acknowledgments != none {
    heading(level: 1, numbering: none, outlined: false)[#i18n.acknowledgments]
    v(1cm)
    acknowledgments
    pagebreak()
  }

  if epigraph != none {
    v(1fr)
    align(right)[#box(width: 60%, epigraph)]
    pagebreak()
  }

  if abstract-pt != none {
    abstract-page(
      i18n.abstract-title,
      abstract-pt,
      keywords-list: keywords-pt,
      keywords-label: if lang == "pt" { i18n.keywords } else { "Palavras-chave: " },
    )
  }

  if abstract-en != none {
    abstract-page(
      i18n.abstract-title-en,
      abstract-en,
      keywords-list: keywords-en,
      keywords-label: if lang == "en" { i18n.keywords } else { "Keywords: " },
    )
  }
  
  // Lists (Conditional)
  context {
    let figures = query(figure.where(kind: image))
    let tables = query(figure.where(kind: table))
    
    let show-figures = if list-of-figures == auto { figures.len() >= 5 } else { list-of-figures }
    let show-tables = if list-of-tables == auto { tables.len() >= 5 } else { list-of-tables }
    
    if show-figures {
      heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.figures]
      outline(title: none, target: figure.where(kind: image))
      pagebreak()
    }
    
    if show-tables {
      heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.tables]
      outline(title: none, target: figure.where(kind: table))
      pagebreak()
    }
  }
  
  if abbreviations != none {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.abbreviations]
    v(1cm)
    abbreviations
    pagebreak()
  }
  
  if symbols != none {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.symbols]
    v(1cm)
    symbols
    pagebreak()
  }

  // Table of Contents (Sumário) - Must be the last pre-textual element
  heading(level: 1, numbering: none, outlined: false, bookmarked: true)[#i18n.summary-title]
  outline(title: none, indent: auto)
  pagebreak()

  // --- Start of Textual Elements ---
  
  // Show page numbering from here
  set page(numbering: "1", number-align: right + top)

  // Chapter (level-1) references print as "Chapter N"; `appendix` and `annex`
  // override the supplement.
  show heading.where(level: 1): set heading(supplement: i18n.chapter)

  body
}
