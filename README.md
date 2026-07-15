# Resume & Cover Letter

Declarative resume and cover letter built with Typst.

## Preview

![resume](./assets/Taehoon_Lee_resume.png)

## Usage

- Edit resume content in [resume.yaml](./resume.yaml).
- Edit the cover letter (company, greeting, prose) at the top of
  [docs/cover-letter.typ](./docs/cover-letter.typ).
- Run `mise run compile:all` to generate PDF + PNG for both documents.

Compile or preview a single document:

```
mise run compile resume pdf
mise run compile cover-letter png
mise run preview resume
```

See [mise.toml](./mise.toml) for all commands.
