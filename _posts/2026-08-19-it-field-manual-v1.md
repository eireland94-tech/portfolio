---
title: "The IT Field Manual, version 1.0"
description: "Thirty-seven thousand words of operational reference, built around one rule: search the tag, not the prose. Here is why I stopped keeping notes and started keeping a manual."
date: 2026-08-19 20:00:00 -0600
image: '/assets/projects/hybrid-ad-smb/16-group-policy-objects.png'
tags: [Documentation, PowerShell, Active Directory]
toc: true
---

> **Update, 24 August 2026.** The manual is now at **version 1.3** — roughly
> 93,000 words across 31 sections, with a fundamentals layer and five new cloud
> administration sections. Everything below still holds, with one exception:
> "Personal additions" moved from §22 to **§25** when the fundamentals sections
> were added. See **[what changed in v1.3](/posts/it-field-manual-v1-3/)**.

I have published the **[IT Field Manual](/reference/field-manual/)** — the
single document I work out of. It sits at the top of a new
**[Reference Library](/reference/)** along with the build playbooks and, in time,
a script toolkit.

It is version 1.0 of a living document, not a finished one.

## The problem it solves

For the first few months of building things I took notes the way most people
take notes: a file per topic, named after whatever I was doing that day.
`ad-notes.md`. `intune-stuff.md`. `powershell-things.md`. A folder of them.

The failure mode showed up the first time I hit a problem I had already solved.
I knew I had written down the fix for Folder Redirection failing with Event ID
502. I could not remember which file it was in, whether I had filed it under
Group Policy or under file permissions, or what I had called it. Finding it
again took longer than solving it the first time would have taken a second time.

Notes scattered across a dozen files are not a reference. They are a search
problem you built for yourself.

## What actually changed

One file. Thirty-seven thousand words. And one rule that makes it work:

> Every block carries a bracketed tag. Search the tag, not the prose.

A note about domain join failures is tagged `[AD-JOIN-FAIL]`. Group Policy
triage is `[GPO-TRIAGE]`. The Service Connection Point trap that cost me an
afternoon is `[HYB-SCP]`. When I write a new entry that relates to an old one, I
reference the tag — and that reference still resolves after I have reorganised
the document twice, because the tags are stable even when the section numbers
are not.

The practical effect: Ctrl+F, type the tag, land on the answer. No folder
structure to remember, no naming convention to be consistent about, no decision
about where something belongs.

## What is in it

Twenty-three sections. The ones I open most:

- **§18 — Error → cause → fix index.** Paste in the error you are actually
  staring at. This is the front door most days.
- **§01 — Troubleshooting doctrine.** Ten rules that transfer between every
  technology in the rest of the manual. *"The error message describes the
  symptom, not the cause."* *"A backup you have never restored from is a
  hypothesis."*
- **§06 — Greenfield build order.** Fifteen phases, in the order the work should
  be done rather than the order you learn it in.
- **§15 — Standard operating procedures.** Onboarding, offboarding, workstation
  deployment, monthly maintenance, FSMO seizure, compromised account response.
- **§16 — Assessing an inherited network.** A discovery block to run before
  touching anything, and triage trees for what you will find.

Plus PowerShell fundamentals, network diagnostics, AD operations, Group Policy,
file services and permissions, hybrid identity, Intune, Microsoft 365, Azure,
Windows client builds, storage, decommissioning, a script toolkit pattern, and
documentation templates.

## The rules that keep it honest

Three, written into the manual's own maintenance protocol:

**Strip the client.** Never file a real hostname, IP, username, or domain —
substitute the placeholder at the moment of writing, not later. A manual full of
real client detail is a manual you can never hand to anyone, and cleaning it up
retroactively never happens.

**Record the fix, not the workaround — and if you used a workaround, label it.**
A workaround is a modification to the environment. The environment remembers it
long after you have forgotten. Unlabelled workarounds are the most expensive
category of self-inflicted troubleshooting there is.

**Date anything Microsoft can change.** Portal click-paths, product names, and
CLI switches rot. Facts about protocols — Kerberos clock skew, DNS SRV records,
NTFS evaluation order — do not. Date the first kind. Leave the second alone.

## Why publish it

Two reasons, and only one of them is about other people.

The honest one first: a document I know is public is a document I write more
carefully. Vague notes survive in private. They do not survive being read.

The other is that this is the artefact that actually represents the work. The
[hybrid AD case study](/projects/hybrid-ad-smb/) describes an environment I
built and then deliberately destroyed — the network is gone. What is left is the
documentation, and whether the documentation was good enough to rebuild from.
That question got answered when I rebuilt the environment from my own playbook
in 5 hours 58 minutes with no rework.

The manual is the same bet, made larger.

## What is next

Section 22 is titled "Personal additions" and is currently empty. That is
deliberate — it is where entries land before they get filed properly, and an
empty section is a standing invitation to fill it.

Beyond that: converting the inline scripts into a real
[parameterised toolkit](/reference/scripts/), and a second playbook once the
Ubuntu file and print services build is finished.

**[Read the Field Manual →](/reference/field-manual/)** ·
**[Browse the Reference Library →](/reference/)**
