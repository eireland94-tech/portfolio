---
title: "Never Edit the Copy: One PowerShell Toolkit, a Private Repo, an Encrypted USB, and This Site"
description: "How I keep one PowerShell toolkit in step across a private repo, an encrypted field USB and this site, and two linter warnings I handled two different ways."
date: 2026-11-21 12:45:00 -0700
image:
tags: [PowerShell, Documentation, MSP]
toc: true
---

Every MSP technician ends up with a folder of scripts. Mine started the way I suspect most of
them do: a few PowerShell blocks pasted out of my own notes into a console, edited in place,
run once, and saved somewhere with a name that made sense at the time.
Being the genius - and heavy Claude user - that I am, I had the bright idea to create my own living repo of these to use when/if they come in handy.

In October I turned that folder into a proper toolkit. I named it Servitor
(for all you Ad Mech fans out there). It now holds 25 scripts, and the same
scripts live in three places at once: a private Git repo, an encrypted USB stick that goes to
work with me, and the [scripts page](/reference/scripts/) on this site. Three copies of
anything will drift apart unless something stops them. This post is about the something.

Servitor is a side project, built on my own time. The point is to make my homelab, my personal
tech and my day job easier, and partly it is just for the fun of it.
My idea of fun being apparently drafting scripts with Claude, and tinkering with DIY servers...anyways...
Once the scripts are tested and honed, the useful ones are going to the rest of the team at work.

Cards on the table before we go any further: most of the code in this toolkit was written by
Claude, working from my Field Manual and my build notes. I refuse to be ashamed of or hide my AI usage - it has made me more informed, more productive, and busier than ever - quite the opposite of letting it do everything for me all the time without me thinking once in the process. 

## The problem with three copies

The moment a copy gets edited, there are two versions of the truth, and nobody
remembers which one is right.

The fix is a handful of rules, and they are short on purpose.

## Rule one: one master copy

The private repo is the master. It is the only place a script is ever edited. Every other copy
(the USB stick, this site) is made from the repo and is never touched by hand. A fix made
directly on the stick would work once, on that stick, and then be overwritten by the next
release, or worse, be the only copy of the fix.

| Copy | What it is | Edited there? |
|---|---|---|
| Private Git repo | The master. Every change is a commit | Yes - the only place |
| USB stick | A field copy, encrypted with BitLocker To Go | Never |
| This site | Selected scripts, published as downloads | Never |

The repo also holds only generic scripts. Anything that differs between environments (domain
names, OU paths, group names, log folders) is discovered at run time or passed in as a
parameter or a config file, and config files never go in the repo.

Some of these scripts started as a problem I ran into on the job. When one of those is worth
keeping, I build it on my own time with everything specific to that environment stripped out -
names, domains, accounts, paths - so what goes in the toolkit works anywhere. The repo, the
stick and this site all reach places where one environment's details have no business being.

I will never upload client-specific scripts, data, environmental details, etc. onto this website. 

## Releasing to the stick

A release is a copy of the repo onto the stick, and it follows the same steps every time:

1. **Start from a clean commit.** Nothing is copied while there are uncommitted changes, so
   everything on the stick matches a commit that exists. If the stick ever held code that
   exists in no commit, that would be drift by definition.
2. **Copy file by file**, only the files that belong in the field set (next section).
3. **Write a `VERSION.txt`** to the stick. It names the commit, lists every script on the stick,
   and lists every script that was held back and why.
4. **Read every file back off the stick** and compare its SHA-256 hash with the same file in the
   repo. A copy that has not been checked is a copy that is assumed to be right.

The hash check is the step that turns "I copied it" into "it is the same file." Every release
so far has matched file for file.

Which brings up the obvious question: Which files go on the stick at all?

## What rides along: read-only versus changes things

Early on, Claude suggested that only tested scripts should go on the stick. I never signed up
for that one. A script gets tested by running it, and the stick is how it gets to the machines it
is supposed to run on. Following that suggestion would have meant carrying two tools.

The way the stick is set up now draws the line somewhere more useful: between scripts that only
look and scripts that change something.

| Kind of script | On the stick? | Label |
|---|---|---|
| Tested | Yes | Tested, with the date and what it ran on |
| Read-only, not yet tested | Yes | UNTESTED, in `VERSION.txt` |
| Changes AD or a server, not yet tested | No - held back until it passes in the lab | Listed as held back in `VERSION.txt` |
| Homelab-only checks (Bash) | No | Not part of the field set |

