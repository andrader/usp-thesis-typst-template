#import "@preview/drafting:0.2.2": margin-note

// Layout settings for USP theses and dissertations

#let setup-layout(lang: "pt", body) = {
  // Paper and Margins
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      left: 3cm,
      right: 2cm,
      bottom: 2cm,
    ),
  )

  // Typography
  set text(
    font: "New Computer Modern", 
    size: 12pt,
    lang: lang,
  )

  // Spacing
  set par(
    leading: 0.65em, 
    justify: true,
  )
  
  // Rule for 1.5 line spacing
  set par(spacing: 1.5em)

  // Section numbering
  set heading(numbering: "1.1.1.1.1")
  
  // Section styling
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5cm)
    set text(size: 14pt, weight: "bold")
    if it.numbering == none {
      // Pre-textual elements: Centered and All Caps
      align(center, upper(it.body))
    } else {
      // Textual chapters: Bold, 14pt, keep case as provided
      it
    }
    v(1.5cm)
  }

  show heading.where(level: 2): it => {
    v(1em)
    set text(size: 12pt, weight: "bold")
    it
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(0.5em)
    set text(size: 12pt, weight: "bold")
    it
    v(0.5em)
  }

  // Table of Contents styling
  show outline.entry.where(level: 1): it => {
    v(1em, weak: true)
    if it.element.func() == heading and it.element.numbering == none {
      strong(upper(it))
    } else {
      strong(it)
    }
  }

  // Captions and Tables
  show figure: set text(size: 10pt)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: top) 

  body
}

// Special formatting for long quotes (> 3 lines)
#let quote-long(body) = {
  set text(size: 10pt)
  set par(leading: 0.5em, justify: true)
  pad(left: 4cm, body)
}

// Table helpers (booktabs style)
#let toprule = table.hline(stroke: 1.5pt)
#let midrule = table.hline(stroke: 0.8pt)
#let bottomrule = table.hline(stroke: 1.5pt)

// Drafting / TODO notes
#let todo(content) = margin-note(stroke: orange + 1pt, fill: orange.lighten(80%), content)
