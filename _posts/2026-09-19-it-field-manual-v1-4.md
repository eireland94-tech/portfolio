---
title: "The IT Field Manual, version 1.4"
description: "Three staged modules and a year-old wording bug went into the manual at once, because I decided against a version-bump chain that would leave v1.4 stale the day it shipped. What got added, what got corrected, and the placement call I made against my own source material's advice."
date: 2026-09-19 09:00:00 -0600
image:
tags: [Documentation, Troubleshooting, Hardware, MSP]
toc: true
---

The **[IT Field Manual](/reference/field-manual/)** is now at version 1.4. It runs
approximately 104,000 words across 36 sections, up from roughly 93,500 words and 31
sections in [version 1.3](/posts/it-field-manual-v1-3/) - about 10,300 more words.

That is three separate pieces of work landing as one release, not three. Here is why,
what is actually new, and one placement call I made against my own staged source
material's explicit advice.

| | |
|---|---|
| **Version** | 1.4, 19 September 2026 |
| **Size** | ~104,000 words · 36 sections · ~493 headings |
| **New since 1.3** | §31 - §33 (A+ hardware/OS layer) · §34 - §35 (site survey and vendor due diligence) |
| **New doctrine** | `[DOCTRINE-13]` - `[DOCTRINE-15]`, up from 12 |
| **Corrections logged** | 74 in `[APX-C]`, up from 54 |
| **Read / download** | [Online](/reference/field-manual/) · [raw Markdown](/assets/docs/it-field-manual.md) |

## Why one v1.4, not three version bumps

By the time I sat down for this pass, three separate staged modules had piled up
against the vault master: a filtered A+ Study Guide, a vendor-assessment-and-site-survey
module, and a cloud-migration-economics-and-tooling module. Alongside them was one
still-open problem - a wording divergence I had found and partially fixed three weeks
earlier.

Shipping each of those as its own version bump would have meant a v1.4 that was
superseded by a v1.5 within days, and a v1.5 superseded by a v1.6 not long after that.
Nobody reading a changelog gets anything out of that sequence except noise. So all four
went in as one release instead.

**The wording divergence is worth explaining, since it is the least glamorous fix in this
release and the one that mattered most.** In early September I caught the phrase
"keeps it honest" sitting in several places in the manual - language my own voice
reference bans in favor of "legitimate," "proper," or "truthful." I fixed it on the
published site immediately. I deliberately left the vault master - the actual source
file everything gets built from - unfixed, because a one-word patch outside a real
release is exactly the kind of silent drift this manual exists to prevent. For about
three weeks, the file I write from and the file the site serves were not the same
document. That is fixed now, as part of this release, not around it.

## New: the parts of the job that are not Microsoft

The A+ Study Guide module was the biggest single source this round, and it got filtered
harder than its own "not exam-specific" bar - the standard was field relevance in 2026,
not "not literally a test question," so roughly 60% of the source was discarded as
scaffolding or ground the manual already covered better.

| § | Section | What it is for |
|---|---|---|
| **31** | Printers and imaging `[PRN]` | The laser imaging process step by step, symptom-to-cause tables, and the one thing you never point at toner |
| **32** | macOS field reference `[MAC]` | A Windows-to-Mac translation table for a technician who lives in Windows but supports mixed fleets |
| **33** | Physical layer and connectors `[CONN]` | Cable standards and a connector-identification table rebuilt for what actually turns up in the field in 2026, not a 2015 study guide |

`[PRN-06]` is the one I would flag first if you only read one new entry: never
compressed air or a standard vacuum on toner. Compressed air aerosolizes a combustible
fine powder, and a standard vacuum's motor brushes can ignite it. HEPA, ESD-safe toner
vacuum, nothing else.

The connector table in §33 is not a straight copy of the source material either. USB-C
got added as its own row, Lightning got marked legacy rather than current, and the
mnemonics the study guide used to help you memorize the table got dropped entirely -
this is a lookup reference, not something you are studying for a test, so a device you
can Ctrl+F does the memorizing for you.

## New: reading a company and a site before you trust either

The vendor-assessment-and-site-survey module added two full sections and two new
doctrine entries, and this is the part of the release aimed less at fixing something
broken and more at a skill I did not have a section for at all: judging whether an
inherited environment or an incumbent vendor is what it claims to be.

| § | Section | What it is for |
|---|---|---|
| **34** | Site survey `[SITE]` | A shot list ordered by priority, evidence-handling rules, and the fact that a service tag is worth more than an estimate |
| **35** | Vendor and platform due diligence `[VEND]` | Reading whether a product line is actually alive, and reading an incumbent's invoices instead of its marketing |

`[DOCTRINE-13]` is the one I keep coming back to: **a search that returns only
aggregators has told you the company is dead.** ZoomInfo, Manta, Dun & Bradstreet, and
similar directory sites never delete a listing - they are populated once from a public
filing and persist indefinitely, which means a defunct company can look extremely well
documented. Nine hits feels like evidence. It is nine copies of one filing. The fix is
requiring a live company website or a current state business-entity registry record
before you call anything active - the registry check takes about two minutes and settles
it outright.

