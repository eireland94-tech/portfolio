---
layout: page
title: Reference Library
description: The documentation I actually work from — a tagged field manual, build playbooks, script templates, and the project write-ups they came out of.
permalink: /reference/
image:
---

Everything here is written for one reader in particular: me, six months from now,
under time pressure, trying to remember exactly how something worked. If it is
useful to anyone else, that is a bonus rather than the design goal — which is
why none of it is padded.

Nothing is theoretical. Every procedure here was executed, broken, diagnosed and
re-executed on real hardware before it was written down.

---

## 1 · IT Field Manual

**[Read the manual →](/reference/field-manual/)**

The single reference. Windows, Active Directory, Group Policy, file services,
hybrid identity, Intune, Microsoft 365, Azure, PowerShell, and the standard
operating procedures that tie them together — about 37,000 words across 23
sections.

Every block carries a search tag in brackets, like `[GPO-TRIAGE]` or
`[AD-LOCKOUT]`, so you search the tag rather than the prose and the reference
survives being reorganised. Section 18 is an error → cause → fix index: paste in
the error message you are actually looking at and start there.

It is a living document. New sections get added as I hit new problems.

| | |
|---|---|
| **Current version** | 1.0 — August 2026 |
| **Read online** | [/reference/field-manual/](/reference/field-manual/) |
| **Download** | [Raw Markdown](/assets/docs/it-field-manual.md) — opens in VS Code, Obsidian, or any text editor |

---

## 2 · Playbooks and runbooks

**[Browse playbooks →](/reference/playbooks/)**

Long-form procedures for work that takes hours rather than minutes: building a
hybrid environment from bare metal, assessing a network you have just inherited,
and tearing an environment down without stranding anything.

These are checklists you follow top to bottom, with the reasoning attached — the
kind of document you would want in your hands the first time you do the job
alone.

---

## 3 · Script template repository

**[See what is planned →](/reference/scripts/)**

A parameterised PowerShell toolkit — configuration data separated from logic,
CSV input, dry-run support. In progress; the pattern it is being built to is
documented in the Field Manual under `[TOOLKIT-01]` through `[TOOLKIT-07]`.

---

## 4 · Home lab project case studies

**[Read the case studies →](/projects/)**

The builds the documentation above came out of, written up in full — including
what went wrong, how it was diagnosed, and what it cost in time.

If you only read one thing here, read a case study. The manual tells you what to
do; the case studies show what actually happens when you do it.
