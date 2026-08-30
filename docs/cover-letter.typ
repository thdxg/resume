#import "/lib/config.typ"
#import "/lib/theme.typ"
#import "/lib/components.typ": *

#let cvdata = yaml("/resume.yaml")

// ============================================================================
// Per-application content — edit /cover-letter.yaml for each job.
// ============================================================================
#let letter = yaml("/cover-letter.yaml")

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

#v(0.6em)

Dear Hiring Manager,

#v(0.6em)

// ============================================================================
// Body
// ============================================================================
// I am a developer who works across the stack from low-level systems to user-facing products. Most of my recent focus has been into Huddle Surety, where I'm founding engineer and CTO. Leading a team of engineers, I've architected an AI-native platform that automates surety bond issuance in Go, TypeScript, and Python. I shipped the frontend using TypeScript and React, built 100+ REST API endpoints in Go with Redis caching and ReBAC authorization, and provisioned end-to-end observability with OpenTelemetry and LGTM stack. Whichever part of the stack I was working on, I cared most about reliability and performance.

// Outside work, I enjoy working close to the metal, such as building a terminal emulator or running a Kubernetes homelab on Raspberry Pis. I've also contributed to open-source projects like Next.js, Kubernetes, and Echo as I find gaps while working with them professionally and personally. Working in open source has helped me mature as an engineer with discipline and rigor taking responsibility of widely used products.

// What draws me to #company is building rigorous, high-performance software where reliability and correctness genuinely matter. I'm energized by hard technical problems, and I'd love to bring my instincts in systems and products to the engineering your teams tackle every day. I am excited by the prospect that the engineering impact I make would translate to #impact.

Since choosing software engineering as my career, I have been searching for my niche in the industry. I began at the top of the stack. I designed UIs and published a research paper on human-computer interaction. Building web interfaces intrigued me to build the backend and data layer, where I designed APIs and implemented auth and caching. My internship at a cloud infrastructure team in Summer 2025 was an enlightening experience where I solved problems at scale with cloud-native technologies. Fallen in love with Kubernetes and its open-source community, I architected my own Kubernetes cluster to deploy personal projects and contributed upstream to Kubernetes, Next.js, and Echo framework. I went further down to work closely to the metal and operating system, as I entered CMU's master's program with a focus on distributed systems.

I've journeyed through the modern technology stack from top to bottom; I can build the frontend, backend, and the infrastructure to run them on. Counterproductively to my niche-searching, there wasn't a part that I didn't enjoy learning or building. Each layer of the stack came with different problems but taught the same lesson: there's always more than what I know. In today's world, maybe what I need is the passion and vision, not a niche.

#letter.motivation

I distinguish myself as a disciplined and curious learner with a breadth of engineering experience. Being a #letter.position at #letter.company is an opportunity that I am ready to make the most out of, and I hope my qualities include what you are looking for.

#v(0.6em)

Sincerely, \
#v(0.2em)
*#cvdata.personal.name*
