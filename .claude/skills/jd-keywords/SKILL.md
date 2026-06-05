---
name: jd-keywords
description: Given a job-description URL, fetch the posting and generate 10-15 ATS keywords that best match the role, then write them into resume.yaml's invisible `keywords` list and recompile the PDF. Use when the user provides a job posting URL and wants the resume's hidden keywords tailored to it.
---

# JD Keywords

Tailor the resume's invisible (ATS-only) keyword list to a specific job posting.

## Context

This resume project stores keywords in a top-level `keywords:` list in `resume.yaml`.
They render as 1pt white text inside the Skills section (see `cvskills` in
`src/cv.typ`) — invisible to humans, but present in the PDF's extractable text
layer for ATS/AI screeners. This skill regenerates that list to match a given
job description and recompiles the PDF.

## Inputs

- A job-description URL provided by the user (the skill argument or in their message).

## Steps

1. **Fetch the job description.** Use WebFetch on the URL with a prompt like:
   "Extract the full job description: role title, required and preferred skills,
   technologies, responsibilities, and any repeated terminology." If WebFetch is
   blocked or returns little (some job boards are JS-gated or auth-walled), tell
   the user and ask them to paste the JD text instead — do not guess.

2. **Read the candidate's background** from `resume.yaml` (work, projects,
   skills sections) so keywords can be weighted toward what the candidate
   actually does.

3. **Generate 10-15 keywords.** Optimize for **maximum job-description match**:
   - Pull the exact terminology the posting uses (mirror its phrasing — e.g. if
     the JD says "Site Reliability Engineering", use that, not "SRE", unless both
     appear).
   - Prioritize required skills, named technologies, and role-defining concepts.
   - Prefer multi-word domain phrases ATS matches on ("Distributed Systems",
     "Event-Driven Architecture") over bare single words already visible in the
     Skills section.
   - Avoid duplicating terms already visible in `resume.yaml`'s `skills` lists —
     the hidden list should add coverage, not repeat.
   - De-duplicate; keep each keyword distinct. Land between 10 and 15 entries.

4. **Truthfulness caution (one line).** After listing the keywords, flag any that
   the candidate's resume does NOT support, e.g.:
   "⚠️ Not backed by your resume: Kafka, Terraform — a recruiter who reveals the
   hidden text may ask about these." This is informational; proceed regardless
   unless the user objects.

5. **Write to `resume.yaml`.** Replace the entire `keywords:` list with the new
   keywords. Preserve the existing comment line above the list. Use exact YAML
   list syntax matching the file (two-space indent, `  - Keyword`).

6. **Recompile and verify** from the repo root:
   ```
   typst compile ./src/resume.typ ./assets/resume.pdf --root .
   typst compile ./src/resume.typ ./assets/resume.png --root .
   ```
   Then verify:
   - Page count unchanged (still 1 page): `pdfinfo ./assets/resume.pdf | grep Pages`
   - Keywords extractable: `pdftotext ./assets/resume.pdf - | grep -i "<one keyword>"`
   - PNG byte size unchanged vs. before (zero visible change) — if it changed,
     investigate; the keywords should never alter the visible layout.

7. **Report.** Show the final keyword list, the truthfulness caution (if any),
   and confirm: page count, extractability, and that the visible PDF is unchanged.

## Notes

- Keep keywords role-relevant; a focused 10-15 beats a stuffed list (over-stuffing
  is itself an ATS manipulation signal).
- If the user gives a URL for a role very different from the resume's focus, still
  match the JD as instructed, but make the truthfulness caution explicit.
