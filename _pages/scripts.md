---
layout: page
title: Script Template Repository
description: PowerShell scripts published from my own builds, plus the parameterized toolkit pattern the rest are being converted to. Two scripts are live; four more are planned.
permalink: /reference/scripts/
image:
---

[← Back to the Reference Library](/reference/)

{: .note }
Two scripts are published so far, both from the [Entra join, Autopilot & Intune project](/projects/entra-autopilot-intune-endpoint/). The toolkit pattern below is settled and documented; the remaining scripts are being converted to it one at a time as I use them.

Most of the PowerShell I have written so far lives inline inside the [Field
Manual](/reference/field-manual/) and the [build
playbook](/reference/playbooks/) – pasted into a console, edited in place, run
once. That is fine for a lab and useless for a job. A script that needs its
guts edited before every run is not a tool, it is a snippet.

## Published scripts

These two came out of a real build, the cloud-native Windows laptop documented in the [project write-up](/projects/entra-autopilot-intune-endpoint/) and the [companion post](/posts/autopilot-intune-work-laptop/). Both have had the organization-specific values removed. Neither is converted to the config-file pattern below yet; each is a single standalone script with its settings at the top.

### Remove-Bloat.ps1

Removes a short, explicit list of consumer inbox apps (Solitaire, Xbox, News, Clipchamp and similar) from a Windows 11 Pro device during Autopilot device preparation. It matches exact package names only, refuses to touch a protected list (Copilot, Teams, Outlook, winget, the Store, Windows Security, Company Portal), is safe to run twice, and writes a full transcript so the result can be proven later. It exists because the Microsoft-native app removal policy only applies to Enterprise and Education editions, and Microsoft 365 Business Premium licenses Pro. Set `$DryRun = $true` to log what would be removed without removing anything.

**[Download →](/assets/scripts/Remove-Bloat.ps1)**

```powershell
# Set to $true to log what WOULD be removed without removing anything.
$DryRun = $false

# Folder name used under C:\ProgramData for the log. Change it to your organization's short name.
$OrgName = 'ORG'

# ---- EDIT THIS LIST, NOT THE CODE BELOW ----
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

### Inspect-Laptop.ps1

A read-only pre-flight inspection for a new or unknown Windows laptop, run before the machine is wiped. It reports the hardware as actually installed (model, serial, RAM sticks, disks), the Windows license carried in the firmware versus the one in use, license channel and activator traces, reseller customizations that a Windows reset would not remove, and whether the platform is ready for Entra join and device association (TPM 2.0, Secure Boot, network adapters). It changes nothing. It prints the report on screen and saves a text file beside itself, so it can run from a USB stick at the OOBE command prompt.

**[Download →](/assets/scripts/Inspect-Laptop.ps1)**

```powershell
$ErrorActionPreference = 'Continue'

# ---- Where to write the report: the folder this script lives in (the USB stick) ----
$outDir = $PSScriptRoot
if (-not $outDir) { $outDir = (Get-Location).Path }
$stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
$out    = Join-Path $outDir "Inspection-$env:COMPUTERNAME-$stamp.txt"

$report = New-Object System.Collections.Generic.List[string]
function Add-Line   { param([string]$Text) $report.Add($Text) }
function Add-Section { param([string]$Title) $report.Add(''); $report.Add("===== $Title =====") }
function Add-Table  { param($Object) $report.Add(($Object | Format-Table -AutoSize | Out-String -Width 220).TrimEnd()) }
```

Review both before running them anywhere that matters. They are written for the build described above, and a script that removes software deserves a read-through and a dry run first.

## The toolkit pattern

### What this is being built toward

The target is a toolkit where **configuration data is separated from logic**:
one script that takes parameters, one config file per environment, and no
editing of the script itself between runs.

```
toolkit\
├── config\
│   ├── contoso.psd1          per-environment values: OU paths, UPN suffix, share roots
│   └── homebiz.psd1
├── scripts\
│   ├── New-LabUsers.ps1      takes -ConfigPath and -CsvPath, supports -WhatIf
│   ├── Test-DomainHealth.ps1
│   └── Get-NetworkInventory.ps1
└── README.md
```

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

### Planned first

In the order they are actually needed:

1. **`Test-DomainHealth.ps1`** – wraps the `dcdiag` / `repadmin` / `w32tm`
   block from `[AD-HEALTH]` into one command with readable output
2. **`New-LabUsers.ps1`** – bulk user creation from CSV with unique generated
   passwords, `-WhatIf` support, and per-row error handling
3. **`Get-NetworkInventory.ps1`** – the discovery block from `[ASSESS-01]`,
   exporting to CSV instead of scrolling past in a console
4. **`Invoke-PreJoinCheck.ps1`** – the four pre-domain-join verifications from
   `[WIN-PREJOIN]`, run in order, with a clear pass or fail

In the meantime, the working versions of all four are readable in the [Field
Manual](/reference/field-manual/). They run; they just need editing first.

<!-- ===========================================================================
     HOW TO PUBLISH A SCRIPT HERE

     1. Put the .ps1 file in  assets/scripts/  (create the folder the first time)
     2. Add a section to this page:

          ## Test-DomainHealth.ps1

          One or two sentences on what it does and when you would reach for it.

          **[Download →](/assets/scripts/Test-DomainHealth.ps1)**

          ```powershell
          # paste the first 15-20 lines so people can see the shape
          # without downloading it
          ```

     3. The "being built" note at the top was trimmed when the first scripts
        went up. Update it if the balance of published to planned changes.

     Before publishing ANY script, re-read it for hard-coded hostnames, IPs,
     usernames, domains, and anything that looks like a password. Rule 1 of the
     Field Manual's maintenance protocol applies to scripts too: strip the client.
=========================================================================== -->