`[DOCTRINE-14]` is the physical-inspection companion to it: paper describes the part of
the world its author touched, and nothing else. A complete set of one vendor's invoices
says nothing about a second vendor, a decommissioned appliance, or anything installed
before the first invoice in the set - not because the documents are wrong, but because
that is the definition of their scope. An hour walking a site with a written shot list
routinely finds what weeks of document review cannot.

## New: the migration pitch, split into the two numbers it actually is

The cloud-migration-economics-and-tooling module was the smallest of the three by
section count - it landed as one doctrine entry and one extension, not a new section -
but `[DOCTRINE-15]` is doing real work: **a cloud migration's real saving for a small
organization is avoided capital spend, not a recurring discount.**

The generic pitch - "the cloud saves you money on IT" - is not reliably true, and
treating it as automatic is a credibility risk in front of a technically literate buyer.
Recurring cost is usually close to even and depends entirely on what the organization
already owns; the real, defensible number is almost always on the capital side, where
aging on-premises hardware needs periodic replacement on a schedule that a cloud
migration can remove entirely. And administrative labor does not disappear - it changes
shape, from unplanned hardware-failure recovery to ongoing identity and policy
administration. Any total-cost argument that blends those two halves into one "savings"
figure is exactly where the misleading version of the pitch hides.

The migration tooling itself - the file-share-to-SharePoint/OneDrive table - went into
a new `[FILE-10]`, which is the placement call from the intro.

## The placement call I made against my own source material

Both staged modules that added new sections came with their own integration
instructions, and I did not follow either one exactly as written.

The vendor-assessment module's own draft for §11 proposed a full second product-overlap
table for `[M365-21]`. I wrote it short instead - a cross-reference to `[M365-13]` and
`[M365-20]`, which already cover that ground, plus only the material that was genuinely
new: checking for seat-by-seat license overlap, and the rule that "we already own an
equivalent" never extends to backup. Restating a table that already exists two sections
over is the kind of redundancy that makes a tagged, search-first document worse, not
more complete.

The cloud-migration module's own instructions named `[SPO]` or `[AZ]` as the candidate
home for the file-share migration tooling - it listed both as options. I put it in
`[FILE-10]` instead. `[SPO]` is scoped tightly to sharing and guest access; `[FILE]`
already carries the full lifecycle of on-premises file-share administration and reads
naturally as ending with "now retire it." Cross-references went in from both `[SPO]`'s
intro and `[AZ-07]`'s Data Box entry, so the content stays reachable from every path
someone might search it from.

`[TRANSITION SLOT - he may want to make this a joke]` Neither of those was the module's
fault. A module is written against a snapshot of the manual that gets more stale the
longer it sits staged, and both of these had been sitting for a couple of weeks.

## The correction log is the part I would read

Appendix C is where every claim in my source material that turned out to be wrong gets
recorded, alongside the correction and where it was verified. Version 1.3 shipped with
54 entries. Version 1.4 has 74 - 20 in this release alone, which is the largest single
batch since the initial 16 that shipped with v1.0.

A representative handful:

- **SMB is not a Linux protocol.** It is Microsoft's. Samba is the Linux/Unix
  implementation of it - implementing a protocol does not make you its native platform.
- **Mixing RAM modules of different sizes and speeds does not waste capacity.** The
  system uses the full combined capacity of every installed module, running at the speed
  of the slowest one. The speed penalty is real; the capacity loss is not.
- **`gpedit.msc` and `gpmc.msc` are not interchangeable**, and only one of them is
  installed by default on a client OS. `gpedit.msc` is the Local Group Policy Editor.
  `gpmc.msc` manages domain GPOs and their AD links, and it is an RSAT feature you have
  to add.
- **Telnet does authenticate you** - with a username and password, in cleartext. No
  encryption is not the same claim as no authentication, and conflating the two is a
  worse mistake than either fact alone.
- **Azure Data Box does not have a flat 80 TB usable capacity anymore.** Current
  Microsoft documentation shows a tiered lineup - roughly 35 TB, 120 TB, and 525 TB
  usable, depending on the tier. I found this one myself while placing the
  cloud-migration content, not from either staged module, which is exactly the kind of
  catch this appendix exists for.

## What is actually next, which is not what I said last time

Version 1.3's closing line said the next release would most likely be Linux and Samba.
It was not. A+ hardware content, vendor and site-survey due diligence, and cloud
migration economics came due first, and I would rather ship what was actually ready than
force a plan I made three weeks earlier onto a release it no longer describes.

The Linux Field Manual is still a separate, not-yet-started document - a full bare-metal
Proxmox cluster build guide is staged and waiting for it, untouched, exactly where it was
last time. Section 25, "Personal additions," is also still empty, on purpose, same as
every prior version.

`[TRANSITION SLOT - self-deprecation about predicting his own roadmap goes here]`

That all being said, the manual stays public for the same reason it always has: a
document I know somebody might actually read is a document I write more carefully. If
you find something in it that is wrong or out of date, Appendix C is where it goes, and
it is the appendix I expect to keep growing fastest.

**[Read the Field Manual →](/reference/field-manual/)** ·
**[Browse the Reference Library →](/reference/)**
