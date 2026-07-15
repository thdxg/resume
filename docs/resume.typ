#import "/lib/config.typ"
#import "/lib/theme.typ"
#import "/lib/components.typ": *

#let cvdata = yaml("/resume.yaml")

// Resume is the baseline document — it uses the shared config as-is.
#let uservars = config.base

#show: doc => theme.apply(uservars, doc)

#cvheading(cvdata, uservars)
#cveducation(cvdata)
#cvskills(cvdata)
#cvwork(cvdata)
#cvprojects(cvdata)
