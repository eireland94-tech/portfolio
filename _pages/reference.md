---
layout: page
title: Reference Library
description: The documentation I actually work from – a tagged field manual, build playbooks, script templates, and the project write-ups they came out of.
permalink: /reference/
image:
---

Everything here is written to be quick, usable reference material – something
to reach for under time pressure, when you're trying to remember exactly how
something worked.

Nothing is theoretical. Every procedure here was executed, diagnosed, and
re-executed on real hardware before it was written down.

---

## 1 · IT Field Manual

**[Read the manual →](/reference/field-manual/)**

The single reference. Networking and security fundamentals, Windows, Active
Directory, Group Policy, file services, hybrid identity, Intune, Microsoft 365,
Exchange Online, public DNS and mail flow, SharePoint sharing, Purview, Copilot
administration, Azure, PowerShell, and the standard operating procedures that
tie them together – about 93,000 words across 31 sections.

Every block carries a search tag in brackets, like `[GPO-TRIAGE]` or
`[AD-LOCKOUT]`, so you search the tag rather than the prose and the reference
survives being reorganized. Section 18 is an error → cause → fix index: paste in
the error message you are actually looking at and start there.

The tag prefixes are split on purpose. `[NET]` is the commands you run;
`[NETF]` is the protocol reasoning underneath them. Same for `[SEC]` and
`[SECF]`. When something is broken you want the first one; when a client asks
you why, you want the second.

It is a living document. New sections get added as I hit new problems.

| | |
|---|---|
| **Current version** | 1.3 – August 2026 |
| **Sections** | 31 (§00 – §30), ~93,000 words, 54 logged corrections in `[APX-C]` |
| **Read online** | [/reference/field-manual/](/reference/field-manual/) |
| **Download** | [Raw Markdown](/assets/docs/it-field-manual.md) – opens in VS Code, Obsidian, or any text editor |
| **Changelog** | [End of the manual](/reference/field-manual/#changelog) – every version, what changed, and where it came from |

---

## 2 · Playbooks and runbooks

**[Browse playbooks →](/reference/playbooks/)**

Long-form procedures for work that takes hours rather than minutes: building a
hybrid environment from bare metal, administering one day to day, assessing a
network you have just inherited, and tearing an environment down without
stranding anything.

Two are published – the **Hybrid Microsoft Network Build & Troubleshooting
Playbook** (48 pp.) and the **Microsoft 365 Administration Playbook** (70 pp.).
The first covers standing an environment up; the second covers running it.

These are checklists you follow top to bottom, with the reasoning attached – the
kind of document you would want in your hands the first time you do the job
alone.

---

## 3 · Script template repository

**[See what is planned →](/reference/scripts/)**

A parameterized PowerShell toolkit – configuration data separated from logic,
CSV input, dry-run support. In progress; the pattern it is being built to is
documented in the Field Manual under `[TOOLKIT-01]` through `[TOOLKIT-07]`.

---

## 4 · Home lab project case studies

**[Read the case studies →](/projects/)**

The builds the documentation above came out of, written up in full – including
what went wrong, how it was diagnosed, and what it cost in time.

If you only read one thing here, read a case study. The manual tells you what to
do; the case studies show what actually happens when you do it.
