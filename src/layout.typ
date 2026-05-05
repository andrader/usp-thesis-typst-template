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
    font: "Libertinus Serif", 
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
  show heading: it => {
    let size = if it.level == 1 { 14pt } else { 12pt }
    set text(size: size, weight: "bold")
    if it.level == 1 {
      pagebreak(weak: true)
      v(1.5cm)
    }
    it
    v(1.5cm)
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
