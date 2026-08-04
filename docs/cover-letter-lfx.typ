#import "/lib/config.typ"
#import "/lib/theme.typ"
#import "/lib/components.typ": *

#let cvdata = yaml("/resume.yaml")

// ============================================================================
// Per-application content — edit these for each job.
// ============================================================================
#let greeting = "Dear LFX Mentorship Committee"

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

// Recipient
#greeting

#v(0.4em)

// ============================================================================
// Body
// ============================================================================
Thank you for taking your time to review my application. I’d like this letter to be a chance to share my motivation for this program.

Last Fall, I attended my first KubeCon in Atlanta. KubeCon was full of maintainers of fascinating open-source projects that I had been using every day for my Kubernetes homelab: ArgoCD, OpenTelemetry, Cilium, Tailscale, and much more. But the most inspiring experience was meeting people who kindly offered to guide me through the open-source world. One of them was Nitish Kumar, who shared how LFX Mentorship helped him become part of the CNCF community and now a core maintainer of ArgoCD.

I am interested in LFX Mentorship because I want to become an engineer like Nitish: one who’s expertise opens the door for other people. I want to contribute to projects that I care about and inspire more students like me to be part of the community. As I enter my Master’s program in computer science, I believe this opportunity would help me grow personally and professionally.

I am a developer who works across the stack from low-level systems to user-facing products. Most of my recent focus has been into Huddle Surety, where I'm founding engineer and CTO. Leading a team of engineers, I've architected an AI-native platform that automates surety bond issuance in Go, TypeScript, and Python. I built 100+ REST API endpoints in Go with Redis caching and ReBAC authorization, shipped end-to-end observability with OpenTelemetry and LGTM stack, and provisioned a LiteLLM proxy server for fully-controlled agent observability. Whichever part of the stack I was working on, I cared most about reliability and performance.

Outside work, I enjoy working close to the metal, such as building a terminal emulator or running a Kubernetes homelab on Raspberry Pis. I've also contributed to open-source projects like Next.js, Kubernetes website, and Go Echo framework as I find gaps while working with them professionaly and personally. Working in open source has helped me mature as an engineer with discipline and rigor taking responsibility of widely used products.

I believe my array of skills in OpenTelemetry and AI engineering align well with adding AI provider adapter interface in `otelc`. I am excited to be part of the CNCF community and confident that I would bring significant value to this project.


// ============================================================================
// Signature
// ============================================================================
#v(1em)

Sincerely, \
#v(0.2em)
*#cvdata.personal.name*
