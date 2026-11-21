---
layout: page
title: Script Template Repository
description: "The PowerShell and Bash toolkit I use for MSP work: 25 scripts in a private repo, every one listed here with its status, and the two that have run on a real build published as downloads."
permalink: /reference/scripts/
image:
---

[← Back to the Reference Library](/reference/)

{: .note }
The toolkit holds 25 scripts. Two are published here as downloads, both from the [Entra join, Autopilot & Intune project](/projects/entra-autopilot-intune-endpoint/), because they are the only two that have run on a real build. The other 23 are listed below by name, purpose and status, with no code, until they have been tested. The master copies live in a private Git repo; the published copies are byte-identical to it, and contain no organization-specific values. Most of the code was written with Claude, working from my Field Manual and build notes; what gets tested, released and published is my call.

Before October 2026, most of my PowerShell lived inline inside the [Field
Manual](/reference/field-manual/) and the [build
playbook](/reference/playbooks/) – pasted into a console, edited in place, run
once. That is fine for a lab and useless for a job. A script that needs its
guts edited before every run is not a tool, it is a snippet. The toolkit is
what replaced the snippets.

## Published scripts

These two came out of a real build, the cloud-native Windows laptop documented in the [project write-up](/projects/entra-autopilot-intune-endpoint/) and the [companion post](/posts/autopilot-intune-work-laptop/). Neither is converted to the config-file pattern below yet; each is a single standalone script with its settings at the top.

Both were renamed in October 2026 to use PowerShell's approved verbs, so the name says what the script does: `Get-` only reads, `Remove-` changes something. The old files, `Remove-Bloat.ps1` and `Inspect-Laptop.ps1`, still download from their original links. They are the 1.0 versions that ran in that build and are not updated.

Both downloads below are version 1.1, copied unchanged from the master at commit `5e6986b`.

### Remove-InboxApps.ps1

Removes a short, explicit list of consumer inbox apps (Solitaire, Xbox, News, Clipchamp and similar) from a Windows 11 Pro device during Autopilot device preparation. It matches exact package names only, refuses to touch a protected list (Copilot, Teams, Outlook, winget, the Store, Windows Security, Company Portal), is safe to run twice, and writes a full transcript so the result can be proven later. It exists because the Microsoft-native app removal policy only applies to Enterprise and Education editions, and Microsoft 365 Business Premium licenses Pro. Set `$DryRun = $true` to log what would be removed without removing anything.

**Status:** version 1.0 ran through Intune on a real build on 30SEP26. The one 1.1 change, the `$OrgFolder` setting for the log folder, has not run yet.

**[Download →](/assets/scripts/Remove-InboxApps.ps1)**

```powershell
# ==================== EDIT THIS BLOCK, NOT THE CODE BELOW ====================

# Set to $true to log what WOULD be removed without removing anything.
$DryRun = $false

# Folder name under C:\ProgramData for the log - use the org that manages the device.
# The verification step checks C:\ProgramData\<this>\Logs\ afterwards.
$OrgFolder = 'Servitor'

# Exact package names (the part before the first underscore in the full package name).
# Anything not listed here is left alone.
$RemoveList = @(
    'Microsoft.BingNews'                      # News
    'Microsoft.MicrosoftSolitaireCollection'  # Solitaire
    'Microsoft.GamingApp'                     # Xbox app
    'Microsoft.XboxGamingOverlay'             # Game Bar
    'Microsoft.WindowsFeedbackHub'            # Feedback Hub
    'Clipchamp.Clipchamp'                     # Clipchamp video editor
    # ...and the rest of the list in the download
)
```

### Get-DeviceIntakeReport.ps1

A read-only intake inspection for a new or unknown Windows device, run before the machine is wiped, enrolled or taken over. It reports the hardware as actually installed (model, serial, RAM sticks, disks), the Windows license carried in the firmware versus the one in use, license channel and activator traces, OEM or reseller customizations that a Windows reset would not remove, and whether the platform is ready for Entra join and device association (TPM 2.0, Secure Boot, network adapters). It changes nothing. It prints the report on screen and saves a text file beside itself, or to the folder given with `-OutputPath`, so it can run from a USB stick at the OOBE command prompt and the report survives the wipe.

