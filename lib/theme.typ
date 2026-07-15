// Generic document theme: page geometry, text defaults, and heading styling.
// Knows nothing about the CV data shape — it only reads `uservars`, so any
// document (resume, cover letter, …) can share the same look.

// Base rules: fonts, spacing, and page setup.
#let setrules(uservars, doc) = {
  set text(
    font: uservars.bodyfont,
    size: uservars.fontsize,
    hyphenate: false,
  )

  set list(
    body-indent: 2.5pt,
    spacing: uservars.linespacing,
  )

  set par(
    leading: uservars.linespacing,
    justify: false,
  )

  set page(
    paper: uservars.paper,
    margin: uservars.margin,
  )

  doc
}

// Show rules: section headings, name heading, and link styling.
#let showrules(uservars, doc) = {
  // Uppercase section headings
  show heading.where(
    level: 2,
  ): it => block(width: 100%)[
    #v(uservars.sectionspacing)
    #set align(left)
    #set text(font: uservars.headingfont, size: 1em, weight: "bold")
    #upper(it.body)
    #v(-0.8em) #line(length: 100%, stroke: 1pt + black)
  ]

  // Name title/heading
  show heading.where(
    level: 1,
  ): it => block(width: 100%)[
    #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
    #if (uservars.at("headingsmallcaps", default: false)) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }
  ]

  show link: it => text[
    #it
  ]

  doc
}

// Apply the full theme in a single show rule:
//   #show: doc => theme.apply(uservars, doc)
#let apply(uservars, doc) = showrules(uservars, setrules(uservars, doc))
