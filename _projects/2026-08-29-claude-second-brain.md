---
title: "Claude Second Brain - Personal Knowledge System"
description: "A file-based knowledge vault, read and written directly by Claude, built to carry context between six previously isolated Claude Projects. The architecture, the migration, three failure modes, and the checks run against it."
date: 2026-08-29 09:00:00 -0600
labels: [Claude, Cowork, Markdown, Knowledge Management]
image: '/assets/projects/claude-second-brain/00-thumbnail.png'
toc: true
---

**Mini-project.** A file-based personal knowledge vault, read and written directly by
Claude, built to carry context between otherwise isolated AI conversations.

**Status:** in service. Built 25-26 August 2026, iterated across three revisions.

---

## At a glance

| | |
|---|---|
| **Objective** | A single Claude-readable knowledge store that survives the end of any conversation, replacing six isolated Claude Projects |
| **Scope** | Folder architecture across 6 Claude Projects, migration of 11 conversation distillations, bulk ingestion of 157 files (~71 MB) |
| **Duration** | Built 25-26 August 2026, iterated across three revisions |
| **Method** | Single operator, folder-based markdown vault, verified cold - no memory of the build conversation |
| **Findings** | 3 failure modes identified and corrected, 28 duplicate file groups resolved, 6 verification checks defined |
| **Status** | In service |

---

I have been using Claude across six separate Projects for months, and every one of them
was its own island. The finance work did not know about the certifications, the
certifications did not know about the homelab, and none of it knew about the resume
that was supposed to be built out of all three. This is the writeup of what I did about
that, and what it cost.

The narrative version, with the reasoning and the jokes, is in the [companion article](/posts/claude-second-brain/).
This page is the technical record.

## Problem

Conversational AI retains context within a single conversation and discards it at the
conversation boundary. Project-level knowledge bases persist, but they are static
uploads that must be maintained by hand. The practical result is threefold:

- Work performed in one conversation is unavailable to the next, including within the
  same Project.
- Material relevant to more than one Project must be duplicated into each, after which
  the copies diverge.
- Source material was distributed across OneDrive, a local disk, and several Project
  knowledge bases with no canonical location.

The requirement was a single authoritative store, readable by Claude without manual
upload, that survives the end of any given conversation.

## Architecture

A plain markdown folder tree was selected over a dedicated application - Obsidian was
evaluated and deferred. The reasoning: a folder of `.md` files carries no proprietary
format, is greppable, and can be adopted by Obsidian later with no migration step,
because Obsidian opens a folder rather than importing one.

The vault is located inside OneDrive, which supplies off-machine backup and 30 days of
per-file version history at no additional configuration cost. An independent offline
copy is retained separately.

**Top-level structure:**

| Item | Function |
|---|---|
| `0. About Evan.md` | Master context brief. The only file uploaded to Project knowledge. |
| `0. START HERE.md` | Operating manual - conventions, structure, standing rules. |
| `00. Inbox/` | Unstructured capture. The single staging area. |
| `1.` - `6.` | One folder per Claude Project, numbered to match. |
| `7. Resources/` | Cross-project material - writing reference, prompts, field lessons. |
| `8. Logs/` | Learning log and weekly reviews. |
| `9. Archive/` | Superseded material, retained. |

![The first generated folder layout, with underscore-prefixed and numbered folders like 00-Inbox and 01-Projects](/assets/projects/claude-second-brain/08-first-generated-layout-rejected.png)
*First generated layout - rejected. Technically sound, but not how the operator's own OneDrive is organized.*

![The final Cogitator folder layout, numbered Title Case folders from 1. Ireland Capital through 9. Archive](/assets/projects/claude-second-brain/11-final-layout-result.png)
*Current layout, derived from existing OneDrive conventions*

Each of the six project folders is structurally identical: `0. Brief.md`,
`1. Working/`, `2. Reference/`, `9. Archive/`. Uniformity was chosen over per-project
optimization so that any folder can be navigated without inspection, by the operator or
by an agent.

**Naming conventions** were derived from the existing OneDrive hierarchy rather than
imposed: numbered `N. Title Case` folders, zero-padding to pin items above `1.`
(`0.` sorts before `00.` before `000.`), `ao DDMMMYY` for as-of dates, `_vN` for
explicit versions, and `<Target> - Submission` for per-recipient output sets. Prior
versions are retained indefinitely and never deleted.

## Component Function

