// CV content components. Each renders a section from the YAML data (`info`)
// using `uservars` for styling. Generic page/heading theming lives in
// `/lib/theme.typ`; date helpers in `/lib/utils.typ`.
#import "/lib/utils.typ"

// Job titles
#let jobtitletext(info, uservars) = {
  if (
    ("titles" in info.personal and info.personal.titles != none)
      and uservars.showTitle
  ) {
    block(width: 100%)[
      *#info.personal.titles.join("  /  ")*
    ]
  } else { none }
}

// Address
#let addresstext(info, uservars) = {
  if (
    ("location" in info.personal and info.personal.location != none)
      and uservars.showAddress
  ) {
    // Filter out empty address fields
    let address = info
      .personal
      .location
      .pairs()
      .filter(it => it.at(1) != none and str(it.at(1)) != "")
    // Join non-empty address fields with commas
    let location = address.map(it => str(it.at(1))).join(", ")

    block(width: 100%)[
      #location
      #v(-4pt)
    ]
  } else { none }
}

#let contacttext(info, uservars) = block(width: 100%)[
  #let profiles = (
    if ("visa" in info.personal) and (info.personal.visa != none) {
      box(info.personal.visa)
    },
    if ("email" in info.personal) and (info.personal.email != none) {
      box(info.personal.email)
    },
    if ("url" in info.personal) and (info.personal.url != none) {
      box(link(info.personal.url)[#info.personal.url.split("//").at(1)])
    },
  ).filter(it => it != none) // Filter out none elements from the profile array

  #if ("profiles" in info.personal) and (info.personal.profiles.len() > 0) {
    for profile in info.personal.profiles {
      profiles.push(
        box(link(profile.url)[#profile.url.split("//").at(1)]),
      )
    }
  }

  #set text(
    font: uservars.bodyfont,
    weight: "medium",
    size: uservars.fontsize * 1,
  )
  #pad(x: 0em)[
    #profiles.join([#sym.space #sym.dot #sym.space])
  ]
]

#let cvheading(info, uservars) = {
  align(center)[
    = #info.personal.name
    #jobtitletext(info, uservars)
    #addresstext(info, uservars)
    #contacttext(info, uservars)
  ]
}

// Cover-letter header: left-aligned name with a trimmed contact line
// (email + website only, no profile links). Kept separate from `cvheading`
// so the resume header is unaffected.
#let letterheading(info) = {
  let contacts = (
    if ("email" in info.personal) and (info.personal.email != none) {
      box(info.personal.email)
    },
    if ("url" in info.personal) and (info.personal.url != none) {
      box(link(info.personal.url)[#info.personal.url.split("//").at(1)])
    },
  ).filter(it => it != none)

  align(left)[
    = #info.personal.name
    #contacts.join([#sym.space #sym.dot #sym.space])
  ]
}

#let cveducation(info, title: "Education", isbreakable: true) = {
  if ("education" in info) and (info.education != none) {
    block[
      == #title
      #for edu in info.education {
        let end = utils.strpdate(edu.endDate)

        let edu-items = ""
        if ("honors" in edu) and (edu.honors != none) {
          edu-items = edu-items + "- *Honors*: " + edu.honors.join(", ") + "\n"
        }
        if ("courses" in edu) and (edu.courses != none) {
          edu-items = (
            edu-items + "- *Courses*: " + edu.courses.join(", ") + "\n"
          )
        }
        if ("highlights" in edu) and (edu.highlights != none) {
          for hi in edu.highlights {
            edu-items = edu-items + "- " + hi + "\n"
          }
          edu-items = edu-items.trim("\n")
        }

        block(width: 100%, breakable: isbreakable, below: 1em)[
          #if ("url" in edu) and (edu.url != none) [
            *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
          ] else [
            *#edu.institution* #h(1fr) *#edu.location* \
          ]
          #if ("area" in edu) and (edu.area != none) [
            #let degree-str = if type(edu.area) == array {
              edu.area.map(a => a.studyType + " in " + a.name).join(", ")
            } else {
              edu.studyType + " in " + edu.area
            }
            #text(style: "italic")[#degree-str] #h(1fr)
          ] else [
            #text(style: "italic")[#edu.studyType] #h(1fr)
          ]
          #utils.daterange(none, end) \
          #eval(edu-items, mode: "markup")
        ]
      }
    ]
  }
}

#let cvwork(info, title: "Work Experience", isbreakable: true) = {
  if ("work" in info) and (info.work != none) {
    block[
      == #title
      #for w in info.work {
        block(width: 100%, breakable: isbreakable, below: 1em)[
          *#w.position* #h(1fr) *#w.location* \
          #let start = utils.strpdate(w.startDate)
          #let end = utils.strpdate(w.endDate)
          #text(style: "italic")[#w.organization] #h(1fr)
          #utils.daterange(start, end) \
          #for hi in w.highlights [
            - #eval(hi, mode: "markup")
          ]
        ]
      }
    ]
  }
}

#let cvprojects(info, title: "Projects", isbreakable: true) = {
  if ("projects" in info) and (info.projects != none) {
    block[
      == #title
      #for project in info.projects {
        block(width: 100%, breakable: isbreakable, below: 1em)[
          *#project.name*  #h(1fr) #link(project.link)[#project.link.split("//").at(1)] \
          #for hi in project.highlights [
            - #eval(hi, mode: "markup")
          ]
        ]
      }
    ]
  }
}

#let cvskills(info, title: "Skills", isbreakable: true) = {
  block(breakable: isbreakable)[
    == #title
    #for group in info.skills [
      - *#group.category*: #group.skills.join(", ")
    ]
    // Invisible keywords for ATS/machine parsing. Placed within the Skills
    // section so the terms sit alongside the real skills. Rendered tiny and
    // white via `place` so it stays in the PDF text layer (machine-readable)
    // with no visible mark and no layout impact.
    #if ("keywords" in info) and (info.keywords != none) and (info.keywords.len() > 0) {
      place(top + left)[
        #text(size: 1pt, fill: white)[#info.keywords.join(", ")]
      ]
    }
  ]
}
