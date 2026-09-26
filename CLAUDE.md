# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

The content + asset repository for the **claude.formosa** community (Claude AI 愛好者小聚,
Hualien / 新竹), and the source of the community's public website — a **Jekyll** site built
by GitHub Pages from `main`.

Two layers live here and must not be confused:

- `held_events/`, `videos/` — **raw, unedited source material**. Never edited, never served.
- `_events/`, `_data/`, `_layouts/`, `assets/` — **the website**. All site copy is rewritten,
  never copied from the raw material.

`claude.formosa-web.md` is the full specification and the authority for every decision below.

## Source material (read these before producing anything)

- `claude.formosa-web.md` — **the website spec**. Requirements for the site to be built
  (responsive, bilingual zh-TW/English, Discord QR code on desktop only, Tesla-like visual
  style, one retrospective page per past event, curated rather than exhaustive use of photos
  and videos).
- `claude.formosa-profile.md` — organizers, social links (Discord / Threads / Instagram),
  meetup cadence and venues, upcoming event dates. Treat this as the single source of truth
  for those facts.
- `claude.formosa.hualien v2.txt` — the original proposal: the community's mission, target
  audience, the standard 18:00–20:00 agenda, and the running list of sessions with their
  topics (including cancelled months).
- `held_events/YYYY-MM-DD/` — one directory per past event. Contents vary but typically:
  recap/摘要 markdown, pre-event notices (`notice_*.md`, `notification_*.txt`,
  `event_reminder.txt`), `海報/` (posters), `照片/` or `活動照片/` (photos), sometimes a PDF report.
  Some events have several revisions of the same recap (e.g. `活動摘要_0731.md` vs
  `活動摘要_0731 rev.md`) — prefer the later revision.
- `videos/` — selected event videos, named by capture timestamp.

Note the mixed Chinese/English directory and file names, and spaces in paths — always quote
paths in shell commands.

## Site layout

| Path | What it is |
| :--- | :--- |
| `index.html` | The single homepage (hero → mission → past events → next event → organizers → Discord) |
| `_events/YYYY-MM-DD.md` | One file per event; all text fields are `{zh:, en:}` pairs. Adding an event must be *only* a new file here — never a template change |
| `_data/i18n.yml` | UI strings (nav, buttons, section headings) |
| `_data/site.yml` | Social links, venue, next event, organizers, mission |
| `scripts/assets.tsv` | Which source photos/posters the site uses |
| `scripts/build-assets.sh` | Produces compressed derivatives into `assets/` (Pages' Jekyll has no image pipeline, so derivatives are committed) |

Bilingual copy is **rendered in both languages and toggled client-side** (`assets/js/lang.js`);
language comes from `?lang=` → `localStorage` → browser language. Every string therefore needs
both `zh` and `en`.

### Gotchas

- **YAML**: an unquoted value containing a half-width `: ` breaks the front matter. Quote any
  English sentence with a colon in it.
- Jekyll is **not installed locally** and rubygems.org is unreachable from this sandbox, so the
  site cannot be built or previewed here. Verify by pushing and checking the Pages build:
  `gh api repos/samsonchen/claude-formosa-demo2/pages/builds/latest --jq '.status, .error'`
- After editing `scripts/assets.tsv`, re-run `./scripts/build-assets.sh` and commit the
  derivatives. It needs `sips`, `cwebp`, `ffmpeg`, and `python3` + `segno`.
- Adding a monthly event: the full step list is §9 of `claude.formosa-web.md`.

## Writing rules

- Event notices and recaps are bilingual: 中文 first, then the English version of the same
  content, ending with the unsubscribe footer
  (`claude.formosa.hualien+unsubscribe@gigahertz.us`). Follow that shape for new ones.
- Never copy the source text verbatim into the website. Per the spec, rewrite it for
  consistency of tone and polish.
- Prose written in Samson's name (notices, recaps, 公文, site copy) must follow the
  **samson-voice** skill.
- Speaker names, project links and slide URLs appearing in recaps are real people's
  contributions — carry them over accurately, don't invent or embellish them.

## GitHub access

Use the `gh` CLI for GitHub operations (PRs, issues, Actions runs, Pages config). Don't use
the GitHub connector tools unless `gh` can't do the job.