**Status:** version 1.0 ran on a real laptop intake on 30SEP26. The 1.1 changes (generic wording, the `-OutputPath` parameter) have not run yet. The checks themselves are unchanged.

**[Download →](/assets/scripts/Get-DeviceIntakeReport.ps1)**

```powershell
[CmdletBinding()]
param(
    [string]$OutputPath
)

$ErrorActionPreference = 'Continue'

# ---- Where to write the report: -OutputPath if given, otherwise the folder this script lives in ----
$outDir = $OutputPath
if (-not $outDir) { $outDir = $PSScriptRoot }
if (-not $outDir) { $outDir = (Get-Location).Path }
if (-not (Test-Path -LiteralPath $outDir)) { New-Item -Path $outDir -ItemType Directory -Force | Out-Null }
$stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
$out    = Join-Path $outDir "Inspection-$env:COMPUTERNAME-$stamp.txt"

$report = New-Object System.Collections.Generic.List[string]
function Add-Line   { param([string]$Text) $report.Add($Text) }
function Add-Section { param([string]$Title) $report.Add(''); $report.Add("===== $Title =====") }
function Add-Table  { param($Object) $report.Add(($Object | Format-Table -AutoSize | Out-String -Width 220).TrimEnd()) }
```

Review both before running them anywhere that matters. A script that removes software deserves a read-through and a dry run first.

## Everything in the toolkit

Every script in the private repo, by folder. **Read-only** means the script only looks: it changes nothing on the machine, the domain or the tenant. **UNTESTED** means it has been written and checked for syntax, but has not yet run against a real system and had its output checked line by line. A script is not trustworthy until that has happened, which is why none of these are downloads yet.

### Windows\Intake and Windows\Intune

| Script | What it does | Type | Status |
|---|---|---|---|
| `Get-DeviceIntakeReport` | Inspects a new or unknown device before it is wiped or enrolled (published above) | Read-only | 1.0 tested 30SEP26 |
| `Remove-InboxApps` | Removes consumer inbox apps during Autopilot, deployed through Intune (published above) | Changes the device | 1.0 tested 30SEP26 |

### Windows\Endpoint

| Script | What it does | Type | Status |
|---|---|---|---|
| `Test-EndpointBuild` | Post-build proof for one machine: join state, activation, local admins, BitLocker, LAPS, Defender, apps, drivers | Read-only | UNTESTED |
| `Test-DomainJoinReadiness` | DNS, SRV records, clock skew, ports and name length, checked before a domain join | Read-only | UNTESTED |
| `Get-InstalledSoftware` | Installed software from the registry, 32-bit, 64-bit and per-user | Read-only | UNTESTED |
| `Get-DiskReport` | Volumes, disk health and wear, the usual space hogs, largest files | Read-only | UNTESTED |
| `Get-UserProfileInventory` | What one Windows login depends on (per-user installs, mapped drives, printers, shortcut targets, browser and Office sign-ins) before that profile is changed | Read-only | UNTESTED |

### Windows\Server

| Script | What it does | Type | Status |
|---|---|---|---|
| `New-FileShares` | Creates or updates file shares with access-based enumeration. Does not set NTFS permissions | Changes the server | UNTESTED |

### Network

| Script | What it does | Type | Status |
|---|---|---|---|
| `Test-NetworkTriage` | The "internet is down" ladder: IP stack, gateway, off-LAN by IP, DNS, the service itself. Stops at the first layer that fails and says which one | Read-only | UNTESTED |
| `Get-NetworkInventory` | TCP port check on a short list of hosts with real timeouts, optional traceroute, CSV out | Read-only | UNTESTED |
| `Get-SubnetInfo` | Subnet math from CIDR, prefix or mask, with a compare option | Read-only | UNTESTED on Windows (math checked in PowerShell 7) |