A read-only script can be wrong, but it cannot break anything. If an untested discovery report
gets a number wrong, the cost is a confusing report. A script that creates users or changes
groups on a production domain is a different category of risk, so it does not leave the repo
until it has passed three runs in the lab:

1. **`-WhatIf`** - every script that changes something supports it. The output shows exactly
   what would change, and nothing is changed.
2. **A real run** - the changes are made, and the result is checked by eye against what
   should exist.
3. **A second real run** - run it again, unchanged. Every line should come back as "exists" or
   "skipping." A script that is not safe to re-run is not safe to run after a partial failure,
   which is exactly when it gets re-run.

## The linter, on PowerShell 5.1

Every script in the toolkit is written for Windows PowerShell 5.1, because 5.1 is on every
Windows machine a technician will touch and PowerShell 7 is not. So every new or changed script is checked
with PSScriptAnalyzer, Microsoft's linter for PowerShell, on 5.1 before it is committed.

A linter works like a spell checker for code. It reads the script without running it and flags
patterns that are usually mistakes. Most of the time it is right. Sometimes it flags something
that is correct, because it can only see the one line in front of it, not the reason the line
is there. Simply put: a linter warning is a question, not a verdict.

The last batch of scripts produced two findings worth talking about, and I handled them two
different ways on purpose.

### Finding one: an "unused" variable that was really a guard

`Get-ReplicationEvidence` starts by confirming that it is running on a domain controller. The
check stored its result in a variable, and nothing ever read that variable. PSScriptAnalyzer
flagged it (`PSUseDeclaredVarsMoreThanAssignments`: assigned, never used).

The analyzer was right that the variable was unused. It was wrong about what that meant. The
line was not there to keep a value; it was there to fail. The script stops on any error, so if
the machine is not a domain controller, that lookup throws and the script ends before it
collects anything. The fix was to say so in the code. The pattern, not the script itself:

```powershell
# Before: flagged, because $Check is assigned and never read
$Check = Get-Something -Identity $env:COMPUTERNAME   # throws if this machine is the wrong kind

# After: same behavior, and the intent is on the page
$null = Get-Something -Identity $env:COMPUTERNAME    # throws if this machine is the wrong kind
```

Assigning to `$null` tells both the linter and the next person reading it that the value is
being thrown away deliberately. Behavior unchanged, warning gone, intent documented.

### Finding two: a ShouldProcess warning that was a false positive

`Set-CloudSyncMatch` has a small inner function that sets a password. PSScriptAnalyzer flagged
it (`PSUseShouldProcessForStateChangingFunctions`): a function that changes something should
support `-WhatIf` itself.

In general that is good advice. Here it was a false positive. Both places that call the inner
function already ask `ShouldProcess` before they call it, so under `-WhatIf` the function never
runs at all. Adding a second check inside it would have meant asking the same question twice.
So the warning was suppressed, with the reason written next to the suppression:

```powershell
function Set-Thing {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'Every caller already checks ShouldProcess first')]
    param(...)
```

### Why one got fixed and the other got suppressed

| | Finding one | Finding two |
|---|---|---|
| Was the analyzer's observation true? | Yes - the variable was unused | No - the function is already gated |
| Was the code wrong? | No, but its intent was invisible | No |
| What was done | Fixed: `$null =` | Suppressed, with a written justification |
| Behavior change | None | None |

The rule: fix real findings, even harmless ones, and suppress a false positive only
with a written reason. A suppression with no reason looks exactly like someone silencing a
warning they did not want to deal with. With the reason next to it, the next reader can check
the claim instead of trusting it.

After both changes, the only warnings left were the deliberate `Write-Host` ones in a script
that talks to the person running it.

## What is next: testing

All 25 scripts are written. Two have run on a real build. The other 23 are marked UNTESTED,
and that is the honest state of things.

The plan runs in the order the test systems allow: the scripts that need no domain go first,
on my own PC (subnet math, network triage, installed software, disk report, mail DNS records),
then the Microsoft 365 reports on my own tenant, then everything that touches Active Directory
once the lab domain controller is rebuilt. Each one that passes gets its status updated, moves
to Tested in the backlog, and becomes a candidate for a download on the
[scripts page](/reference/scripts/).

I need to find more normal hobbies. Maybe I'll take up knitting or something?

Thanks for reading! - Evan
