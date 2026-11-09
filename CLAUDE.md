# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Hao Tran's CV in LaTeX. One file is the live CV: `main.tex` (English, one
column, `article` class). Everything else is build tooling or old material.

```
main.tex  ──xelatex──►  main.pdf   (git-ignored, the file that gets uploaded)
   │
   └─ self-contained: no \input, no images, no bibliography
```

## Build

| Command | What it does |
|---|---|
| `latexmk -xelatex main.tex` | Build only. Use this from an agent session. |
| `./build.sh` | Delete temp files, run XeLaTeX 3 times (Biber only if a `.bcf` exists), then open `main.pdf` in Zathura. |
| `latexmk -pvc main.tex` | Rebuild on every save, with Zathura preview. |
| `./clean.sh` | Delete temp files. Keeps `main.pdf`. |

The short names in `README.md` (`b`, `cl`, `xe`, `pvc`, `ztm`) are shell
aliases on Hao's machine, not scripts in this repo.

Things to know before saying "it builds":

- **A success message is not proof.** `build.sh` runs with
  `-interaction=nonstopmode` and only checks that `main.pdf` exists;
  `.latexmkrc` sets `$force_mode = 1`. Both give a PDF even with LaTeX
  errors. Search `main.log` for lines starting with `!` and for
  `Overfull` boxes.
- **`./build.sh` opens a Zathura window.** Prefer the `latexmk` line when
  no one is watching the screen.
- **Check the tools exist first** (`command -v xelatex latexmk`). If they
  are missing, say the change was not build-checked; do not claim the CV
  builds.
- There are no tests and no linter. The check is: clean log, then look at
  the PDF (page count, nothing running off the page).

## Layout rules inside `main.tex`

- New entries use `\entryheader{title}{dates}` followed by a `highlights`
  list. Do not add raw formatting per entry.
- Escape `_` in visible link text (`refactor\_mainproject`); the URL inside
  `\href{...}` stays unescaped.

## Language versions

One branch per language, same file name, same preamble and commands; only
the text differs.

| Branch | `main.tex` is |
|---|---|
| `main` | English CV |
| `Vietnamese-language-cv` | Vietnamese CV |

When a fact changes (dates, projects, contact details), ask whether the
other branch must change too.

## Files that look live but are not

| Path | What it really is |
|---|---|
| `main_list/` | Archive of older layouts (two-column, `moderncv`, `curve`, a Ningbo University letter style). Not built. Several point at files that do not exist (`figures/...`, `images/kun.png`, `own-bib.bib`), so they do not build as they are. Image paths are written relative to the repo root: to try one, copy it to the root under a new name (`cp main_list/main.engineer.tex try.tex`, then `latexmk -xelatex try.tex`). Never copy it over `main.tex`. |
| `images/` | Used only by the archived layouts. The current CV has no photo. |

Do not "fix" or tidy these while working on the CV; ask first.
