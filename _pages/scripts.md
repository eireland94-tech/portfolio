---
layout: page
title: Script Template Repository
description: A parameterized PowerShell toolkit – configuration separated from logic, CSV input, dry-run support. Being built to the pattern documented in the Field Manual.
permalink: /reference/scripts/
image:
---

[← Back to the Reference Library](/reference/)

{: .note }
This section is being built. The pattern below is settled and documented; the scripts are being converted to it one at a time as I use them.

Most of the PowerShell I have written so far lives inline inside the [Field
Manual](/reference/field-manual/) and the [build
playbook](/reference/playbooks/) – pasted into a console, edited in place, run
once. That is fine for a lab and useless for a job. A script that needs its
guts edited before every run is not a tool, it is a snippet.

## What this is being built toward

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

## Planned first

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

     3. Delete the "This section is being built" note at the top once there is
        at least one real script here.

     Before publishing ANY script, re-read it for hard-coded hostnames, IPs,
     usernames, domains, and anything that looks like a password. Rule 1 of the
     Field Manual's maintenance protocol applies to scripts too: strip the client.
=========================================================================== -->