**`0. About Evan.md`** carries identity, background, working preferences, current
focus, and an explicit statement of skill level. It is the sole file uploaded into each
Project's knowledge base, on the reasoning that it changes on a monthly cadence and a
second copy therefore remains accurate between edits.

**`0. START HERE.md`** carries the conventions above, the inter-project flow, filing
rules, and a "settled" table enumerating decisions that are closed. The table exists
because two separate cold sessions independently rediscovered and reported the same
resolved contradiction, consuming context before any task was issued.

**`N. <Project>/0. Brief.md`** carries per-project state under seven fixed headings:
purpose, current state, key decisions and rationale, dead ends, conventions, open
threads, and working preferences specific to that project. Briefs are read live from
disk and are **not** uploaded to Project knowledge - they change per session, and a
stale uploaded copy would be authoritative to an agent that has no basis to doubt it.

**Inter-project flow.** The six projects are not independent. Material moves along
fixed edges:

| From | To | Content |
|---|---|---|
| Cert Study Guides | IT Field Manual | Corrected study material, exam framing removed |
| IT Skill Development | IT Field Manual | Lab findings as integration modules |
| IT Skill Development | Beginning Coding | Portfolio case studies for publication |
| Beginning Coding | IT Field Manual | Scripting and programming knowledge |
| IT Field Manual | Beginning Coding | Published manual versions |
| Branding | Beginning Coding | Positioning and site copy |

A completed lab produces two distinct deliverables rather than one: a narrative case
study for the site and a separate merge module for the manual. The two serve different
readers and are structurally different documents.

## Migration

Existing conversational context was extracted using a standardized distillation prompt,
run at the end of each source conversation rather than in a new one. A new conversation
cannot read prior conversations within the same Project; extraction must therefore occur
while the source context is still resident.

Eleven distillations were produced across six Projects. These were merged into six
briefs programmatically rather than by hand, on the reasoning that a hand-merge of
approximately 150 KB introduces transcription error into precisely the details that make
the material useful. The merge was verified by asserting that every non-heading,
non-blank line from each source appears verbatim in its destination: **880 lines
checked, zero missing.**

Three cross-file conflicts were identified during the merge and would have been silently
absorbed by a naive concatenation:

1. **Chronological inversion.** Two briefs for the same project carried "as of" dates
   reflecting when each was distilled, not the state each described. The apparently
   older document described the later reality. Absorbed uncritically, this would have
   directed future sessions to restart a completed migration.
2. **Contradictory skill assessment.** One brief described the operator as an
   experienced MSP technician; every other source described a career-changer with no
   professional experience. The assessment governs the level of explanation in every
   subsequent response.
3. **Stale cross-project thread.** One project recorded a handoff as not started; the
   receiving project recorded it as completed and integrated.

**Bulk ingestion** followed: 157 files, approximately 71 MB, comprising screenshots,
playbooks, study guides, four manual versions, and resume drafts. Files were sorted by
project and by lifecycle stage - active work to `1. Working/`, completed material to
`2. Reference/`.

Deduplication was performed by MD5 checksum. Twenty-eight exact-duplicate groups were
identified, totaling approximately 9 MB: one duplicated study guide, two redundant
archive files, one file identical to its own renamed copy, and 26 screenshots existing
twice under both raw and published filenames. One copy of each was retained. The
published rename was preserved as a mapping table with a regeneration script rather than
as a second set of files.

No file was deleted. Superseded material was relocated to a staging folder for operator
review, on the principle that an agent operating on a personal archive should not hold
delete authority.

## Failure Modes & Corrections

Three defects were introduced during construction. All three originated in instruction
files rather than in structure, and all three were only detectable by running the system
cold.

**Symptom:** A fresh session reported that a referenced context file did not exist.
**Diagnosis:** The master context file had been renamed twice during reorganization. The
saved start-of-session prompt still referenced the original filename.
**Resolution:** All instruction files were audited for stale references and corrected.
The lesson generalizes: instructions that name files decay silently the moment files are
renamed, and the author is the least likely person to notice.

**Symptom:** A session uploaded three files into a Project knowledge base without being
asked, creating duplicate copies of material designated as disk-canonical.
**Diagnosis:** Every brief carried a header instruction reading "upload this file to
that Project's knowledge base." The instruction was authored as a note to the operator.
An agent with file access read it as a directive addressed to itself and complied
correctly.
**Resolution:** The instruction was inverted to an explicit prohibition, and a standing
rule was added forbidding uploads on agent initiative. **Operator notes stored in files
an agent reads are not notes. They are instructions, and they will be executed.**

