#import "/lib/config.typ"
#import "/lib/theme.typ"
#import "/lib/components.typ": *

#let cvdata = yaml("/resume.yaml")

// ============================================================================
// Per-application content — edit these for each job.
// ============================================================================
#let company = "Voloridge"
#let impact = "a superior investment platform"
#let letterdate = datetime.today().display("[month repr:long] [day], [year]")
#let greeting = "Dear Hiring Manager,"

// ============================================================================
// Configuration — shared base, overriding only the letter-specific deltas.
// (fontsize/margin/linespacing legitimately differ from the resume; everything
// else comes from /lib/config.typ.)
// ============================================================================
#let uservars = (
  ..config.base,
  fontsize: 11pt,
  margin: (x: 0.9in, y: 0.9in),
  linespacing: 6pt,
)

#show: doc => theme.apply(uservars, doc)

#set par(justify: true, leading: uservars.linespacing, spacing: 1.1em)

// ============================================================================
// Header — left-aligned name with a trimmed contact line (email + website)
// ============================================================================
#letterheading(cvdata)

#v(1.2em)

// Date
#letterdate

#v(0.6em)

// Recipient
#greeting

#v(0.4em)

// ============================================================================
// Body
// ============================================================================
I am a developer who works across the stack from low-level systems to
user-facing products. Most of my recent focus has been into Huddle Surety,
where I'm founding engineer and CTO. Leading a team of engineers, I've
architected an AI-native platform that automates surety bond issuance in Go,
TypeScript, and Python. I shipped the frontend using TypeScript and React,
built 100+ REST API endpoints with Go and Postgres, and managed CI/CD
pipelines in a Kubernetes cluster. Whichever part of the stack I was working
on, I cared most about reliability and performance.

Outside work, I enjoy building close to the metal, such as building a terminal
emulator or running a Kubernetes homelab on Raspberry Pis. I've also
contributed to tools like Next.js, Kubernetes, and Echo as an avid user as I
find gaps while working with them. Working in open source has helped me mature
as an engineer with discipline and rigor, as users around the world rely on
software I built.

What draws me to #company is building rigorous, high-performance software where
reliability and correctness genuinely matter. I'm energized by hard technical
problems, and I'd love to bring my instincts in systems and products to the
engineering your teams tackle every day. I am excited by the prospect that the
engineering impact I make would translate to #impact.

// ============================================================================
// Signature
// ============================================================================
#v(1em)

Sincerely, \
#v(0.2em)
*#cvdata.personal.name*