### ActiveDirectory

| Script | What it does | Type | Status |
|---|---|---|---|
| `Test-DomainHealth` | `dcdiag`, replication, FSMO roles, time, SYSVOL and Recycle Bin in one readable pass | Read-only | UNTESTED |
| `Get-ReplicationEvidence` | Collects an evidence file on each domain controller when replication fails, so the files can be compared side by side | Read-only | UNTESTED |
| `Get-EnvironmentDiscovery` | First-day discovery of an existing environment, each section independent, exported to files | Read-only (writes report files) | UNTESTED |
| `Get-LockoutSource` | Reads the lockout and Kerberos failure events to find which device keeps locking an account | Read-only | UNTESTED |
| `Get-MonthlyMaintenanceReport` | The monthly pass: AD health, backups, disk, admin groups, account hygiene, certificates, directory sync | Read-only | UNTESTED |
| `New-OUStructure` | Builds an organizational unit tree from a config file | Changes AD | UNTESTED |
| `New-AgdlpGroups` | Creates global and domain local groups per department and nests them (the AGDLP pattern) | Changes AD | UNTESTED |
| `New-BulkUsers` | Creates users from a CSV, each with a unique random password | Changes AD | UNTESTED |
| `Set-CloudSyncMatch` | Matches existing Microsoft 365 users onto AD accounts in batches, then adds each one to the sync scope only on a per-person yes | Changes AD | UNTESTED |

### M365

| Script | What it does | Type | Status |
|---|---|---|---|
| `Get-DnsMailRecords` | MX, SPF, DMARC, DKIM and NS check for a domain, with the common mistakes flagged | Read-only | UNTESTED |
| `Get-SharedMailboxReport` | Shared mailboxes: sign-in still enabled, size against license, delegates, sent-item copies | Read-only | UNTESTED |
| `Get-GuestUserReport` | Guest accounts that never accepted, went stale, or are disabled | Read-only | UNTESTED |

### Linux

| Script | What it does | Type | Status |
|---|---|---|---|
| `pve-node-check.sh` | Proxmox node check: virtualization flags, time, storage, SMART, quorum | Read-only (homelab) | UNTESTED |
| `dns-stack-check.sh` | Unbound and Pi-hole checks, including the DNSSEC false-pass and DNS interception tests | Read-only (homelab) | UNTESTED |

Every script that changes something supports `-WhatIf` and writes a log. That does not make an untested one safe to run on a production domain, and it will not be published until it has passed in the lab.

## How the toolkit is kept

The same scripts live in three places: the private repo, a USB stick carried to jobs, and this page. Three copies of anything drift unless something stops them, so the rules are short and strict.

- **One master copy.** The private Git repo is the only place a script is ever edited. Every other copy is made from it and never touched by hand. A fix made on the stick or on this site would be a fork nobody remembers.
- **Copies come from a clean commit.** Nothing is copied out while there are uncommitted changes, so every copy matches a commit that exists.
- **The field copy is checked, not trusted.** The USB stick is encrypted with BitLocker To Go. Each release to it includes a `VERSION.txt` that names the commit and lists what is on the stick and what was held back. After copying, every file is read back off the stick and its SHA-256 hash is compared to the repo.
- **The stick carries a field set, not the whole repo.** Tested scripts go on it, along with read-only ones labeled UNTESTED in `VERSION.txt`: a read-only script can be wrong, but it cannot break anything. A script that changes AD or a server goes on only after a lab pass: a `-WhatIf` run, a real run, and a second real run that proves it is safe to re-run.
- **Every script is generic.** Anything that differs between environments (domain names, OU paths, group names) is discovered at run time or passed in as a parameter or config file. Config files and script output never go in the repo. A script written for one environment is made generic before it is added.
- **This page gets byte-identical copies.** A published script is the same file as the master at the commit named above, checked for anything that is not a placeholder (`contoso.com`, `<ORG>`, `203.0.113.x`) before it goes up.
- **Every new or changed script is linted.** The PowerShell linter runs on Windows PowerShell 5.1 before it is committed. Real findings get fixed; a false positive is suppressed only with a written reason next to the suppression.

