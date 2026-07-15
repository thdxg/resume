// Shared base configuration for all documents.
//
// Entry points spread this dict and override only what genuinely differs for
// that document, e.g.:
//
//   #let uservars = (..config.base, fontsize: 11pt)
//
// Later keys win on collision, so keep every *shared* setting here (fonts,
// paper, feature flags) and let each document declare only its deltas. This is
// the single source of truth — changing a shared value here updates every
// document at once.
#let base = (
  paper: "us-letter",
  margin: 0.5in,
  headingfont: "Charter",
  bodyfont: "Charter",
  fontsize: 10pt,
  linespacing: 4pt,
  sectionspacing: 0pt,
  showAddress: false,
  showNumber: false,
  showTitle: false,
  headingsmallcaps: false,
)