**Symptom:** A session declined to proceed with a requested task, citing the operator's
own stated priorities.
**Diagnosis:** The current-focus section of the context file concluded with the line
"Everything else waits." Written as a personal scheduling note, it is read by an agent
as an enforceable constraint.
**Resolution:** Priority statements were reframed as context rather than as gates, with
an explicit rule permitting a one-line advisory and requiring the work to proceed
regardless. I would flag this as the least obvious of the three and the most likely to
recur: a reference document that describes intent can be read as a document that governs
behavior, and the distinction has to be stated rather than assumed.

## Verification

The following checks are run against the vault after any structural change:

| Check | Method | Expected result |
|---|---|---|
| Merge completeness | Every source line matched against destination | 880 of 880 lines present |
| Reference integrity | Every file path cited in instruction files resolved | 0 broken |
| Markdown validity | Code fence parity per file | All even |
| Flow consistency | Every declared outbound edge matched against the corresponding inbound declaration | 6 of 6 matched, 0 orphans |
| Duplicate detection | MD5 across the ingestion set | 28 groups identified and resolved |
| Convention compliance | Prohibited punctuation absent from authored files | 0 occurrences |

The flow consistency check is the one worth noting. Each project's brief declares its
own inbound and outbound edges independently. A declared outbound edge with no
corresponding inbound declaration indicates a documented handoff that the receiving
project does not know about, which is the failure mode that produced conflict 3 above.

## Limitations

- **The system depends on an unautomated habit.** Context is written back at the end of
  a session by explicit instruction. There is no mechanism that enforces this, and the
  vault degrades silently if it is skipped.
- **Two access surfaces behave differently.** A standard conversation reads Project
  knowledge only. A Cowork session with the folder connected reads both. The
  distinction is invisible to the operator until a session produces an answer based on
  incomplete context.
- **Agents cannot delete on this device**, by design. Superseded material accumulates in
  a staging folder until removed manually.
- **One project's material is sensitive** and is excluded from any future version
  control that is not private.
- **Distilled sections are dated snapshots** and are explicitly marked as historical.
  They are retained unedited, which means each brief contains material that is known to
  be superseded by the sections above it.

---

Six days in, the thing I did not expect is how much of the value came from the audit
rather than the build. Constructing the folders took an afternoon. Finding out that my
own notes described my skill level two different ways, that a handoff was recorded as
incomplete in one place and finished in another, and that I had written a scheduling
note that a machine would read as a rule - that took running the whole thing cold and
watching where it snagged.

Which is roughly the argument for building one of these at all. The system is not
smarter than I am. It just does not forget what I told it last week, and it has no
particular investment in my being right.

## Screenshots

A handful of frames from the build - the prompt, the first rejected layout, and the
conversation that produced the layout actually in use.

<div class="gallery-box">
  <div class="gallery gallery-columns-3">
    {% include img.html src="/assets/projects/claude-second-brain/05-setup-prompt-to-claude.png" alt="The initial prompt asking Claude to help set up a second brain, listing concerns about losing context across four existing Claude Projects" caption="The opening prompt to Claude" %}
    {% include img.html src="/assets/projects/claude-second-brain/06-cogitator-desktop-icon.png" alt="A desktop icon labeled Cogitator with a blue Adeptus Mechanicus-style skull icon" caption="The empty folder that started it all" %}
    {% include img.html src="/assets/projects/claude-second-brain/07-claude-response-three-decisions.png" alt="Claude's response after being pointed at the empty folder, summarizing three architecture decisions before writing anything" caption="Three decisions asked for before any file was written" %}
    {% include img.html src="/assets/projects/claude-second-brain/08-first-generated-layout-rejected.png" alt="The first generated folder layout, underscore-prefixed and numbered" caption="First generated layout - rejected" %}
    {% include img.html src="/assets/projects/claude-second-brain/09-explanation-of-generated-files.png" alt="Claude summarizing 23 markdown files written to disk" caption="What actually landed on disk" %}
    {% include img.html src="/assets/projects/claude-second-brain/10-reorg-conversation.png" alt="Claude describing the numbering and naming conventions found in an existing OneDrive folder" caption="Deriving conventions from an existing OneDrive folder" %}
    {% include img.html src="/assets/projects/claude-second-brain/11-final-layout-result.png" alt="The final Cogitator folder layout, numbered Title Case folders from 1. Ireland Capital through 9. Archive" caption="Current layout, in service" %}
  </div>
  <em>Full capture set - any image opens full size when clicked</em>
</div>