## The toolkit pattern

The target is a toolkit where **configuration data is separated from logic**:
one script that takes parameters, one config file per environment, and no
editing of the script itself between runs.

```
Servitor\
├── _Template\
│   └── Script-Template.ps1      every new script starts from this
├── config\
│   └── example.psd1             per-environment values live in a .psd1; real ones never enter the repo
├── input\                       example CSVs only; real ones never enter the repo
├── Windows\
│   ├── Intake\                  before touching a device (1 script)
│   ├── Endpoint\                one Windows machine (5)
│   ├── Intune\                  deployed through Intune (1)
│   └── Server\                  server builds (1)
├── Network\                     triage, ports, subnet math (3)
├── ActiveDirectory\             health, discovery, builds (9)
├── M365\                        mail DNS, mailboxes, guests (3)
├── Linux\                       homelab checks in Bash (2)
├── Release\                     the README that goes on the USB stick
├── BACKLOG.md                   the testing tracker: where each script can be tested
├── CHANGELOG.md
└── README.md                    the rules and the release process
```

Each script is standalone: copy one file to a machine and it runs. The few
lines they share are repeated on purpose, so a script never breaks because a
helper file did not come with it.

Every script gets the same four properties, because these are what separate a
script you can hand someone from one you cannot:

| Property | What it means in practice |
|---|---|
| **Parameterized** | No values hard-coded in the body. Environment differences live in the config file. |
| **Idempotent** | Safe to re-run after a partial failure. Create-or-update, never create-or-fail. |
| **Dry-runnable** | `-WhatIf` shows exactly what would change and changes nothing. |
| **Fail-soft** | Per-item `try/catch`, so one bad CSV row does not abort the other 39. |

The reasoning behind each of those, and the full worked example, is in the Field
Manual under `[TOOLKIT-01]` through `[TOOLKIT-07]`, with the safety pattern at
`[PS-BULK]` and the idempotence pattern at `[PS-10]`.

## Testing next

Every script on the original list is now written. What is left is testing, in
the order the test systems allow:

1. **On my own PC, no domain needed:** `Get-SubnetInfo`, `Test-NetworkTriage`,
   `Get-InstalledSoftware`, `Get-DiskReport`, `Get-DnsMailRecords`
2. **On my own tenant:** `Get-SharedMailboxReport`, `Get-GuestUserReport`
3. **In the lab, once the domain controller is rebuilt:** everything in
   `ActiveDirectory\`, `Test-DomainJoinReadiness` and `New-FileShares`,
   with the change scripts going through `-WhatIf`, a real run and a second run

Each one that passes gets its header status updated, moves to Tested in the
backlog, and becomes a candidate for a download on this page.

<!-- ===========================================================================
     HOW TO PUBLISH A SCRIPT HERE

     0. Only a Tested script is published. Copy it from the master repo at a
        clean commit, unchanged (byte-identical: compare the SHA-256 hashes),
        and name that commit in the "Published scripts" section.
     1. Put the .ps1 file in  assets/scripts/
     2. Add a section under "Published scripts":

          ### Test-DomainHealth.ps1

          One or two sentences on what it does and when you would reach for it.

          **Status:** what it ran on, and when.

          **[Download →](/assets/scripts/Test-DomainHealth.ps1)**

          ```powershell
          # paste the first 15-20 lines so people can see the shape
          # without downloading it
          ```

     3. Update its row in "Everything in the toolkit" and the counts in the
        note at the top and in the description.

     Before publishing ANY script, re-read it for hard-coded hostnames, IPs,
     usernames, domains, and anything that looks like a password. Example
     values must be placeholders: contoso.com, <ORG>, 203.0.113.x. If the
     master has a real value in it, fix the master first, commit, then copy.
     Never edit the copy here. Rule 1 of the Field Manual's maintenance
     protocol applies to scripts too: strip the client.
=========================================================================== -->
