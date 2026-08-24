# IT FIELD MANUAL

**A living, searchable operational reference for Windows, Active Directory, Microsoft 365, Entra ID, Intune, and Azure.**

| | |
|---|---|
| **Version** | 1.3 |
| **Compiled** | 19 August 2026 · **Updated 23 August 2026** |
| **Scope** | Networking and security fundamentals → endpoint support → AD/hybrid infrastructure → public DNS and mail flow → cloud administration → data governance and AI administration |
| **Format** | Markdown. Renders on phone, laptop, GitHub, Obsidian, VS Code. Search with Ctrl+F / Cmd+F. |
| **Status** | Living document. See [§00.3 Maintenance Protocol](#003--maintenance-protocol-how-to-add-to-this-manual). |

---

---

## CONTENTS

| § | Section | Key tags |
|---|---|---|
| **00** | [How to use this manual](#00--how-to-use-this-manual) | search tags · conventions · **maintenance protocol** |
| **01** | [Troubleshooting doctrine](#01--troubleshooting-doctrine-doctrine) | `[DOCTRINE-01]`…`[DOCTRINE-10]` |
| **02** | [PowerShell fundamentals](#02--powershell-fundamentals-ps) | `[PS-01]`…`[PS-11]` · `[PS-BULK]` · `[PS-EXEC]` |
| **03** | [CMD ↔ PowerShell equivalents](#03--cmd--powershell-equivalents-ps-cmd) | `[PS-CMD]` · `[WIN-INV]` |
| **04** | [Network diagnostics](#04--network-diagnostics-net) | `[NET-01]`…`[NET-11]` · `[NET-TRIAGE]` |
| **05** | [Active Directory operations](#05--active-directory-operations-ad) | `[AD-HEALTH]` · `[AD-TIME]` · `[AD-AGDLP]` · `[AD-UPN]` · `[AD-LOCKOUT]` · `[SEC-LAPS]` |
| **06** | [Greenfield build order](#06--greenfield-build-order-ad-build) | `[BUILD-P0]`…`[BUILD-P14]` · `[AD-FAILOVER]` · `[AZ-ARC]` |
| **07** | [Group Policy](#07--group-policy-gpo) | `[GPO-01]`…`[GPO-06]` · `[GPO-DRIVEMAP]` · `[GPO-TRIAGE]` |
| **08** | [File services and permissions](#08--file-services-and-permissions-file) | `[FILE-02]` · `[FILE-502]` · `[FILE-TRIAGE]` |
| **09** | [Hybrid identity](#09--hybrid-identity-hyb) | `[HYB-SCP]` · `[HYB-SYNC]` · `[HYB-LIC]` · `[HYB-JOIN]` |
| **10** | [Intune and device management](#10--intune-and-device-management-mdm) | `[MDM-OWNERSHIP]` · `[MDM-02]`…`[MDM-09]` |
| **11** | [Microsoft 365 administration](#11--microsoft-365-administration-m365) | `[M365-01]`…`[M365-07]` |
| **12** | [Azure fundamentals reference](#12--azure-fundamentals-reference-az) | `[AZ-01]`…`[AZ-11]` · `[AZ-RBAC-VS-ENTRA]` |
| **13** | [Windows client build and domain join](#13--windows-client-build-and-domain-join-win) | `[WIN-OOBE]` · `[WIN-PREJOIN]` · `[AD-JOIN-FAIL]` · `[WIN-POSTJOIN]` |
| **14** | [Storage and disk operations](#14--storage-and-disk-operations-disk) | `[DISK-01]`…`[DISK-03]` |
| **15** | [Standard operating procedures](#15--standard-operating-procedures-sop) | `[SOP-01]`…`[SOP-12]` · `[SEC-IR]` |
| **16** | [Assessing an inherited network](#16--assessing-an-inherited-network-assess) | `[ASSESS-01]`…`[ASSESS-03]` |
| **17** | [Decommissioning a hybrid environment](#17--decommissioning-a-hybrid-environment-decom) | `[DECOM-P0]`…`[DECOM-P12]` |
| **18** | [Error → cause → fix master index](#18--error--cause--fix-master-index-err) | `[ERR]` — **search here first** |
| **19** | [Script library and toolkit pattern](#19--script-library-and-toolkit-pattern-toolkit) | `[TOOLKIT-01]`…`[TOOLKIT-07]` |
| **20** | [Documentation templates](#20--documentation-templates-doc) | `[DOC-01]`…`[DOC-05]` |
| **21** | [Appendices](#21--appendices) | `[APX-A]` checklists · `[APX-C]` **corrections log** · `[APX-D]` rebuild drill |
| **22** | [Networking fundamentals](#22--networking-fundamentals-netf) | `[NETF-01]`…`[NETF-19]` · **layer-based triage** · CIDR · DNS records · DORA |
| **23** | [Security fundamentals](#23--security-fundamentals-secf) | `[SECF-01]`…`[SECF-17]` · **authn vs authz** · Kerberos flow · crypto · AAA |
| **24** | [Systems and directory fundamentals](#24--systems-and-directory-fundamentals-sysf) | `[SYSF-01]`…`[SYSF-06]` · MBR/GPT · LDAP bind · SAM |
| **25** | [Personal additions](#25--personal-additions) | your new entries go here |
| **26** | [Microsoft Purview and data governance](#26--microsoft-purview-and-data-governance-purv) | `[PURV-01]`…`[PURV-19]` · labels · DLP · IRM · retention · eDiscovery · DSPM for AI · **simulation-mode trap** |
| **27** | [Copilot and agent administration](#27--copilot-and-agent-administration-ai) | `[AI-01]`…`[AI-21]` · oversharing · RAC/RCD/RSS · licensing · agents · Agent 365 |
| **28** | [Public DNS for mail](#28--public-dns-for-mail-dns-mail) | `[DNS-MAIL-00]`…`[DNS-MAIL-08]` · MX · SPF · DKIM · DMARC · DNSSEC · wildcards |
| **29** | [Exchange Online administration](#29--exchange-online-administration-exo) | `[EXO-00]`…`[EXO-14]` · message trace · quarantine · shared mailboxes · delegation · `[EXO-PROXY]` |
| **30** | [SharePoint Online and OneDrive — sharing and guest access](#30--sharepoint-online-and-onedrive--sharing-and-guest-access-spo) | `[SPO-01]`…`[SPO-08]` · external sharing · guests · people picker |

### Fast paths — the five things you will look up most

| Situation | Go to |
|---|---|
| Something is broken and you have an error message | **§18** `[ERR]` |
| A user cannot log in | `[AD-LOCKOUT]` → `[ASSESS-03]` |
| Group Policy is not applying | `[GPO-TRIAGE]` |
| A device is not showing up in Intune | `[HYB-JOIN]` → `[MDM-04]` |
| You are walking into a network you have never seen | `[ASSESS-01]` |
| A diagnostic returned something you cannot interpret | **§22** `[NETF-01]` layer-based triage |
| Someone can sign in but cannot access something | `[SECF-08]` — that is **authz**, not authn |
| A client wants to deploy Copilot | `[AI-07]` readiness runbook — **start with the permissions, not the licenses** |
| Copilot showed someone something they shouldn't see | `[AI-03]` — this is oversharing, not a Copilot fault |
| You need the right Purview tool for a described problem | **§26** `[PURV-01]` solution map |
| A client described a problem in their own words | `[APX-G]` requirement → tool index |
| Two products sound like they do the same thing | `[APX-F]` disambiguation index |
| A client can send email but cannot receive it | `[DNS-MAIL-08]` — verified-but-unconfigured domain |
| A message "never arrived" | `[EXO-01]` — read the trace boundary before anything else |
| Someone shared a file externally and the recipient got nothing | `[SPO-06]` — read the confirmation dialog first |
| A test passed and you are not sure you believe it | `[DOCTRINE-11]` — inventory the overrides |

## 00 — HOW TO USE THIS MANUAL

### 00.1 — Search tags

Every major block carries a bracketed tag. **Search the tag, not the prose.** Tags are stable across versions, so a note you write today that says "see `[AD-JOIN-FAIL]`" still resolves in version 12.

| Prefix | Domain |
|---|---|
| `[DOC]` | Documentation templates, ticket formats |
| `[PS]` | PowerShell language, syntax, safety patterns |
| `[NET]` | Networking, DNS, DHCP, diagnostics, ports — **the commands** |
| `[NETF]` | Networking fundamentals — protocols, layers, addressing — **the reasoning** |
| `[AD]` | Active Directory operations and build |
| `[GPO]` | Group Policy |
| `[FILE]` | File services, shares, NTFS, permissions |
| `[HYB]` | Hybrid identity — Entra Connect, hybrid join, SCP |
| `[MDM]` | Intune, device management, compliance |
| `[M365]` | Exchange Online, SharePoint, OneDrive, Graph, licensing — **the tenant-wide view** |
| `[DNS-MAIL]` | Public DNS for mail — MX, SPF, DKIM, DMARC, autodiscover, DNSSEC |
| `[EXO]` | Exchange Online depth — message trace, quarantine, mailboxes, delegation, proxy addresses |
| `[SPO]` | SharePoint Online and OneDrive — external sharing, guest access, permissions |
| `[AZ]` | Azure architecture, governance, cost |
| `[WIN]` | Windows client build, OOBE, imaging |
| `[DISK]` | Storage, partitioning, BitLocker, recovery |
| `[SOP]` | Standard operating procedures / runbooks |
| `[ASSESS]` | Assessing and inheriting an existing network |
| `[DECOM]` | Decommissioning |
| `[ERR]` | Error → cause → fix index |
| `[SEC]` | Security, incident response, least privilege — **the procedures** |
| `[SECF]` | Security fundamentals — crypto, AAA, threat taxonomy — **the concepts** |
| `[SYSF]` | OS, filesystem, partitioning, directory service concepts |
| `[PURV]` | Microsoft Purview — classification, labels, DLP, retention, eDiscovery, compliance |
| `[AI]` | Microsoft 365 Copilot and agents — readiness, licensing, governance, administration |

### 00.2 — Conventions

| Marker | Meaning |
|---|---|
| **WHY** | The reasoning. This is what you say when a client or senior engineer asks why you did it that way. It is also what makes the step transferable to a different environment. |
| **⚠ TRAP** | Easy to walk into, annoying to walk back out of. |
| **🛑 DANGER** | Causes real damage — data loss, lockout, outage. Read before acting. |
| **✅ VERIFY** | How you prove the step worked before moving on. Do not skip these. Most painful troubleshooting comes from three steps stacked on top of an unverified one. |
| **🔄 UPDATED** | This differs from what an older reference told you. The change and its date are stated. |

**Placeholders used throughout:**

| Placeholder | Meaning | Example |
|---|---|---|
| `ad.contoso.com` | Internal AD DNS domain — a subdomain of a domain the client actually owns | `ad.acme.com` |
| `CONTOSO` | NetBIOS name — short, uppercase, no spaces | `ACME` |
| `SITE-DC01` | Domain controller | `RC-DC01` |
| `10.10.10.0/24` | Server / client subnet | Whatever the client uses |
| `OU=Contoso,DC=ad,DC=contoso,DC=com` | Top-level organization OU — everything you build lives under here | |

### 00.3 — Maintenance protocol (how to add to this manual)

This document is only useful if adding to it is frictionless. The rule is: **capture on the day it happened, in the format below, and file it under the right tag.**

**When you learn something, write these seven fields and nothing else:**

```
### [TAG-NN] Short imperative title
Symptom:        What the user or the system reported.
Environment:    OS, role, product version. Enough that Future You knows if it applies.
Actual cause:   The real one, not the first theory.
Fix:            Numbered steps. Commands in full.
Verify:         The command or observation that proves it worked.
Prevention:     What would have stopped this from happening.
Date / source:  When, and who or what told you.
```

**Three rules that keep the manual honest:**

1. **Strip the client.** Never file a real hostname, IP, username, or domain. Replace with the placeholder set in §00.2 at the moment of writing, not later. A manual full of `MOCKBIZ01` is a manual you cannot hand anyone.
2. **Record the fix, not the workaround — and if you used a workaround, label it.** A workaround is a modification to the environment, and the environment remembers it long after you forget. Unlabeled workarounds are the single most expensive category of self-inflicted troubleshooting.
3. **Date anything Microsoft can change.** Portal click-paths, product names, and CLI switches rot. Facts about protocols (Kerberos skew, DNS SRV, NTFS evaluation order) do not. Date the first kind; don't clutter the second.

**Quarterly review, 20 minutes:** re-read the `🔄 UPDATED` entries and Appendix C. Confirm anything with a date older than a year still holds. Delete anything you have never once searched for.

---

## 01 — TROUBLESHOOTING DOCTRINE `[DOCTRINE]`

Read this section once a year. It is the part that transfers between every technology in this manual, and it is worth more than any individual command.

### `[DOCTRINE-01]` Confirm the component is in the path before you troubleshoot it

Before spending an hour on a component, ask: **what mechanism is actually supposed to deliver this?**

- Microsoft 365 Apps → the Office CSP over the standard MDM channel.
- A packaged `.intunewin` Win32 app, a PowerShell script, a remediation → the Intune Management Extension.
- A configuration profile → OMA-DM.
- A drive map → Group Policy Preferences, at logon.
- A domain join → DNS SRV lookup, then Kerberos.

Different pipes, different failure modes. Chasing the wrong pipe is how an afternoon disappears. The classic version: spending hours forcing the Intune Management Extension to install in order to fix a Microsoft 365 Apps deployment — the IME is not in that path at all, and its absence was a *symptom* of the real problem, not the cause.

### `[DOCTRINE-02]` Read the error text before forming a theory

When a command fails, read what it actually says. Rewriting correct code because you misread an error costs time twice: once to make the change, and again later when the same error reappears and your earlier "fix" is now confusing evidence.

Worked example: `New-SmbShare` throws *"The name has already been shared"* (Windows system error 2118). That is not a missing-parameter problem. It is the share already existing from a previous partial run. The error names the cause precisely.

### `[DOCTRINE-03]` Know a diagnostic's precondition before you run it

Time spent interpreting the output of an inapplicable test is worse than wasted — it injects noise into the picture you are building. Running `Test-ComputerSecureChannel` on a machine that has not yet joined the domain returns "the local computer is not currently part of a domain," which is the only answer it could have given.

**When a diagnostic returns something confusing, first ask whether it was valid to run at all.**

### `[DOCTRINE-04]` The error message describes the symptom, not the cause

Windows error text is generated at the point of failure, not the point of origin.

- *"An Active Directory Domain Controller could not be contacted"* covers at least five unrelated failures, one of which is a wrong time zone. The DC **was** contacted. It said no.
- *"Bad credentials"* on a DC promotion is frequently name resolution or a time hierarchy problem.
- *"The device isn't in Intune"* is frequently an empty licensing group two phases upstream.

Decode the message into its candidate causes and test them in order of cheapness. See `[ERR]` — the master index in §18.

### `[DOCTRINE-05]` A workaround is a change to the environment. Write it down.

The most expensive troubleshooting sessions are the ones where the cause was introduced by you, days earlier, in a step you no longer remember taking.

Canonical example: manually adding a work account through Settings to get past a broken auto-enrollment. It works. Three days later, application deployments silently never install, because that manual method marked the device **Personal** and Personal-owned devices have deliberately reduced management capability. Nobody connects the two events.

### `[DOCTRINE-06]` Verify negatively, not just positively

"John can open the Sales folder" is half a test. The other half is "Sarah cannot, and cannot even see that it exists."

Every permission, every targeting rule, every filter has two correct outcomes. Test both or you have tested nothing.

### `[DOCTRINE-07]` A backup you have never restored from is a hypothesis

Same for failover. Same for a LAPS deployment where you never actually retrieved a password. Same for a monitoring alert that has never fired. Proving a control works is a separate task from configuring it, and it is the task that gets skipped.

Record the date you tested. "Backup configured" is not a deliverable; "restore tested 2026-08-14" is.

### `[DOCTRINE-08]` On an inherited system: document first, change second, one thing at a time

If you change five things and something breaks, you have five suspects and no way to bisect.

And: **assume anything odd is load-bearing until proven otherwise.** The strange scheduled task, the share nobody can explain, the ancient VM everyone forgot — that is frequently how payroll runs.

### `[DOCTRINE-09]` Build foundation before there are users to disturb

OU structure, security groups, share permissions, GPOs, the UPN suffix, and the MDM enrollment policy are all foundation. Build them after you have users and machines and every change requires you to log into client machines, log off, log back on, clear caches, and retest. Build them first and the first user who logs in gets a finished environment.

This is the single largest efficiency difference between a first build and a fifth build.

### `[DOCTRINE-10]` Escalate on cost of being wrong, not on difficulty

Some things you fix. Some things you flag, document, and hand up. The dividing line is not "is this hard" — it is "what happens if my understanding is incomplete." RDP exposed to the internet, a Domain Admins group with fifteen members, a single point of failure holding all five FSMO roles: report these on day one even when you could technically fix them yourself, because the client needs to own the risk decision.


### `[DOCTRINE-11]` An override makes your diagnostics lie

**A configuration override does not only change behavior. It changes what your tests *report*** — and it does so silently. The test still runs, still returns a result, and the result still looks like an answer.

Three unrelated products, three instances of the same failure:

| Override | What it broke |
|---|---|
| **Wildcard `*` CNAME in a public DNS zone** | Every "does this record exist?" query returned a valid answer. **Five missing records all appeared present.** `[DNS-MAIL-02]` |
| **Allowed-sender entry in an anti-spam policy** | Every "is filtering working again?" test delivered successfully — whether or not the revert had actually taken. `[EXO-07]` |
| **DLP policy in simulation mode** | Policy tips fired, message trace logged rule evaluations, the user got a notification — **and the data still left the tenant unprotected.** `[PURV-17]` |

**The rules:**

1. **Remove overrides before testing, not after.** A revert verified while an override is active is not verified.
2. **Verify at the far end.** DNS answering is not mail flowing. A policy tip is not enforcement. **Check what the recipient actually received**, not what the system reported sending.
3. **When a result matches your expectation, ask what the test could not have told you.** Agreement is not confirmation. A test that cannot fail is not a test.
4. **In an inherited environment, inventory the overrides before you trust any diagnostic.** Wildcard DNS records, allow lists, disabled policies, simulation-mode policies, and preset security policies are all invisible until you look for them specifically. Add the inventory to `[ASSESS-02]`.

**WHY this ranks alongside `[DOCTRINE-07]`:** an untested backup is a hypothesis. A diagnostic run against an overridden system is *worse* than a hypothesis — it is a false confirmation, and you will build three more conclusions on top of it before anything contradicts you.

### `[DOCTRINE-12]` Read the screen before you diagnose

Three separate incidents in one project were solved by information **already displayed on screen**, after time had been spent hunting elsewhere.

| Incident | What the screen already said |
|---|---|
| DNS delegation failing for 45+ minutes | A banner in the M365 admin center: **DNSSEC detected, not supported by Microsoft 365 DNS hosting, disable it to continue.** `[DNS-MAIL-04]` |
| SharePoint share "never arrived" at the recipient | The confirmation dialog **named the actual recipient** — a different, *internal* account resolved by the people picker. `[SPO-06]` |
| Unexplained `Drop` event in a message trace | The event detail read `LED=250 2.1.5 RESOLVER.GRP.Expanded`. **A 250 is an SMTP success code.** `[EXO-03]` |

**The rule: before you form a theory, re-read every banner, confirmation, and error detail already in front of you. Expand the truncated ones.**

Diagnostic effort spent before this step is usually wasted, and it is worse than wasted when it produces a plausible wrong theory that then has to be unwound. **The screen is a source. Treat it like one.**

---

## 02 — POWERSHELL FUNDAMENTALS `[PS]`

### `[PS-01]` Discovery — the four commands that make the rest unnecessary

```powershell
Get-Help <cmdlet>                    # Full help for any cmdlet
Get-Help <cmdlet> -Examples          # Practical usage. Use this one.
Get-Help <cmdlet> -Online            # Opens current Microsoft Learn page in a browser
Get-Command *keyword*                # Find cmdlets by keyword, e.g. Get-Command *user*
Get-Command -Module ActiveDirectory  # Everything a module exposes
Get-Alias                            # Built-in aliases (ls, dir, cls, gci...)
$PSVersionTable                      # Version, edition, OS, build
Update-Help                          # Help files ship empty. Run once per machine, elevated.
```

**Tab** autocompletes cmdlets, parameters, and paths. **Up arrow** cycles history. `Ctrl+R` reverse-searches history in PS7.

### `[PS-02]` Pipeline and filtering

```powershell
Command1 | Command2                                    # Pipe objects, not text
Get-Service | Where-Object { $_.Status -eq "Stopped" } # Filter by property; $_ = current object
Get-Process | Sort-Object CPU -Descending
Get-ADUser -Filter * | Select-Object Name, SamAccountName, Enabled
Get-Process | Where-Object CPU -gt 100                 # Simplified syntax, PS3+; no braces needed
```

**Filter left, format right.** Push filtering as far upstream as possible — use a cmdlet's own `-Filter` parameter before piping to `Where-Object`. `Get-ADUser -Filter *` pulls the entire directory across the wire and then discards it locally; `Get-ADUser -Filter "Department -eq 'Sales'"` filters at the domain controller. On a 20-user lab this is invisible. On a 4,000-user client it is the difference between two seconds and two minutes.

### `[PS-03]` Output and export

```powershell
Select-Object -Property Name, Value          # Pick properties
Select-Object -First 10 / -Last 10
Format-Table -AutoSize                       # Wide data. ALWAYS LAST in a pipeline.
Format-List                                  # Detail view, property per line
Out-GridView                                 # Sortable/filterable GUI grid (Windows PS)
Export-Csv -Path "file.csv" -NoTypeInformation
Export-Clixml -Path "file.xml"               # Preserves object structure; use for ACL backups
Out-File -FilePath "output.txt"
Get-Content "file.txt"
Get-Content "file.txt" -Tail 20 -Wait        # Live tail, like Linux tail -f
```

**⚠ TRAP — `Format-*` destroys objects.** Anything after `Format-Table` in a pipeline receives formatting instructions, not data. `Get-Process | Format-Table | Export-Csv out.csv` produces garbage. Format last, always.

**Timestamp your exports so re-runs don't overwrite:**
```powershell
$Results | Export-Csv -Path "scan_$(Get-Date -Format 'yyyyMMdd_HHmm').csv" -NoTypeInformation
```

### `[PS-04]` Variables, logic, loops

```powershell
$var = "value"
$Ports = @(22, 80, 443, 3389)                       # Array
$Config = @{ Domain = "contoso.com"; Site = "RC" }  # Hashtable

if ($x -eq 1) { "Yes" } else { "No" }
foreach ($item in $collection) { $item }            # Statement — faster on large sets
$collection | ForEach-Object { $_ }                 # Pipeline — streams, lower memory

[PSCustomObject]@{ Name = "x"; Value = 1 }          # Build a clean output object
```

### `[PS-05]` Operators and common parameters

| Operator / Flag | Meaning |
|---|---|
| `-eq` / `-ne` | Equal / not equal |
| `-like` | Wildcard string match — `-like "*Smith*"` |
| `-match` | Regular expression match |
| `-gt` / `-lt` / `-ge` / `-le` | Greater / less than (numeric or date) |
| `-and` / `-or` / `-not` / `!` | Boolean logic |
| `-in` / `-contains` | Membership. `$x -in $array` and `$array -contains $x` are the same test with operands reversed. |
| `*` | Wildcard — valid in `-Filter`, `-like`, `Get-Command` |
| `-Identity` | Targets **one** object by SamAccountName, DN, GUID, or SID |
| `-Filter` | Query that can return **many** objects |
| `-SearchBase` | Scopes an AD query to an OU path |
| `-Properties *` | Return all properties (default returns a small subset) |
| `-WhatIf` | Simulate without changing anything |
| `-Confirm:$false` | Skip the yes/no prompt. Use deliberately. |
| `-ComputerName` | Target a remote machine |
| `-Recurse` | Process subdirectories / child items |
| `-Force` | Override restrictions, hidden attributes, or confirmation |
| `-ErrorAction SilentlyContinue` | Suppress non-terminating errors (see trap below) |
| `-WarningAction SilentlyContinue` | Suppress warning noise — useful with `Test-NetConnection` |

**⚠ TRAP — `-ErrorAction SilentlyContinue` hides the thing you needed to see.** It is correct for existence checks (`Get-ADUser ... -ErrorAction SilentlyContinue` to test whether a user exists). It is wrong as a general habit, because it converts "this failed for a reason" into "this returned nothing." If a script is silently doing less than you expect, this flag is the first suspect.

### `[PS-06]` Execution policy `[PS-EXEC]`

```powershell
Get-ExecutionPolicy -List                                   # See all scopes at once
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass  # This window only; reverts on close
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
Get-ChildItem .\scripts\*.ps1 | Unblock-File                # Clears mark-of-the-web on copied files
```

| Scope | Use when |
|---|---|
| `Process` | Running a script once. **Default choice on a client's server.** Evaporates when the window closes. |
| `CurrentUser` + `RemoteSigned` | Your own admin workstation, persistently. Local scripts run; downloaded ones need a signature. |
| `LocalMachine` | Rarely. This is a change to the client's machine and should be a documented decision, not a side effect of you being in a hurry. |

**🛑 DANGER — never set `Bypass` machine-wide on a client's server.** If a persistent setting is genuinely needed, `RemoteSigned` is the correct one.

### `[PS-07]` Safe-script header template

```powershell
<#
.SYNOPSIS   One line.
.DESCRIPTION What it does and what it assumes.
Purpose:
Author:
Date:
Environment:      Which client / which tier
Risk Level:       Read-only | Modifies config | Destructive
Rollback Plan:
Tested With -WhatIf:  Yes/No
#>
```

### `[PS-08]` Bulk operation safety pattern `[PS-BULK]`

Never run a bulk change straight from a filter. Four steps, always:

```powershell
# 1. QUERY first — build the target list, change nothing
$Targets = Get-ADUser -Filter * -SearchBase "OU=Employees,OU=Contoso,DC=ad,DC=contoso,DC=com"

# 2. REVIEW the list with your own eyes. Count it. Does the count match expectation?
$Targets | Select-Object Name, SamAccountName
$Targets.Count

# 3. DRY RUN with -WhatIf
$Targets | ForEach-Object { Disable-ADAccount -Identity $_.SamAccountName -WhatIf }

# 4. EXECUTE — only after the -WhatIf output was read, not skimmed
```

**WHY:** `-WhatIf` output is worthless if you scroll past it. The step that catches mistakes is step 2, where the count is wrong and you notice.

### `[PS-09]` Splatting — kills the backtick problem permanently

```powershell
# FRAGILE — a single trailing space after a backtick breaks this with a confusing parse error
New-ADUser -Name "John Smith" `
    -GivenName "John" `
    -Surname "Smith"

# ROBUST — no continuation characters at all
$Params = @{
    Name           = "John Smith"
    GivenName      = "John"
    Surname        = "Smith"
    SamAccountName = "jsmith"
    Enabled        = $true
}
New-ADUser @Params
```

**⚠ TRAP — the backtick is a line-continuation character and must be the **last** character on the line.** A single trailing space after it breaks the command. **When a pasted multi-line command fails for no visible reason, collapse it to one line before troubleshooting anything else.** Splatting removes this failure mode entirely and is easier to read.

### `[PS-10]` Idempotence — write scripts that survive a partial run

The most common script failure in the field is not a bug. It is re-running a script after it half-succeeded. Guard every create operation:

```powershell
# Existence check + continue
if (Get-ADUser -Filter "SamAccountName -eq '$Sam'" -ErrorAction SilentlyContinue) {
    Write-Warning "$Sam already exists - skipping"
    continue
}

# Create-or-update instead of create-or-fail
if (Get-SmbShare -Name $Name -ErrorAction SilentlyContinue) {
    Set-SmbShare -Name $Name -FolderEnumerationMode AccessBased -Force
} else {
    New-SmbShare -Name $Name -Path $Path -FullAccess "Authenticated Users" -FolderEnumerationMode AccessBased
}

# Per-item try/catch so one bad row does not abort the other 39
foreach ($U in $Users) {
    try   { New-ADUser @Params }
    catch { Write-Host "FAILED $($U.Sam): $_" -ForegroundColor Red }
}
```

### `[PS-11]` PowerShell 5.1 vs PowerShell 7 — what actually differs in the field

| | Windows PowerShell 5.1 | PowerShell 7 |
|---|---|---|
| Ships with | Every Windows 10/11 and Server install | Separate install (`winget install Microsoft.PowerShell`) |
| Executable | `powershell.exe` | `pwsh.exe` |
| `Get-EventLog` | Available | **Removed.** Use `Get-WinEvent`. |
| `Get-WmiObject` | Available (deprecated) | **Removed.** Use `Get-CimInstance`. |
| `Test-Connection -Traceroute` | Not available | Available |
| `ForEach-Object -Parallel` | No | Yes |
| `?.` null-conditional, ternary `? :` | No | Yes |
| AD / GPO / DHCP RSAT modules | Native | Run through the Windows Compatibility layer — works, occasionally odd |

**Practical rule:** write scripts you will hand to a client in **5.1-compatible syntax**, because 5.1 is on every machine and 7 is not. Use 7 interactively on your own workstation where the better ergonomics pay off.

**🔄 UPDATED — cmdlets to stop typing:**

| Retired / deprecated | Use instead | Why |
|---|---|---|
| `Get-WmiObject` | `Get-CimInstance` | WMI cmdlets deprecated since PS3; absent from PS7 |
| `Get-EventLog` | `Get-WinEvent` | Only reads classic logs; absent from PS7; much slower |
| `wmic.exe` | `Get-CimInstance` | Deprecated by Microsoft; no longer installed by default on current Windows |
| `Get-Package` for installed apps | Registry `Uninstall` key query — see `[WIN-INV]` | `Get-Package` misses most MSI/EXE installs |
| `wmic product get name,version` | Registry query, or `winget list` | `Win32_Product` triggers an MSI **reconfiguration** of every installed product — slow, and it writes event log noise. Genuinely avoid this one. |
| `MSOnline` / `AzureAD` modules | `Microsoft.Graph` | Both retired. Old guides using `Set-MsolDirSyncEnabled`, `Get-MsolUser`, `Get-AzureADUser` will fail. |


---

## 03 — CMD ↔ POWERSHELL EQUIVALENTS `[PS-CMD]`

Both columns work. CMD is often faster to type on someone else's machine; PowerShell returns objects you can filter and export.

| Task | CMD | PowerShell |
|---|---|---|
| Ping a host | `ping hostname` | `Test-Connection -ComputerName hostname -Count 4` |
| Test a specific TCP port | *(none)* | `Test-NetConnection hostname -Port 443` |
| Trace route | `tracert hostname` | `Test-NetConnection hostname -TraceRoute` |
| IP configuration | `ipconfig /all` | `Get-NetIPConfiguration -Detailed` |
| Show IP addresses | `ipconfig` | `Get-NetIPAddress \| Format-Table` |
| Flush DNS cache | `ipconfig /flushdns` | `Clear-DnsClientCache` |
| Show DNS cache | `ipconfig /displaydns` | `Get-DnsClientCache` |
| Re-register in DNS | `ipconfig /registerdns` | `Register-DnsClient` |
| Release / renew DHCP | `ipconfig /release` `/renew` | `Invoke-CimMethod ...` — just use ipconfig |
| Resolve a name | `nslookup hostname` | `Resolve-DnsName hostname` |
| Open ports / connections | `netstat -ano` | `Get-NetTCPConnection \| Select State, LocalPort, RemoteAddress, OwningProcess` |
| Routing table | `route print` | `Get-NetRoute` |
| ARP table | `arp -a` | `Get-NetNeighbor` |
| Restart computer | `shutdown /r /t 0` | `Restart-Computer -Force` |
| Shut down | `shutdown /s /t 0` | `Stop-Computer -Force` |
| List processes | `tasklist` | `Get-Process` |
| Kill a process | `taskkill /PID 1234 /F` | `Stop-Process -Id 1234 -Force` |
| List services | `sc query` / `net start` | `Get-Service` |
| Start / stop / restart service | `net start Spooler` | `Start-Service Spooler` / `Stop-Service` / `Restart-Service` |
| Map network drive | `net use Z: \\server\share` | `New-PSDrive -Name Z -PSProvider FileSystem -Root \\server\share -Persist` |
| Show mapped drives | `net use` | `Get-PSDrive -PSProvider FileSystem` |
| List directory | `dir` | `Get-ChildItem` (aliases `ls`, `dir`, `gci`) |
| Copy a file | `copy src dst` | `Copy-Item -Path src -Destination dst` |
| Copy a tree with retry/resume | `robocopy src dst /E /Z /R:3 /W:5` | *(robocopy is still the right tool — use it)* |
| Delete a file | `del file.txt` | `Remove-Item -Path file.txt` |
| Create a folder | `mkdir Folder` | `New-Item -ItemType Directory -Name "Folder"` |
| Find a file | `dir /s /b *.log` | `Get-ChildItem C:\ -Recurse -Filter "*.log" -ErrorAction SilentlyContinue` |
| Disk space | `wmic logicaldisk get size,freespace` *(deprecated)* | `Get-Volume` or `Get-PSDrive C` |
| System info | `systeminfo` | `Get-ComputerInfo` |
| Windows version | `winver` / `ver` | `(Get-CimInstance Win32_OperatingSystem).Caption` |
| Current user | `whoami` | `whoami` or `$env:USERNAME` |
| Group membership of current token | `whoami /groups` | `whoami /groups` |
| Event logs | `eventvwr` (GUI) | `Get-WinEvent -LogName System -MaxEvents 20` |
| Installed programs | `wmic product get name` **(never — see `[PS-11]`)** | Registry query, `[WIN-INV]` |
| Refresh Group Policy | `gpupdate /force` | `Invoke-GPUpdate -Force` (RSAT) |
| Group Policy result | `gpresult /r` | `Get-GPResultantSetOfPolicy` (RSAT) |
| Cached credentials | `cmdkey /list` | `cmdkey /list` |
| Uptime | `net statistics workstation` | `(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime` |

### `[WIN-INV]` Installed-software inventory that actually works

`Get-Package` and `wmic product` both miss things. This registry query catches 32-bit and 64-bit MSI and most EXE installers:

```powershell
$Paths = @(
  'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
  'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)
Get-ItemProperty $Paths -ErrorAction SilentlyContinue |
    Where-Object DisplayName |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Sort-Object DisplayName
```

Per-user installs also live under `HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*` — add it if you are chasing something a user installed themselves.

Modern alternative when winget is present: `winget list`. Faster, but only sees what winget knows about.

---

## 04 — NETWORK DIAGNOSTICS `[NET]`

> **This section is the commands. Section 22 `[NETF]` is the reasoning.** If a result here does not make sense — a ping fails but the port is open, a host has an address but reaches nothing — go to `[NETF-01]` and work the layers bottom up.

### `[NET-01]` `Test-NetConnection` — the single most useful networking cmdlet on Windows

Built into PowerShell 5.1+ on every modern Windows machine. Tests DNS resolution, ICMP, and a TCP handshake in one call and returns a structured object.

```powershell
Test-NetConnection -ComputerName 10.10.10.10 -Port 445
Test-NetConnection -ComputerName fileserver.ad.contoso.com -Port 445
Test-NetConnection -ComputerName 8.8.8.8 -TraceRoute
Test-NetConnection -ComputerName 10.10.10.10 -InformationLevel Quiet   # returns bare $true/$false
```

| Field | Meaning |
|---|---|
| `TcpTestSucceeded` | **True** = port open and accepting TCP. **False** = closed, filtered, or host unreachable. |
| `PingSucceeded` | ICMP reply. **False does not mean the host is down** — many firewalls block ICMP by policy. |
| `RemoteAddress` | The resolved IP. Check this — it tells you whether DNS gave you what you expected. |
| `NameResolutionSucceeded` | Whether the name resolved at all |
| `SourceAddress` | Which local interface the traffic left from. Useful on multi-homed machines. |

**⚠ Limitation:** one port per call. Loop it (`[NET-02]`) for a small port list.

**⚠ TRAP — ping proves less than you think.** A successful ping tests IP reachability to an address *you supplied by hand*. Domain join uses DNS SRV lookup and Kerberos, and both can fail completely on a network where ping works perfectly. When someone says "but I can ping the server," that is not evidence about authentication.

### `[NET-02]` Multi-port scan loop (no modules required, PS 5.1+)

```powershell
$Target = "10.10.10.10"
$Ports  = @(22, 53, 80, 88, 389, 443, 445, 3389)

$Ports | ForEach-Object {
    $r = Test-NetConnection -ComputerName $Target -Port $_ `
            -WarningAction SilentlyContinue -InformationLevel Quiet
    [PSCustomObject]@{
        Port   = $_
        Status = if ($r) { "OPEN" } else { "CLOSED/FILTERED" }
    }
} | Format-Table -AutoSize
```

Sequential — fine for 5–10 ports, noticeably slow past 50. For larger ranges or whole subnets, use `[NET-03]`.

**Change only `$Target` and `$Ports`.** Everything below those two lines is the engine.

### `[NET-03]` PSnmap — subnet and port-range scanning

Community module that mirrors nmap behavior and returns pipeable objects.

```powershell
Install-Module -Name PSnmap -Scope CurrentUser      # one-time, needs internet; no admin rights needed

Invoke-PSnmap -ComputerName 10.10.10.10 -Port 22,80,443,3389
Invoke-PSnmap -ComputerName 10.10.10.0/24 -Port 80,443
Invoke-PSnmap -ComputerName 10.10.10.0/24 -Port 22,80,443 -Timeout 500   # ms; raise on slow links

Invoke-PSnmap -ComputerName 10.10.10.0/24 -Port 22,80,443 |
    Where-Object { $_.Open -eq $true } |
    Export-Csv -Path "subnet_scan_$(Get-Date -Format 'yyyyMMdd').csv" -NoTypeInformation
```

**🛑 DANGER — get written authorization before scanning a client's network.** A port scan is indistinguishable from reconnaissance on the wire, will trip any competent IDS, and can be a contract or legal problem. Scan your own lab freely; scan a client only with a scope in writing.

### `[NET-04]` Traceroute, three ways

```powershell
# Built in, PS 5.1+ — structured output
Test-NetConnection -ComputerName 8.8.8.8 -TraceRoute

# PS 7+ only — per-hop latency and status
Test-Connection -TargetName 8.8.8.8 -Traceroute
Test-Connection -TargetName 8.8.8.8 -Traceroute -MaxHops 20

# CMD fallback, works anywhere, plain text
tracert 8.8.8.8
tracert -d 8.8.8.8        # skip reverse DNS — much faster
tracert -h 15 8.8.8.8     # hop limit
```

Numbered hop display from the built-in cmdlet:

```powershell
$trace = Test-NetConnection -ComputerName 8.8.8.8 -TraceRoute
Write-Host "Destination : $($trace.RemoteAddress)"
Write-Host "Ping Result : $($trace.PingSucceeded)`n"
$n = 1
$trace.TraceRoute | ForEach-Object { Write-Host ("  Hop {0:D2}  ->  {1}" -f $n, $_); $n++ }
```

**A hop showing `*` is normal.** It means that router did not respond to ICMP TTL-exceeded probes. Many ISP and cloud routers drop these silently. It does not indicate a broken route — subsequent hops usually resolve fine.

### `[NET-05]` DNS troubleshooting

```powershell
Resolve-DnsName ad.contoso.com
Resolve-DnsName ad.contoso.com -Server 10.10.10.10      # bypass the client's configured resolver
Resolve-DnsName -Name _ldap._tcp.dc._msdcs.ad.contoso.com -Type SRV
Resolve-DnsName 10.10.10.10 -Type PTR                    # reverse lookup
Clear-DnsClientCache
Get-DnsClientServerAddress -AddressFamily IPv4           # which DNS servers this NIC is using

nslookup -type=SRV _ldap._tcp.dc._msdcs.ad.contoso.com   # CMD equivalent
```

**Order of DNS suspicion, cheapest first:**
1. Is the client pointed at a domain controller for DNS, or at the router / a public resolver? `ipconfig /all`.
2. Does the domain FQDN resolve to the DC's LAN address — not a public IP, not an IPv6 global?
3. Do the `_ldap._tcp` SRV records resolve? **This is how a DC is located.** An A record alone is not enough.
4. Is there a stale record? Compare `Resolve-DnsName` output against what the server actually holds.

### `[NET-06]` Standard connectivity triage `[NET-TRIAGE]`

Work outward. Stop at the first failure — that is your layer.

```powershell
# 1. Local IP stack
Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.IPAddress -ne "127.0.0.1"}
Get-NetAdapter | Where-Object Status -eq "Up"

# 2. Default gateway reachable
Get-NetRoute | Where-Object {$_.DestinationPrefix -eq "0.0.0.0/0"}
Test-NetConnection -ComputerName <gateway IP>

# 3. Off-LAN reachability, by IP (removes DNS from the equation)
Test-NetConnection -ComputerName 8.8.8.8 -Port 443

# 4. DNS resolution
Resolve-DnsName google.com
Clear-DnsClientCache

# 5. Internal name resolution / DC location
Resolve-DnsName ad.contoso.com
nltest /dsgetdc:ad.contoso.com

# 6. Specific service reachability
Test-NetConnection fileserver -Port 445
```

**Checklist for the ticket:** adapter up → IPv4 address sane (not 169.254.x.x APIPA) → gateway responds → external IP responds → DNS resolves → internal names resolve → target service port open. Escalate when the failure is upstream of the gateway (ISP, firewall, VLAN routing).

**169.254.x.x means DHCP failed.** The machine self-assigned. Check the DHCP scope for exhaustion, the VLAN assignment on the switch port, and whether a DHCP relay is needed.

### `[NET-07]` Combined port scan + traceroute script

```powershell
# ============================================================
# Network Scanner + Traceroute
# EDIT ONLY THESE THREE LINES
# ============================================================
$Target      = "10.10.10.10"                # IP or hostname
$PortsToScan = @(22, 80, 443, 3389, 8080)   # TCP ports
$Timeout     = 1000                          # ms. 500-1000 LAN, 3000-5000 VPN/WAN

# ============================================================
# PART 1: PORT SCAN
# ============================================================
Write-Host "`n=== PORT SCAN: $Target ===" -ForegroundColor Cyan
Write-Host "Scanning ports: $($PortsToScan -join ', ')`n"

$ScanResults = $PortsToScan | ForEach-Object {
    $port = $_
    try {
        $result = Test-NetConnection -ComputerName $Target -Port $port `
                    -WarningAction SilentlyContinue -InformationLevel Quiet
        [PSCustomObject]@{ Port = $port; Status = if ($result) { "OPEN" } else { "CLOSED/FILTERED" } }
    } catch {
        [PSCustomObject]@{ Port = $port; Status = "ERROR" }
    }
}
$ScanResults | Format-Table -AutoSize

# ============================================================
# PART 2: TRACEROUTE
# A '*' hop means that router ignored the probe. Not a broken route.
# ============================================================
Write-Host "`n=== TRACEROUTE: $Target ===" -ForegroundColor Cyan
try {
    $TraceResult = Test-NetConnection -ComputerName $Target -TraceRoute -WarningAction SilentlyContinue
    Write-Host "`nDestination : $($TraceResult.RemoteAddress)"
    Write-Host "Ping Success: $($TraceResult.PingSucceeded)`n"
    $HopNumber = 1
    foreach ($Hop in $TraceResult.TraceRoute) {
        Write-Host ("  Hop {0:D2}  ->  {1}" -f $HopNumber, $Hop); $HopNumber++
    }
} catch {
    Write-Host "Traceroute failed: $_" -ForegroundColor Red
}
Write-Host "`n=== Scan Complete ===" -ForegroundColor Green
```

### `[NET-08]` Port reference — infrastructure

| Port | Proto | Service | Needed for |
|---|---|---|---|
| **53** | TCP/UDP | DNS | Everything. Check this first, always. |
| **88** | TCP/UDP | Kerberos | Authentication |
| **123** | UDP | NTP | Time sync — and therefore Kerberos |
| **135** | TCP | RPC endpoint mapper | AD replication, remote management, WMI |
| **137–139** | TCP/UDP | NetBIOS | Legacy name resolution / file sharing |
| **389** | TCP/UDP | LDAP | Directory queries |
| **445** | TCP | SMB | File shares, **and Group Policy delivery from SYSVOL** |
| **464** | TCP/UDP | Kerberos password change | Password resets |
| **636** | TCP | LDAPS | Secure directory queries |
| **3268 / 3269** | TCP | Global Catalog / GC over SSL | Forest-wide lookups |
| **3389** | TCP | RDP | Remote Desktop. **Never open to the internet.** |
| **5985 / 5986** | TCP | WinRM HTTP / HTTPS | PowerShell remoting |
| **9389** | TCP | AD Web Services | The `ActiveDirectory` PowerShell module needs this |
| **49152–65535** | TCP | Dynamic RPC | AD replication. **The range firewalls block by accident.** |
| **67 / 68** | UDP | DHCP server / client | Address assignment |
| **1645/1646, 1812/1813** | UDP | RADIUS | 802.1X, VPN auth |

### `[NET-09]` Port reference — services and homelab

| Port | Proto | Service | Typical use |
|---|---|---|---|
| 20/21 | TCP | FTP | Legacy transfer |
| 22 | TCP | SSH / SFTP | Linux hosts, routers, NAS, network gear |
| 23 | TCP | Telnet | Legacy only — insecure, flag if found |
| 25 | TCP | SMTP | Mail relay |
| 80 | TCP | HTTP | Web, router admin pages, dashboards |
| 110 / 995 | TCP | POP3 / POP3S | Legacy mail retrieval |
| 143 / 993 | TCP | IMAP / IMAPS | Mail retrieval |
| 443 | TCP | HTTPS | Secure web, reverse proxies, **most modern APIs** |
| 587 | TCP | SMTP submission | Authenticated mail sending |
| 1194 | UDP | OpenVPN | VPN endpoint |
| 1433 | TCP | MS SQL Server | Database |
| 3000 | TCP | Grafana / Node apps | Dashboards, dev servers |
| 3306 | TCP | MySQL / MariaDB | Database |
| 5432 | TCP | PostgreSQL | Database |
| 5900 | TCP | VNC | Remote desktop on Linux |
| 8006 | TCP | Proxmox VE | Hypervisor web UI |
| 8080 | TCP | HTTP alternate | Dev servers, proxies |
| 8443 | TCP | HTTPS alternate | UniFi Controller, appliance UIs |
| 9000 | TCP | Portainer | Docker management UI |
| 9090 | TCP | Cockpit | Linux server admin web UI |
| 32400 | TCP | Plex | Media server |
| 51820 | UDP | WireGuard | VPN tunnel |

**Starter `$PortsToScan` arrays by target type:**

| Target | Array |
|---|---|
| Domain controller | `@(53, 88, 135, 389, 445, 464, 636, 3268, 9389)` |
| Windows member server / VM | `@(80, 443, 445, 3389, 5985)` |
| Linux server / NAS | `@(22, 80, 443, 445, 9090)` |
| Router / firewall | `@(22, 53, 80, 443, 1194, 51820)` |
| Container / Docker host | `@(22, 80, 443, 3000, 8080, 8443, 9000)` |

### `[NET-10]` DHCP option reference — the two that matter for AD

Configured on whatever serves DHCP, whether that is Windows Server, a firewall, or a router.

| Purpose | Option | Value |
|---|---|---|
| **DNS server** | **6** | The domain controller IPs, **in order, both of them** — e.g. `10.10.10.10, 10.10.10.11` |
| **Domain search suffix** | **15** | The AD DNS domain — e.g. `ad.contoso.com` |
| Router / gateway | 3 | Only touch if the router is not already handing out the right gateway |
| NTP servers | 42 | Rarely needed on a Windows domain — domain members get time from the PDC emulator hierarchy |

**Options to leave alone unless you specifically need them:**
- **60 / 66 / 67** — PXE boot. Setting these without a PXE server breaks nothing, but setting them wrong will hang machines at boot.
- **44 / 45** — WINS. Unnecessary in any modern environment.

**⚠ TRAP — the hidden second field.** Many firewall and router appliances have a separate **"Domain Name"** or **"Search Domain"** field alongside the numbered DHCP options, and ship with it defaulted to `lan` or `local`. If that field disagrees with option 15, clients get an inconsistent suffix and short-name resolution behaves unpredictably. **Set both to the AD domain.**

**🛑 NEVER set client DNS statically.** This is the single decision that silently destroys domain controller redundancy — see `[AD-FAILOVER]`. Option 6 is the correct delivery mechanism: it scales, it survives an IP change, and it is what makes a second DC mean something.

### `[NET-11]` DHCP relay / IP helper

If you want a Windows Server to serve DHCP for a VLAN it does not sit on:

1. Disable DHCP on the router for that VLAN.
2. Configure a **DHCP relay** (also called **IP helper**) on the router's VLAN interface, pointing at the Windows DHCP server's IP.

**WHY:** DHCP DISCOVER is a broadcast, and broadcasts do not cross a router. The relay agent forwards them as unicast to the server you name. Prefer Windows DHCP when a server exists — it integrates with DNS registration and is centrally auditable, which a firewall's DHCP is not.


---

## 05 — ACTIVE DIRECTORY OPERATIONS `[AD]`

### `[AD-00]` Load the module and confirm you can reach a DC

```powershell
Import-Module ActiveDirectory
Get-ADDomain                         # Fails fast if you can't reach a DC or lack rights
Get-Command -Module ActiveDirectory  # ~150 cmdlets
```

If `Import-Module ActiveDirectory` fails on a workstation, RSAT is not installed — see `[AD-RSAT]`. If it fails on a server, add the feature: `Install-WindowsFeature RSAT-AD-PowerShell`.

The module talks to **AD Web Services on TCP 9389**, not LDAP directly. If cmdlets fail while `nslookup` and `ping` work, check 9389 and that the ADWS service is running on the DC.

### `[AD-RSAT]` Build a management workstation — stop administering from the DC

```powershell
# On a Windows 10/11 admin workstation, elevated
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.DHCP.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.FileServices.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.CertificateServices.Tools~~~~0.0.1.0

# See everything available and its state
Get-WindowsCapability -Online -Name "Rsat*" | Select-Object Name, State
```

**WHY this matters more than it looks:** every browser session, every downloaded installer, and every logged-in admin token on a domain controller is a security exposure on the most sensitive machine in the environment. It is also operationally fragile — when DC01 goes offline, the management console you were using goes with it. A management workstation costs nothing and removes both problems.

### `[AD-01]` User lookup

```powershell
Get-ADUser -Identity "jdoe"
Get-ADUser -Identity "jdoe" -Properties *                       # everything
Get-ADUser -Identity "jdoe" -Properties LastLogonDate, PasswordLastSet, PasswordExpired, LockedOut, MemberOf
Get-ADUser -Filter "Name -like '*Smith*'" -Properties Department
Get-ADUser -Filter * -SearchBase "OU=Staff,DC=ad,DC=contoso,DC=com" |
    Select-Object Name, SamAccountName, Enabled
Get-ADUser -Filter "EmailAddress -eq 'jdoe@contoso.com'"
```

**⚠ TRAP — `-Properties *` is not free.** It pulls every attribute for every matched object. Fine for one user, punishing on a directory-wide query. Name the properties you need.

**⚠ TRAP — `-Filter` quoting.** Prefer double-quoted strings with single quotes inside: `-Filter "Name -eq 'jdoe'"`. The `{scriptblock}` form (`-Filter {Name -eq $x}`) works but silently mishandles variables in some contexts. The string form is more predictable.

### `[AD-02]` User account actions

```powershell
Enable-ADAccount  -Identity "jdoe"
Disable-ADAccount -Identity "jdoe"
Unlock-ADAccount  -Identity "jdoe"

Set-ADAccountPassword -Identity "jdoe" -Reset -NewPassword (Read-Host -AsSecureString)
Set-ADUser -Identity "jdoe" -ChangePasswordAtLogon $true

Set-ADUser -Identity "jdoe" -Title "IT Technician" -Department "IT" -Manager "asmith"
Set-ADUser -Identity "jdoe" -UserPrincipalName "jdoe@contoso.com"
Set-ADUser -Identity "jdoe" -Clear Manager                       # remove a value
Set-ADUser -Identity "jdoe" -Replace @{extensionAttribute1="X"}  # arbitrary attribute

Move-ADObject -Identity "CN=John Doe,OU=Employees,..." -TargetPath "OU=Disabled,OU=Contoso,..."
```

### `[AD-03]` Group management

```powershell
Get-ADGroup -Identity "HelpDesk" -Properties Description, Members
Get-ADGroupMember -Identity "HelpDesk" | Select-Object Name, objectClass
Get-ADGroupMember -Identity "HelpDesk" -Recursive                    # flattens nested groups
Get-ADPrincipalGroupMembership -Identity "jdoe" | Select-Object Name # every group a user is in

Add-ADGroupMember    -Identity "HelpDesk" -Members "jdoe","asmith"
Remove-ADGroupMember -Identity "HelpDesk" -Members "jdoe" -Confirm:$false

New-ADGroup -Name "GG-Sales" -GroupScope Global -GroupCategory Security -Path "OU=Groups,..."
```

**⚠ Group membership does not take effect until a new logon token is issued.** Adding someone to a group and having them "refresh" changes nothing — the token was built at logon. **A full log off and log back on is required**; locking and unlocking the screen is not a logoff. Verify with `whoami /groups` on the client.

### `[AD-04]` Computer objects and OUs

```powershell
Get-ADComputer -Identity "PC001" -Properties *
Get-ADComputer -Filter * -SearchBase "OU=Workstations,..." |
    Select-Object Name, DNSHostName, OperatingSystem, LastLogonDate

Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
New-ADOrganizationalUnit -Name "Sales" -Path "OU=Contoso,DC=ad,DC=contoso,DC=com" `
    -ProtectedFromAccidentalDeletion $true
```

### `[AD-05]` Account discovery and hygiene

```powershell
Search-ADAccount -LockedOut               | Select-Object Name, SamAccountName, LastLogonDate
Search-ADAccount -AccountDisabled -UsersOnly | Select-Object Name, DistinguishedName
Search-ADAccount -AccountExpired
Search-ADAccount -PasswordExpired -UsersOnly
Search-ADAccount -PasswordNeverExpires -UsersOnly | Select-Object Name   # audit finding
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly     | Select-Object Name, LastLogonDate
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -ComputersOnly | Select-Object Name
```

**⚠ `LastLogonDate` is approximate.** It derives from `lastLogonTimestamp`, which replicates lazily — by default within a 9–14 day window. It is correct for "has this account been used in the last 90 days" and wrong for "did they log in this morning." For precise data you must query `lastLogon` on every DC and take the highest value, or read Security event 4624.

### `[AD-06]` Health and infrastructure checks `[AD-HEALTH]`

```powershell
# Directory health — run after any change and during every maintenance window
dcdiag /v
dcdiag /test:dns
dcdiag /test:replications

# Replication
repadmin /replsummary            # any error here is urgent
repadmin /showrepl
repadmin /showrepl * /csv > repl.csv
repadmin /syncall /AdeP          # force replication from this DC to all partners

# Roles and topology
netdom query fsmo
Get-ADDomainController -Filter * | Format-Table Name, HostName, IPv4Address, Site, IsGlobalCatalog, OperatingSystem
Get-ADForest  | Format-List Name, ForestMode, DomainNamingMaster, SchemaMaster, GlobalCatalogs
Get-ADDomain  | Format-List Name, DNSRoot, NetBIOSName, DomainMode, PDCEmulator, RIDMaster, InfrastructureMaster

# Time — a Kerberos dependency
w32tm /query /status
w32tm /query /source        # must NOT be "Local CMOS Clock" on the PDC emulator
w32tm /monitor              # offset across every DC in the domain

# Licensing / evaluation expiry
slmgr /dlv
```

### `[AD-07]` Time configuration — a foundation item, not an afterthought `[AD-TIME]`

> **Why 5 minutes and not some other number:** Kerberos authenticates using an encrypted timestamp, so skew beyond the tolerance is rejected as a possible replay attack. The full ticket exchange is at `[SECF-10]`. Clock skew is also what silently destroys log correlation — `[SECF-17]`.

**Kerberos rejects tickets with more than five minutes of clock skew.** Every domain member slaves its clock to the PDC emulator. If the PDC drifts, every authentication in the environment fails at once — and it presents to users as "everything is broken," not as a clock problem.

**On the PDC emulator (the first DC by default) — anchor to an external source:**
```powershell
w32tm /config /manualpeerlist:"time.windows.com,0x9 pool.ntp.org,0x9" /syncfromflags:manual /reliable:yes /update
Restart-Service w32time
w32tm /resync
w32tm /query /status
```

**On every other DC and every member server — follow the domain hierarchy:**
```powershell
w32tm /config /syncfromflags:domhier /update
Restart-Service w32time
w32tm /resync
w32tm /query /source
```

**🛑 On a virtualized domain controller, disable host time synchronization.** A VM pulling time from the Hyper-V Time Synchronization integration service believes it is an authoritative stratum-1 source, while Active Directory expects it to take time from the hierarchy rooted at the PDC emulator. The result is a competing time hierarchy and intermittent, hard-to-diagnose Kerberos failures.

```powershell
# On the Hyper-V host
Get-VMIntegrationService -VMName "DC02" -Name "Time Synchronization" | Disable-VMIntegrationService

# On the DC after promotion
w32tm /config /syncfromflags:domhier /update
Restart-Service w32time
w32tm /query /source     # must NOT say "VM IC Time Synchronization Provider"
```

**Check skew between a client and a DC in five seconds:**
```powershell
w32tm /stripchart /computer:10.10.10.10 /samples:3 /dataonly
```

**⚠ Time zone is a Kerberos dependency.** A laptop imaged in one time zone and deployed in another has a one-hour offset. Kerberos tolerates five minutes. The domain join fails with *"An Active Directory Domain Controller could not be contacted"* — which says nothing about clocks. **Set the time zone before attempting any join.**

### `[AD-08]` The AGDLP group model `[AD-AGDLP]`

**A**ccounts into **G**lobal groups, Global groups into **D**omain **L**ocal groups, **P**ermissions onto the Domain Local group.

| Tier | Scope | Naming | Answers the question |
|---|---|---|---|
| Role group | Global | `GG-<Name>` — `GG-Sales` | **Who is this person?** |
| Resource group | Domain Local | `DL-<Resource>-<Access>` — `DL-Sales-Modify` | **What access does this grant?** |

```powershell
$OU = "OU=Groups,OU=Contoso,DC=ad,DC=contoso,DC=com"

# Tier 1 — role groups (WHO SOMEONE IS)
"GG-Sales","GG-Accounting","GG-IT","GG-AllEmployees" | ForEach-Object {
    New-ADGroup -Name $_ -GroupScope Global -GroupCategory Security -Path $OU
}
Add-ADGroupMember -Identity "GG-AllEmployees" -Members "GG-Sales","GG-Accounting","GG-IT"

# Tier 2 — resource groups (WHAT ACCESS IS GRANTED)
"DL-Company-Modify","DL-Sales-Modify","DL-Sales-Read","DL-Accounting-Modify","DL-IT-Modify" |
  ForEach-Object {
    New-ADGroup -Name $_ -GroupScope DomainLocal -GroupCategory Security -Path $OU
}

# Nest role into resource
Add-ADGroupMember -Identity "DL-Company-Modify"    -Members "GG-AllEmployees"
Add-ADGroupMember -Identity "DL-Sales-Modify"      -Members "GG-Sales"
Add-ADGroupMember -Identity "DL-Accounting-Modify" -Members "GG-Accounting"
Add-ADGroupMember -Identity "DL-IT-Modify"         -Members "GG-IT"
```

**WHY two tiers when one works?** In a single domain you can put a Global group directly on an ACL and it functions. The separation buys you this: when someone asks *why can Sales write to this folder*, the answer is one entry on that folder's ACL. When auditors need read access for a month, you add them to `DL-Sales-Read` and remove them later — you never touch the folder again. **Changing group membership is instant and reversible. Re-permissioning a folder tree is neither.**

**🛑 NEVER assign permissions to an individual user account.** Not once, not temporarily. Direct user entries on an ACL are invisible to any group-based audit, and they are why departed employees keep access to things nobody can explain.

### `[AD-09]` UPN suffix management `[AD-UPN]`

```powershell
# Add the routable suffix first (GUI: AD Domains and Trusts > right-click top node > Properties > UPN Suffixes)
# Then rewrite existing users:
Get-ADUser -Filter * -SearchBase "OU=Employees,OU=Contoso,DC=ad,DC=contoso,DC=com" |
    ForEach-Object { Set-ADUser $_ -UserPrincipalName "$($_.SamAccountName)@contoso.com" }

# Single user
Set-ADUser -Identity jsmith -UserPrincipalName "jsmith@contoso.com"

# Verify before and after
Get-ADUser -Filter * -SearchBase "OU=Employees,..." -Properties UserPrincipalName |
    Select-Object SamAccountName, UserPrincipalName | Sort-Object SamAccountName
```

**WHY this exists:** the UPN suffix must be a domain the organization actually owns and has verified in Entra ID, because it becomes the cloud sign-in name. A `.local` internal domain can never be verified, so every account has to be rewritten before hybrid identity will work. **Set the suffix in Phase 9 before creating any users** and this step disappears permanently — see `[AD-BUILD]`.

### `[AD-10]` Bulk user creation with unique passwords

```powershell
Import-Module ActiveDirectory
$OU        = "OU=Employees,OU=Contoso,DC=ad,DC=contoso,DC=com"
$UPNSuffix = "contoso.com"
$HomeShare = "\\SITE-DC01\Home"

function New-StrongPassword {
    # Ambiguous characters (0/O, 1/l/I) deliberately omitted — they generate support calls
    $chars = 'abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@#$%'
    -join ((1..16) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}

$Users = @(
    @{Sam="jsmith";   First="John";  Last="Smith";   Dept="Sales";      Group="GG-Sales"},
    @{Sam="sjohnson"; First="Sarah"; Last="Johnson"; Dept="Accounting"; Group="GG-Accounting"},
    @{Sam="mtorres";  First="Mike";  Last="Torres";  Dept="IT";         Group="GG-IT"}
)

$Report = foreach ($U in $Users) {
    if (Get-ADUser -Filter "SamAccountName -eq '$($U.Sam)'" -ErrorAction SilentlyContinue) {
        Write-Warning "$($U.Sam) already exists - skipping"; continue
    }
    $Password = New-StrongPassword
    try {
        $Params = @{
            Name                  = "$($U.First) $($U.Last)"
            GivenName             = $U.First
            Surname               = $U.Last
            SamAccountName        = $U.Sam
            UserPrincipalName     = "$($U.Sam)@$UPNSuffix"
            DisplayName           = "$($U.First) $($U.Last)"
            Department            = $U.Dept
            Path                  = $OU
            AccountPassword       = (ConvertTo-SecureString $Password -AsPlainText -Force)
            Enabled               = $true
            ChangePasswordAtLogon = $true
            HomeDrive             = "H:"
            HomeDirectory         = "$HomeShare\$($U.Sam)"
        }
        New-ADUser @Params
        Add-ADGroupMember -Identity $U.Group -Members $U.Sam
        Write-Host "Created $($U.Sam)" -ForegroundColor Green
        [PSCustomObject]@{ User=$U.Sam; UPN="$($U.Sam)@$UPNSuffix"; Password=$Password }
    }
    catch { Write-Host "FAILED $($U.Sam): $_" -ForegroundColor Red }
}

$Report | Export-Csv "C:\Temp\NewUsers.csv" -NoTypeInformation
Write-Host "`nCredentials at C:\Temp\NewUsers.csv - deliver securely, then DELETE." -ForegroundColor Yellow
```

**🛑 Unique passwords, never a shared default.** Generating one per account and forcing a change at first logon is barely more work, and a shared default is a finding in every security review ever written. Build the habit where it costs nothing.

**🛑 The credential CSV is a live secret.** Deliver by a channel separate from the usernames, then delete the file. Do not leave it in `C:\Temp` on a client's server.

### `[AD-11]` FSMO roles — what they are and what breaks

| Role | Scope | If the holder is offline |
|---|---|---|
| **Schema Master** | Forest | Cannot extend the schema. Nothing else affected. |
| **Domain Naming Master** | Forest | Cannot add or remove domains. Nothing else affected. |
| **PDC Emulator** | Domain | **Highest impact.** Authoritative time source, password-change target, account-lockout processing, GPO editing default. Fix or seize this one first. |
| **RID Master** | Domain | DCs eventually run out of RID pool and cannot create new objects. Slow-burn failure. |
| **Infrastructure Master** | Domain | Cross-domain group membership references go stale. Irrelevant in a single-domain forest where all DCs are GCs. |

```powershell
netdom query fsmo

# Graceful transfer (current holder is online and healthy)
Move-ADDirectoryServerOperationMasterRole -Identity "SITE-DC02" `
    -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster

# Seizure (holder is permanently gone) — see SOP-07 before running this
Move-ADDirectoryServerOperationMasterRole -Identity "SITE-DC02" `
    -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster -Force
```

**🛑 `-Force` performs a seizure and it is one-way.** The old holder must never be brought back online afterward. If the DC is recoverable, repair it and let replication converge instead.

### `[AD-12]` AD Recycle Bin

```powershell
Enable-ADOptionalFeature 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target 'ad.contoso.com'
Get-ADOptionalFeature -Filter 'name -like "Recycle Bin Feature"'

# Restore a deleted user
Get-ADObject -Filter 'isDeleted -eq $true -and Name -like "*Smith*"' -IncludeDeletedObjects
Get-ADObject -Filter 'SamAccountName -eq "jsmith"' -IncludeDeletedObjects | Restore-ADObject
```

**🛑 Enable it before you need it.** The Recycle Bin only protects objects deleted **after** it is enabled, and it cannot be turned off once on. It converts "restore the whole directory from backup" into a two-minute undelete. There is no reason not to enable it on day one, and almost every environment you inherit will not have it.

### `[AD-13]` System State backup

```powershell
Install-WindowsFeature Windows-Server-Backup

# One-off
wbadmin start systemstatebackup -backupTarget:E: -quiet

# Scheduled nightly
$Policy = New-WBPolicy
Add-WBSystemState -Policy $Policy
$Target = New-WBBackupTarget -VolumePath "E:"
Add-WBBackupTarget -Policy $Policy -Target $Target
Set-WBSchedule -Policy $Policy -Schedule 22:00
Set-WBPolicy -Policy $Policy -Force

Get-WBSummary        # verify
```

**Then test a restore, and write down the date you tested it.** See `[DOCTRINE-07]`.

### `[AD-14]` Windows LAPS `[SEC-LAPS]`

> **The reason LAPS exists in one line:** the SAM stores password *hashes*, and a hash from one machine authenticates to every other machine sharing that local password — no cracking required. See `[SYSF-05]`.

```powershell
# One-time forest schema extension — run as a Schema Admin
Update-LapsADSchema -Verbose

# Allow computers in an OU to write their own password
Set-LapsADComputerSelfPermission -Identity "OU=Workstations,OU=Contoso,DC=ad,DC=contoso,DC=com"

# Who can READ the passwords for that OU?
Find-LapsADExtendedRights -Identity "OU=Workstations,OU=Contoso,DC=ad,DC=contoso,DC=com"

# Retrieve a password — THIS is the step that proves the pipeline works
Get-LapsADPassword -Identity "WS-SALES01" -AsPlainText

# Force an immediate rotation (e.g. after a technician used the password)
Reset-LapsPassword

# Force a policy processing cycle on the client
Invoke-LapsPolicyProcessing

# Collect diagnostics when it isn't working
Get-LapsDiagnostics
```

**GPO settings** — `Computer Configuration > Policies > Administrative Templates > System > LAPS`:
- Configure password backup directory = **Active Directory** (or **Microsoft Entra ID** for cloud-only devices)
- Password Settings = all four character sets, length 14+, age 30 days
- Enable password encryption = **Enabled** (requires Windows Server 2016 domain functional level or higher)

**🛑 LAPS is not optional.** Without it, every workstation shares one local administrator password. One compromised machine hands an attacker local administrator on every machine in the environment — this is the standard lateral movement path in ransomware incidents. Windows LAPS is built into current Windows at no cost. **Its absence is a finding on any security assessment.**

**Deploying it is half the job. Retrieving an actual password is the other half.** A LAPS GPO that was never verified end to end is a LAPS deployment you cannot rely on during an incident.

### `[AD-15]` Account lockout triage — the source matters more than the unlock `[AD-LOCKOUT]`

> **Before tightening the lockout threshold, read `[SECF-02]`.** A low threshold does little against password spraying and turns it into a denial-of-service against your own users. MFA is the control; lockout is not.

```powershell
# 1. Confirm the lockout
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LastLogonDate

# 2. Find WHERE the bad attempts came from — run on the PDC emulator
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4740} -MaxEvents 20 |
    Format-List TimeCreated, Message

# Bad password attempts (4771 Kerberos pre-auth failed / 4625 logon failure)
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4771; StartTime=(Get-Date).AddHours(-2)} |
    Select-Object TimeCreated, @{n='User';e={$_.Properties[0].Value}}, @{n='Client';e={$_.Properties[6].Value}}

# 3. Unlock only after finding the source
Unlock-ADAccount -Identity "jdoe"

# 4. Clear stale credentials on the offending device
cmdkey /list
cmdkey /delete:<target-name>
```

**Event 4740 names the calling computer. That is your actual culprit.**

**Real causes, in order of frequency:**
1. A phone or tablet with a stale saved Wi-Fi / Exchange / VPN password
2. A mapped drive reconnecting with cached credentials
3. A scheduled task or Windows service running as the user
4. A stale RDP or console session on another machine
5. Credential Manager entries
6. An actual forgotten password — least common

**Unlocking without finding the source means it locks again in minutes and you have taught the user that IT does not fix things.**


---

## 06 — GREENFIELD BUILD ORDER `[AD-BUILD]`

The order below is deliberate. Every phase assumes the previous one is complete **and verified**. Follow it top to bottom and you will not have to redo anything.

**Estimated time on a competent second pass:** Phases 0–9 in one working day, 10–14 in a second. The first time takes three times that, and that is normal.

| Phase | What | Why it is here and not later |
|---|---|---|
| 0 | Design decisions | Naming and addressing are expensive to change afterward |
| 1 | Server base build | Rename and set IP before promotion; both are painful after |
| 2 | Promote first DC, DNS, time | Time and DNS underpin every authentication that follows |
| 3 | Backup and AD Recycle Bin | Before there is anything to lose. The Recycle Bin must be on **before** a deletion. |
| 4 | DHCP and DNS delivery | Clients need correct DNS before they can join anything |
| 5 | OU structure + container redirection | Must exist before any object is created |
| 6 | Groups | Permissions and policy filtering both depend on them |
| 7 | File services | Shares must be permissioned before drive maps reference them |
| 8 | Group Policy | Built and tested before real users exist |
| 9 | Cloud identity and UPN suffix | Before creating users — otherwise every UPN gets rewritten |
| 10 | Create users | Now every account is correct at birth |
| 11 | Client build and join | The first user logs into a finished environment |
| 12 | Intune policy and apps | Devices are already enrolled by the Phase 8 GPO |
| 13 | Second DC and real redundancy | Once the single-DC build is proven correct |
| 14 | Operations and handover | The part that keeps the client |

---

### PHASE 0 — Design decisions `[BUILD-P0]`

Do this on paper before touching hardware.

#### 0.1 Domain name

| Client owns | Use | Never use |
|---|---|---|
| `contoso.com` | `ad.contoso.com` or `corp.contoso.com` | `contoso.local` |
| Nothing yet | Register a domain first — roughly $12/year | `contoso.local` |

**🛑 WHY `.local` is a permanent tax:**
- Reserved by **RFC 6762 for multicast DNS**. It is not a real top-level domain, cannot be registered, and **can never be verified in Entra ID**.
- Public certificate authorities will not issue certificates for it.
- It collides with Bonjour/Avahi service discovery on macOS, iOS, printers, and Linux.
- It forces split-brain DNS workarounds later.
- Microsoft has advised against it since the Server 2008 era.

**You will inherit this.** A large share of SMB domains in the field are `.local`. Renaming an AD domain is technically possible (`rendom`) but disruptive enough that **the standard answer is to live with it and add a routable UPN suffix** (`[AD-UPN]`). Know the workaround, know why it is needed, and never create a new one.

#### 0.2 Naming conventions

| Object type | Pattern | Example |
|---|---|---|
| Domain controller | `<SITE>-DC##` | `RC-DC01` |
| Member server | `<SITE>-<ROLE>##` | `RC-FILE01`, `RC-SYNC01` |
| Workstation | `WS-<DEPT>##` | `WS-SALES01` |
| Role group (Global) | `GG-<Name>` | `GG-Sales` |
| Resource group (Domain Local) | `DL-<Resource>-<Access>` | `DL-Sales-Modify` |
| Service account | `svc-<purpose>` | `svc-backup` |
| GPO | `<Scope> - <Purpose>` | `Workstations - Baseline Security` |
| Entra dynamic group | `DYN-<Scope>` | `DYN-Windows-Corporate` |
| Licensing group | `LIC-<SKU>` | `LIC-M365-BusinessPremium` |

#### 0.3 Addressing plan

Write down and keep: server subnet and VLAN · static range reserved for infrastructure (typically `.1`–`.50`) · DHCP scope range · gateway · DNS servers to hand out · planned IP of every server.

#### 0.4 Cloud tenant

Create the tenant **during design**, not during Phase 9. Tenant names are globally unique and first-come. The name you want may already be taken, and you want to discover that before anything is built around it.

#### 0.5 Licensing prerequisites

| Requirement | What it needs |
|---|---|
| Intune device management | Business Premium, E3, E5, or standalone Intune |
| Group-based licensing | Entra ID P1 (included in Business Premium and E3) |
| Conditional Access | Entra ID P1 |
| Azure Arc, Log Analytics, Azure Backup | **A real Azure subscription. A Microsoft 365 subscription is not one.** |
| Windows Server in production | A licensed edition. Evaluation expires at 180 days. |

**🛑 You cannot convert an evaluation Windows Server to licensed while it holds the AD DS role.** Microsoft blocks in-place conversion on a domain controller. To convert you must demote, convert, then re-promote. Check remaining time with `slmgr /dlv` and plan before the timer runs out.

#### 0.6 Public DNS and mail — decide before you build

The client's public DNS is a design input, not a Phase 9 detail. Establish three things on paper:

| Question | Why it must be answered now |
|---|---|
| **Who is the registrar, and who hosts the zone?** | They are frequently different companies. "Change the DNS" has two possible locations and one of them does nothing — `[DNS-MAIL-03]` |
| **Is DNSSEC enabled?** | **Microsoft 365 DNS hosting does not support it.** This decides whether you can delegate the zone to Microsoft at all, and removing DNSSEC has a mandatory ordered procedure with a multi-hour tail — `[DNS-MAIL-04]` |
| **Every system that sends mail as the domain** | Copiers, accounting packages, CRMs, website forms, monitoring. This list is the prerequisite for SPF and DMARC and **the client will not be able to produce it from memory** — `[DNS-MAIL-06]` |

**🛑 Check for DNSSEC before choosing a DNS hosting model, not after starting the migration.** Discovering it mid-cutover costs a day and a mail outage.

#### 0.7 Credential handling

Create the vault entry **before** creating the first password. It must contain:
- Local administrator password
- **DSRM password** — needed exactly once, during directory recovery, and reliably the one nobody wrote down
- Domain administrator account
- A dedicated **break-glass** account
- Tenant global administrator

**WHY break-glass:** so a Conditional Access misconfiguration cannot lock every administrator out of the tenant at once. Make it cloud-only on `.onmicrosoft.com`, exclude it from all CA policies, secure it with a hardware key, and alert on its use. It should be sterile: no mailbox, no daily use, no licensed services beyond what sign-in requires.

---

### PHASE 1 — Server base build `[BUILD-P1]`

Steps 5 and 6 are painful to reverse after promotion.

1. Install Windows Server, Standard edition, **Desktop Experience**.
2. Set a strong local Administrator password. **Record it in the vault immediately.**
3. Patch fully. Reboot. Patch again until no updates remain.
4. **Set the correct time zone.**
5. **Rename the server to its final hostname.** Reboot.
6. **Set the static IP:** address, mask, gateway per 0.3. Preferred DNS = the server's own static IP; Alternate DNS = `127.0.0.1`.
7. Configure storage: OS on one volume, data on a separate volume.
8. Install vendor drivers and update firmware.

**WHY rename before promotion:** renaming a member server is a reboot. Renaming a domain controller requires `netdom computername` plus service principal name cleanup and carries real risk. Two minutes of forethought avoids an hour of repair.

**✅ VERIFY**
```powershell
Get-ComputerInfo | Select-Object CsName, OsName, WindowsVersion, TimeZone
Get-NetIPConfiguration
Get-Volume
```

---

### PHASE 2 — First domain controller, DNS, time `[BUILD-P2]`

#### 2.1 Promotion

1. Server Manager → Add Roles and Features → **Active Directory Domain Services**. DNS installs with it.
2. Click the notification flag → **Promote this server to a domain controller**.
3. **Add a new forest**, root domain name from 0.1.
4. Forest and domain functional level: **highest available**.
5. Check **DNS server** and **Global Catalog**.
6. Set the **DSRM password**. Record it in the vault now.
7. The DNS delegation warning is expected for a new forest. Continue.
8. Reboot.

PowerShell equivalent:
```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "ad.contoso.com" -DomainNetbiosName "CONTOSO" `
    -InstallDns -DomainMode WinThreshold -ForestMode WinThreshold `
    -SafeModeAdministratorPassword (Read-Host -AsSecureString -Prompt "DSRM password")
```

#### 2.2 DNS hygiene — immediately after reboot

1. **Forwarders.** DNS Manager → server Properties → Forwarders. Add upstream resolvers (`1.1.1.1`, `8.8.8.8`) or the client's filtering service.
   ```powershell
   Add-DnsServerForwarder -IPAddress 1.1.1.1, 8.8.8.8
   Get-DnsServerForwarder
   ```
2. **Reverse lookup zone** for the server subnet. Two minutes, and it is what makes `nslookup <ip>` work when you are troubleshooting under pressure.
   ```powershell
   Add-DnsServerPrimaryZone -NetworkID "10.10.10.0/24" -ReplicationScope Domain
   ```
3. **Scavenging.** DNS server Properties → Advanced → Enable automatic scavenging, 7 days. Set aging on the forward zone.
   ```powershell
   Set-DnsServerScavenging -ScavengingState $true -ScavengingInterval 7.00:00:00 -ApplyOnAllZones
   ```

**⚠ TRAP — IPv6 registration on a DC.**

Run `Resolve-DnsName ad.contoso.com`. If public IPv6 addresses appear (typically ISP-assigned `2xxx:` globals), domain members will try to reach the DC over an address that is not reliably routable inside the VLAN. This produces credential errors and DC promotion failures that look like authentication problems.

**🛑 Do NOT unbind IPv6 from the adapter.** Microsoft explicitly recommends against disabling IPv6 on domain controllers; Windows components assume it is present and unbinding produces obscure failures harder to diagnose than whatever it was meant to fix.

**Correct fixes, in order of preference:**
1. **Stop the router from advertising a global IPv6 prefix on the server VLAN.** Router-side change, fixes the cause.
2. If IPv6 is wanted internally, use **Unique Local Addresses** with stable router advertisements rather than dynamic ISP prefixes.
3. Prevent registration of the unwanted addresses in DNS rather than disabling the stack.

**Turning off router advertisements is only step one.** Addresses already on the NIC persist until the interface drops them, and AAAA records already in the zone persist until removed or scavenged. Restarting the adapter is not enough.

```powershell
# 1. See what the DC actually holds now
Get-NetIPAddress -AddressFamily IPv6 | Select-Object InterfaceAlias, IPAddress, PrefixOrigin, SuffixOrigin

# 2. Reboot after disabling router advertisements — this drops SLAAC-assigned addresses

# 3. Delete the stale AAAA records
Get-DnsServerResourceRecord -ZoneName "ad.contoso.com" -RRType AAAA |
    Remove-DnsServerResourceRecord -ZoneName "ad.contoso.com" -Force

# 4. Force re-registration
ipconfig /registerdns
Restart-Service netlogon

# 5. Verify — only the A record should remain
Resolve-DnsName ad.contoso.com
```

#### 2.3 Time

See `[AD-TIME]`. Configure the external anchor on the PDC emulator **now**, not later.

**✅ VERIFY BEFORE PHASE 3**
```powershell
dcdiag /v                  # expect all tests passing
nslookup ad.contoso.com    # returns the DC's LAN IP, nothing else
netdom query fsmo          # all five roles listed
w32tm /query /source       # an external NTP server, NOT "Local CMOS Clock"
Get-DnsServerForwarder
```

---

### PHASE 3 — Backup and AD Recycle Bin `[BUILD-P3]`

Do this **before creating a single object**. See `[AD-12]` and `[AD-13]`.

---

### PHASE 4 — DHCP and client DNS delivery `[BUILD-P4]`

```powershell
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerInDC

Add-DhcpServerv4Scope -Name "LAN" -StartRange 10.10.10.100 -EndRange 10.10.10.200 `
    -SubnetMask 255.255.255.0

# Hand out BOTH domain controllers as DNS, in order
Set-DhcpServerv4OptionValue -ScopeId 10.10.10.0 `
    -DnsServer 10.10.10.10,10.10.10.11 `
    -DnsDomain "ad.contoso.com" `
    -Router 10.10.10.1
```

**🛑 The DHCP pool must not overlap your static addresses.**

This is the most commonly missed step on consumer and prosumer firewalls, which frequently default the pool to the entire subnet — `.1` through `.254`. If your gateway is `.1` and your DCs are `.10` and `.20`, those addresses sit inside the pool and DHCP is free to lease them to a client.

**The failure is intermittent and vicious.** Everything works until the day a laptop is handed the DC's address. Then authentication, DNS, and file services fail simultaneously across the whole site, and **the cause is invisible from the server**.

```powershell
Add-DhcpServerv4ExclusionRange -ScopeId 10.10.10.0 -StartRange 10.10.10.1 -EndRange 10.10.10.99
Get-DhcpServerv4ExclusionRange -ScopeId 10.10.10.0
```

On a firewall appliance, set the pool's start address above your static block instead. **Also check for a separate Search Domain / Domain Name field** — see the trap in `[NET-10]`.

**✅ VERIFY FROM A CLIENT, NOT FROM THE SERVER**
```powershell
ipconfig /all                      # both DCs listed as DNS servers
nslookup ad.contoso.com
nltest /dsgetdc:ad.contoso.com
```

---

### PHASE 5 — OU structure and container redirection `[BUILD-P5]`

```powershell
$Root = "DC=ad,DC=contoso,DC=com"
New-ADOrganizationalUnit -Name "Contoso" -Path $Root -ProtectedFromAccidentalDeletion $true
$Org = "OU=Contoso,$Root"

"Employees","Workstations","Servers","Groups","ServiceAccounts","Disabled" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_ -Path $Org -ProtectedFromAccidentalDeletion $true
}
```

Resulting tree:
```
ad.contoso.com
├── Domain Controllers        (built-in — leave alone)
├── CN=Users                  (built-in container — NO GPO reaches here)
├── CN=Computers              (built-in container — NO GPO reaches here)
└── OU=Contoso                ← everything you build
    ├── OU=Employees
    ├── OU=Workstations
    ├── OU=Servers
    ├── OU=Groups
    ├── OU=ServiceAccounts
    └── OU=Disabled
```

**🛑 Do NOT name top-level OUs "Users" or "Computers".** Those names collide with the built-in containers `CN=Users` and `CN=Computers`, which already exist at the domain root. Beyond the collision, those containers have two hard limitations: **you cannot create OUs inside them, and you cannot link a GPO to them.** Anything sitting in them receives only the Default Domain Policy.

#### 5.2 Redirect the default containers — the one command nobody runs

```powershell
redircmp "OU=Workstations,OU=Contoso,DC=ad,DC=contoso,DC=com"
redirusr "OU=Employees,OU=Contoso,DC=ad,DC=contoso,DC=com"
```

**WHY this matters so much:** by default, every machine that joins the domain lands in `CN=Computers`, where **no GPO can reach it**. That is the number one cause of *"the new PC didn't get its settings."* `redircmp` changes the default landing spot to a real OU, so every future machine receives the workstation baseline automatically with no manual step. It converts a checklist item everyone forgets into something that cannot be forgotten.

**✅ VERIFY**
```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
Get-ADDomain | Select-Object ComputersContainer, UsersContainer
```

---

### PHASE 6 — Security groups `[BUILD-P6]`

See `[AD-AGDLP]`. Build both tiers before any user or any permission exists.

---

### PHASE 7 — File services `[BUILD-P7]`

See `[FILE]` — Section 08.

---

### PHASE 8 — Group Policy `[BUILD-P8]`

See `[GPO]` — Section 07.

---

### PHASE 9 — Cloud identity, before creating users `[BUILD-P9]`

See `[HYB]` — Section 09. **This phase sits here for one reason:** the UPN suffix is a property of every user account. Setting it correctly at creation costs nothing. Fixing it afterward means rewriting every account in the directory.

**🔄 Complete the full public DNS record set in this phase, at the same sitting as domain verification.** Verifying a domain (the `MS=` TXT record) is enough to set a UPN suffix and run Entra Connect, so it is tempting to stop there and move on to identity work. **That defers work that has to be done anyway and does it later under worse conditions** — with users already synced, already licensed, and already expecting a working mailbox. A verified-but-unconfigured domain is the most common half-finished state in an SMB tenant, and its signature is "we can send but we can't receive." Full record set and procedure: **§28 `[DNS-MAIL-00]`**; pre-flight: `[DNS-MAIL-PRE]`.

---

### PHASE 10 — Create users `[BUILD-P10]`

See `[AD-10]`. Script it from the first user, not the tenth. **The script is the documentation.**

---

### PHASE 11 — Build and join workstations `[BUILD-P11]`

See `[WIN]` — Section 13.

---

### PHASE 12 — Intune policy and applications `[BUILD-P12]`

See `[MDM]` — Section 10.

---

### PHASE 13 — Second DC and real redundancy `[BUILD-P13]` `[AD-FAILOVER]`

Adding DC02 is the easy part. **Making the environment actually fail over is the part that gets skipped.**

#### 13.1 Build DC02

1. **Independent hardware, or a VM on an always-on hypervisor host.** Not a desktop that gets powered off.
2. If virtualized on Hyper-V, attach to an **External** virtual switch. The Default Switch is NAT and cannot reach the LAN.
3. **Disable host time synchronization before promotion** — see `[AD-TIME]`.
4. Base build as Phase 1. Static IP. Preferred DNS = DC01, Alternate = `127.0.0.1`.
5. **Join to the domain as a member server first, reboot, then promote.** Direct promotion of a non-joined server fails more often and the credential error it produces is misleading.
6. Add AD DS role → Promote → **Add a domain controller to an existing domain** → DNS server checked → Global Catalog checked → DSRM password to the vault → replicate from DC01.
7. Install management tools: `Install-WindowsFeature GPMC, RSAT-AD-Tools, RSAT-DNS-Server`
8. Set time to follow the domain hierarchy.

**⚠ Domain controllers do not live in your `OU=Servers`.** Promoting a server moves its computer object into the built-in **Domain Controllers** OU, and it stays there. That OU is where the Default Domain Controllers Policy is linked, and that policy grants the user rights a DC needs to function. **Moving a DC out of it breaks authentication in ways that are difficult to diagnose.** `OU=Servers` is for member servers; in a single-server lab it will legitimately sit empty. Build it anyway.

#### 13.2 Wire up the redundancy — the part that is usually missed

| Component | Required configuration |
|---|---|
| DC01 DNS client settings | Preferred: **DC02**, Alternate: `127.0.0.1` |
| DC02 DNS client settings | Preferred: **DC01**, Alternate: `127.0.0.1` |
| DHCP option 6 | **Both** DC addresses, in order |
| DHCP service itself | DHCP failover between the two DCs, or a split scope |
| File shares | Still single-homed. Use DFS Namespaces + DFS Replication if file redundancy is required. |
| FSMO roles | Documented, with a seizure procedure written — SOP-07 |

```powershell
# Cross-point DNS client settings
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("10.10.10.11","127.0.0.1")  # on DC01
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("10.10.10.10","127.0.0.1")  # on DC02

# DHCP failover
Add-DhcpServerv4Failover -Name "DC01-DC02" -PartnerServer "SITE-DC02.ad.contoso.com" `
    -ScopeId 10.10.10.0 -LoadBalancePercent 50
```

**🛑 A second DC does not create redundancy by itself.** If clients have only one DNS server address they cannot locate the second DC when the first is down, because they cannot resolve the `_ldap._tcp` SRV records that find a domain controller.

**🛑 A DC on a machine that gets turned off is worse than no second DC.** It accumulates replication lag and can serve stale directory data when it comes back. Either give it always-on hardware or demote it properly when the lab is idle.

#### 13.3 How to test failover correctly

**The naive test is worthless.** Powering off DC01 and logging into a client proves nothing: Windows caches the last several domain logons locally and will authenticate a previously-seen user **with no domain controller reachable at all**.

Do this instead:

1. **Fix client DNS delivery first** — both DCs, via DHCP. Without this, the test is meaningless.
2. On a test client, **use an account that has never logged into that machine** (or clear cached credentials for the test account). Cached credentials are exactly what invalidates the naive test.
3. Power off DC01.
4. On the client: `nltest /dsgetdc:ad.contoso.com` — **it must return DC02.**
5. Log in with the never-before-used account. Success proves **live** authentication against DC02.
6. `gpresult /r` — confirm policy applied and note which DC it came from.
7. Open a mapped drive. **If shares live only on DC01, they are gone** — file services were never made redundant, only the directory was.
8. Power DC01 back on. Run `repadmin /replsummary` and confirm replication converges with no errors.

**Supporting evidence that an environment still assumes one DC:** Group Policy Management fails to open while DC01 is down and has to be manually pointed at DC02. That is the environment telling you.

**✅ VERIFY REPLICATION**
```powershell
Get-ADDomainController -Filter * | Format-Table Name, HostName, Site, IsGlobalCatalog
repadmin /replsummary        # no errors, no large deltas
repadmin /showrepl
dcdiag /v
dcdiag /test:dns
```

---

### PHASE 13.5 — Azure Arc (optional) `[AZ-ARC]`

Azure Arc projects on-premises servers into Azure as managed resources — single inventory, Azure Policy compliance, Update Manager, Log Analytics, and Defender for Cloud across on-prem and cloud.

**Prerequisites that are not obvious:**
- **An Azure subscription. A Microsoft 365 subscription is not one.** They are separate billing constructs.
- **Azure RBAC, which is separate from Entra roles.** Being Global Administrator in Entra grants you nothing in Azure. See `[AZ-RBAC-VS-ENTRA]`.
- The **Azure Connected Machine Onboarding** or **Contributor** role at the target resource group.

```
Azure portal > Subscriptions > [subscription] > Access control (IAM)
  > Add role assignment > Contributor > assign to your daily admin account

# If NO account has access at all:
Entra admin center > Properties
  > Access management for Azure resources = Yes   (temporarily elevates the Global Admin)
  > assign a proper RBAC role, then set this back to No
```

Onboard: Azure portal → Azure Arc → Machines → Add → Generate script → run on each server as administrator.

**Two failures you will hit:**

```powershell
# 1. "azcmagent is not recognized" — the installer added it to PATH, but your session predates that
& "C:\Program Files\AzureConnectedMachineAgent\azcmagent.exe" show

# 2. InvalidOnboardToken — the generated script's token is short-lived
& "C:\Program Files\AzureConnectedMachineAgent\azcmagent.exe" disconnect --force
& "C:\Program Files\AzureConnectedMachineAgent\azcmagent.exe" connect `
    --resource-group "rg-name" --tenant-id "<tenant>" `
    --location "<region>" --subscription-id "<sub>"
```

**✅ VERIFY:** `azcmagent show` → `Agent Status : Connected`, and the machine appears as Connected in Azure Arc → Machines.

---

### PHASE 14 — Operations and handover `[BUILD-P14]`

None of this is interesting. All of it is what keeps you on the account.

**14.1 Backup and recovery**
- System State backup of every DC, nightly, written **off** the server
- File data backed up with versioning and an offsite copy
- **3-2-1:** three copies, two media types, one offsite
- **Test a restore and record the date you tested it**

**14.2 Documentation — these are deliverables, not notes**
- Network topology diagram, one page, current
- IP and hostname register
- AD structure: OUs, groups, and what each group grants
- GPO register: name, link, purpose, last reviewed
- Credential vault entries, complete, **including DSRM and break-glass**
- Runbooks — the SOPs in Section 15
- Licensing register: what is owned, what it entitles, renewal dates
- Evaluation and certificate expiry dates, **with calendar reminders**

**14.3 Security hygiene**
- LAPS deployed **and verified retrievable**
- Separate accounts: daily user, admin account, break-glass. **Never browse the internet from a DC.**
- MFA on every administrator
- Domain Admins membership reviewed quarterly — it should be nearly empty
- Remote access via RMM or VPN. **Never RDP exposed to the internet.**
- A Disabled OU with a defined retention period

**14.4 Monitoring**
- **Backup success/failure alerting — the single most valuable alert you can configure**
- Disk space on every server volume
- AD replication health
- Certificate and license expiry
- Failed logon spikes and account lockout patterns


---

## 07 — GROUP POLICY `[GPO]`

### `[GPO-01]` The rule that trips everyone

**Group Policy applies based on where the user or computer object sits in the OU tree. It does not apply to groups, and it does not care where groups live.**

> **OUs scope policy. Groups filter policy.**

Linking a GPO to an OU full of security groups accomplishes exactly nothing. Groups filter — through security filtering or item-level targeting — they never scope.

Corollary: **Computer Configuration links to the OU holding the computers. User Configuration links to the OU holding the users.** Configuring the user half of a GPO and linking it to a computers OU produces silence.

### `[GPO-02]` Ground rules

- **Default Domain Policy:** password and account lockout policy **only**. Those must live at the domain root to be honored for domain accounts. Nothing else goes in it.
- **Default Domain Controllers Policy:** leave alone entirely.
- **One GPO, one purpose.** A forty-setting monolith cannot be troubleshot.
- Name GPOs `<Scope> - <Purpose>` so the link is obvious from the name.

### `[GPO-03]` Order of precedence

Later overwrites earlier:

**L → S → D → OU** — Local policy, then Site, then Domain, then OU (parent OU before child OU).

Modifiers:
- **Enforced** (formerly "No Override") on a link makes it win regardless of position and survives Block Inheritance.
- **Block Inheritance** on an OU stops policy flowing down from above — except from Enforced links.
- Multiple GPOs linked at the same OU: **lowest link order number wins** (link order 1 is applied last, so it wins).

### `[GPO-04]` GPOs to build in a standard SMB environment

#### A. Default Domain Policy — passwords and lockout
```
Computer Configuration > Policies > Windows Settings > Security Settings
  > Account Policies > Password Policy
      Minimum password length: 14
      Password must meet complexity requirements: Enabled
  > Account Lockout Policy
      Account lockout threshold: 10
      Reset counter after: 15 minutes
      Account lockout duration: 15 minutes
```

#### B. `Workstations - Baseline Security` → linked to `OU=Workstations`
```
Computer Configuration > Policies > Windows Settings > Security Settings
  > Local Policies > Security Options
      Interactive logon: Message title for users attempting to log on
      Interactive logon: Message text for users attempting to log on
      Accounts: Guest account status = Disabled
      Interactive logon: Don't display last signed-in = Enabled

Computer Configuration > Policies > Administrative Templates > System > Logon
      Always wait for the network at computer startup and logon = Enabled
```

**⚠ "Always wait for the network" is not optional in practice.** Windows uses **fast logon optimization** by default, processing policy in the background from a cache. Drive maps, Folder Redirection, and software installation all need the network available *during* logon. Without this setting they can take two or three reboots to appear. **When a user says "the drive shows up eventually," this is why.**

#### C. `Workstations - LAPS` → linked to `OU=Workstations`
See `[SEC-LAPS]`.

#### D. `Workstations - MDM Auto-Enrollment` → linked to `OU=Workstations`
```
Computer Configuration > Policies > Administrative Templates > Windows Components > MDM
      Enable automatic MDM enrollment using default Azure AD credentials = Enabled
      Select Credential Type to Use = User Credential
```

**Build this now even if the tenant does not exist yet.** It does nothing until hybrid join is configured, and then it simply works.

**WHY this specific GPO saves days:** this is the method that produces **Corporate** device ownership and full management capability. Manually adding a work account through Settings produces **Personal** ownership and a crippled device. Having this GPO in place before the first machine joins means you never take the manual shortcut and never inherit its consequences. See `[MDM-OWNERSHIP]`.

#### E. `Employees - Drive Maps` → linked to `OU=Employees`
```
User Configuration > Preferences > Windows Settings > Drive Maps
```

| Setting | Value |
|---|---|
| Action | **Update** — never Replace |
| Location | `\\SERVER\Company` |
| Drive letter | `S` |
| Reconnect | Checked |
| Label as | `Company` |
| Common tab | Run in logged-on user's security context — **checked** |
| Common tab | Item-level targeting — checked, Security Group = `GG-AllEmployees` |

One item per department, targeting the matching `GG-` group. Use letters from the end of the alphabet. **Avoid `A:` and `B:`** — legacy floppy letters that some line-of-business software still treats as removable media.

#### `[GPO-DRIVEMAP]` Drive Maps action reference — the one that causes hangs

| Action | Behavior | Use when |
|---|---|---|
| **Create** | Creates only if absent. **Later GPO changes are ignored.** | Almost never — it silently stops honoring your edits |
| **Update** | Creates if absent, modifies in place if present. | **Default choice for nearly every drive map** |
| **Replace** | **Deletes and recreates on every policy refresh.** | Rarely. Known cause of logon delays and `gpupdate` hangs. |
| **Delete** | Removes the mapping. | Decommissioning a share |

**🛑 `Replace` hangs `gpupdate /force`.** It deletes and recreates the mapping on every refresh. If the drive is open in Explorer, or a file on it is in use, the delete blocks and the policy engine stalls — requiring a power cycle. **Change the action to Update.**

#### F. `Employees - Folder Redirection` → linked to `OU=Employees`
```
User Configuration > Policies > Windows Settings > Folder Redirection
For Documents, Desktop, Pictures:
    Setting: Basic - Redirect everyone's folder to the same location
    Target:  Create a folder for each user under the root path
    Root path: \\SERVER\Redirected          <-- NOT the Home root
    Policy Removal: Leave the folder in the new location
    Grant the user exclusive rights: Enabled  (safe once the roots are separate)
```

**🛑 Folder Redirection applies at logon only.** `gpupdate /force` will never show you the result. The user must **fully log off and log back on**. Locking and unlocking is not a logoff.

**🛑 Home folders and redirected folders must use separate roots** — see `[FILE-502]`.

#### G. `Workstations - Remote Access` → linked to `OU=Workstations` (optional)
```
Computer Configuration > Policies > Administrative Templates > Windows Components
  > Remote Desktop Services > Remote Desktop Session Host
    > Connections
        Allow users to connect remotely by using Remote Desktop Services = Enabled
    > Security
        Require user authentication for remote connections by using
        Network Level Authentication = Enabled

Computer Configuration > Preferences > Control Panel Settings > Local Users and Groups
    Action: Update, Group: Remote Desktop Users
    Add: GG-IT     (scope who may connect — do not leave it open)
```

**⚠ RDP is the wrong tool for helpdesk.** Windows *client* operating systems support **one interactive session**. When you RDP into a user's workstation, **that user is disconnected from their own desktop.** You cannot watch what they are doing, you cannot show them anything, and you have interrupted them in order to help them.

| Tool | Use for | User stays logged in? |
|---|---|---|
| RMM remote control | Day-to-day helpdesk. The professional answer. | Yes — shared session |
| Quick Assist | Ad-hoc support, no infrastructure required | Yes — shared session |
| RDP to a **workstation** | Unattended work on an idle machine | **No — kicks the user off** |
| RDP to a **server** | Server administration | N/A — servers allow multiple sessions |

**🛑 NEVER expose RDP to the internet.** Not on 3389, not on an obscure high port. Internet-facing RDP is among the most common ransomware entry points in the SMB space. If you assess a client network and find RDP open to the world, **that is your first finding and it is urgent.** Acceptable paths: RMM agent, VPN then RDP, RD Gateway with MFA, or Azure Bastion.

### `[GPO-05]` Group Policy troubleshooting `[GPO-TRIAGE]`

```powershell
gpupdate /force
gpresult /r                                  # quick list of applied GPOs
gpresult /h C:\gpo.html; start C:\gpo.html   # THE readable report — use this one
gpresult /r /scope:computer
gpresult /scope:user /v
whoami /groups                               # did group membership actually resolve?
```

**Decision tree — "Group Policy isn't applying":**

1. Run `gpresult /h C:\gpo.html` and **read it.** This answers most of these tickets by itself.
2. Is the GPO listed as **applied** or **denied**? *Denied* tells you it is a filtering problem, not a linking problem.
3. **Not listed at all?** Is the GPO linked to an OU that actually contains this object? **Check where the object lives, not where you think it lives.**
   ```powershell
   Get-ADComputer PC001 | Select-Object DistinguishedName
   Get-ADUser jdoe      | Select-Object DistinguishedName
   ```
4. Is the object in `CN=Computers` or `CN=Users`? **No GPO reaches there.** Run `redircmp`/`redirusr` and move the existing objects.
5. Is the **link enabled**? Is the **GPO status** enabled for the half you need (user vs computer settings can be disabled independently)?
6. **Security filtering:** does the object have both **Read** and **Apply group policy**?
7. Did you configure **User settings on a computer OU**, or vice versa?
8. Folder Redirection or drive maps: **did the user fully log off**, or just lock the screen?
9. Group membership recently changed? A new token requires a full logoff. `whoami /groups` proves it.
10. Is SYSVOL reachable? `\\ad.contoso.com\SYSVOL` — policy is delivered over SMB 445.

**Server-side inventory:**
```powershell
Get-GPO -All | Sort-Object DisplayName | Format-Table DisplayName, GpoStatus, ModificationTime
Get-GPOReport -All -ReportType Html -Path C:\Temp\AllGPOs.html
Get-GPInheritance -Target "OU=Workstations,OU=Contoso,DC=ad,DC=contoso,DC=com"
Backup-GPO -All -Path C:\Temp\GPOBackup        # before changing anything on an inherited network
```

### `[GPO-06]` Group Policy vs Intune — decide who owns what, in writing

When both systems target the same setting, **the result is not reliably predictable.** Decide per category and write the decision down.

| Group Policy owns | Intune owns |
|---|---|
| Drive mappings and Folder Redirection | Security baselines |
| On-premises resource access | BitLocker and encryption |
| Legacy line-of-business requirements | Windows Update rings |
| Logon banners, local group membership | Application deployment |

---

## 08 — FILE SERVICES AND PERMISSIONS `[FILE]`

### `[FILE-01]` Folder layout

```
D:\
├── Company\        company-wide files
├── Departments\
│   ├── Sales\
│   ├── Accounting\
│   └── IT\
├── Home\           H: home drives
└── Redirected\     Folder Redirection target — SEPARATE ROOT from Home
```

### `[FILE-02]` The standard permission model — the one that saves you

| Layer | Setting | Reasoning |
|---|---|---|
| **Share permissions** | `Authenticated Users` = **Full Control**. Remove `Everyone`. | Opened deliberately so it is **never** the cause of a problem |
| **NTFS permissions** | **All** real access control, assigned to **groups** | One place to look, one place to fix |

**WHY leave the share layer wide open?** Share and NTFS permissions are evaluated together and **the more restrictive wins**. Enforcing security at both layers means every access problem has two candidate causes, and you will troubleshoot the wrong one about half the time. The industry standard is to open the share and let NTFS carry all the real control.

**🛑 Two rules that protect you:**

1. **Never remove `SYSTEM` or the administrative group from an ACL.** The operating system needs `SYSTEM`. Removing it can lock the server out of its own data, and recovery means taking ownership and rebuilding the ACL from scratch.
2. **"Replace all child object permission entries" is destructive and irreversible.** It erases every explicit permission beneath the folder. On a new empty tree it is harmless. On a client's production file server with a decade of accumulated per-folder permissions, **it destroys the entire permission model with no undo.**

**Before touching any existing ACL:**
```powershell
Get-Acl D:\Departments\Sales | Export-Clixml C:\Temp\acl-backup-sales.xml
# Restore:  Get-Content is not enough — use:
# $acl = Import-Clixml C:\Temp\acl-backup-sales.xml ; Set-Acl -Path D:\Departments\Sales -AclObject $acl
```

### `[FILE-03]` Create shares — idempotent version

```powershell
$Shares = @(
    @{Name="Company";     Path="D:\Company"},
    @{Name="Departments"; Path="D:\Departments"},
    @{Name="Home";        Path="D:\Home"},
    @{Name="Redirected";  Path="D:\Redirected"}
)

foreach ($S in $Shares) {
    if (-not (Test-Path $S.Path)) { New-Item -Path $S.Path -ItemType Directory -Force | Out-Null }

    if (Get-SmbShare -Name $S.Name -ErrorAction SilentlyContinue) {
        Write-Warning "$($S.Name) already shared - updating instead of creating"
        Set-SmbShare -Name $S.Name -FolderEnumerationMode AccessBased -Force
    }
    else {
        New-SmbShare -Name $S.Name -Path $S.Path `
            -FullAccess "Authenticated Users" `
            -FolderEnumerationMode AccessBased
        Write-Host "Created share $($S.Name)" -ForegroundColor Green
    }
}

Get-SmbShare | Where-Object { $_.Name -notlike "*$" } |
    Select-Object Name, Path, FolderEnumerationMode
```

**⚠ "The name has already been shared" — Windows system error 2118.** `New-SmbShare` **creates only**. If the share name exists it throws 2118 and does nothing — it will not update the existing share. Partially completing this step and re-running the whole block produces a wall of these errors while the shares that did succeed sit there working fine.

**The error text names the cause precisely.** Misattributing 2118 to a syntax or parameter problem sends you rewriting a script that was correct. To change an existing share use `Set-SmbShare`. To start over, `Remove-SmbShare -Name X -Force` then re-create.

### `[FILE-04]` Access-Based Enumeration (ABE)

```powershell
Set-SmbShare -Name "Departments" -FolderEnumerationMode AccessBased -Force
Get-SmbShare | Select-Object Name, FolderEnumerationMode
```

Users do not see folders they lack Read access to — the Accounting folder is **invisible** to Sales rather than visible-but-locked.

**ABE vs item-level targeting — they solve different halves of the same problem:**
- **Item-level targeting** controls whether a **drive letter** appears.
- **ABE** controls whether a **folder** appears.

Without ABE, a user who types the UNC path directly sees every department folder regardless of drive mappings. **Use both.**

### `[FILE-05]` NTFS permissions on a department folder

| Principal | Access | Applies to |
|---|---|---|
| Domain Admins | Full Control | This folder, subfolders and files |
| SYSTEM | Full Control | This folder, subfolders and files |
| `DL-Sales-Modify` | **Modify** | This folder, subfolders and files |
| CREATOR OWNER | Full Control | **Subfolders and files only** |

Break inheritance using **Convert inherited permissions into explicit permissions**, then remove what does not belong. Do **not** use "Replace all child object permission entries" on an existing tree.

### `[FILE-06]` Home and Redirected root permissions — exact values

| Principal | Access | Applies to |
|---|---|---|
| Domain Admins | Full Control | This folder, subfolders and files |
| SYSTEM | Full Control | This folder, subfolders and files |
| CREATOR OWNER | Full Control | **Subfolders and files only** |
| Authenticated Users | Traverse folder/execute file · List folder/read data · Read attributes · Read extended attributes · **Create folders/append data** · Read permissions | **This folder only** |

**WHY the "This folder only" scoping is critical:** users need to create their own folder at the root but must **not** inherit rights into anyone else's. `CREATOR OWNER` then gives each user full control over the folder they personally created. **This exact combination is what makes per-user private folders work without touching each one by hand.**

**⚠ Include "Traverse folder / execute file".** Omitting it usually still works, because the *Bypass traverse checking* user right is granted to Everyone by default and makes the traverse check unnecessary. But that default can be hardened away by a security baseline, and when it is, **users suddenly cannot reach their own home folders.** Include it and remove the dependency on a default you do not control.

### `[FILE-502]` Folder Redirection Event ID 502, "Access is denied" — the fix nobody finds

**Symptom:** Folder Redirection is configured correctly, the GPO applies, permissions have been verified repeatedly, and redirection still fails with Event 502.

**Actual cause:** Home folders and redirected folders are pointed at **the same root path**. Active Directory's home-folder feature creates the user's folder when you click Apply — and **the owner of that folder is the administrator account that created it, not the user.** Folder Redirection with "Grant the user exclusive rights" enabled then checks ownership of the existing folder, finds it does not belong to the user, and refuses with Access Denied.

**Correct fix: use separate roots.**
- `\\SERVER\Home` for AD home folders
- `\\SERVER\Redirected` for Folder Redirection

The conflict then cannot occur, and you keep the tighter per-user ACL that exclusive rights provides.

**⚠ Workaround vs fix:** unchecking "Grant the user exclusive rights" makes redirection work, but it is a workaround. It means each user's redirected folder does not get the locked-down per-user ACL. **In a client environment that is a privacy finding waiting to be written up.**

### `[FILE-07]` UNC paths: server name vs DFS Namespace

`\\SERVER\Share` is correct, works, and is the right starting point.

The production upgrade is a **domain-based DFS Namespace**, which gives a server-agnostic path:
`\\ad.contoso.com\shares\Departments\Sales` instead of `\\FILE01\Departments\Sales`

**⚠ A DFS path is not automatic — the namespace must exist first.** `\\ad.contoso.com\shares\` does not resolve simply because it is your domain name. Until you create it, that path returns "network path was not found."

```powershell
Install-WindowsFeature FS-DFS-Namespace -IncludeManagementTools
New-DfsnRoot   -TargetPath "\\FILE01\shares" -Type DomainV2 -Path "\\ad.contoso.com\shares"
New-DfsnFolder -Path "\\ad.contoso.com\shares\Departments" -TargetPath "\\FILE01\Departments"
```

**Decide once, before you author the drive-map GPO.** Switching later means editing every preference item. If you are not setting up DFS-N on this build, use the server name and move on — that is a valid choice, not a compromise. Revisit when you have two file servers, or when a server rename or replacement is on the horizon.

### `[FILE-08]` "I can't get to the file share" — triage `[FILE-TRIAGE]`

1. **Can they reach it by UNC path** (`\\SERVER\Share`)? If yes, the problem is the **drive mapping**, not access.
2. **Can they see it but not open files?** That is **NTFS**, not share permissions.
3. **Can they open but not save?** Modify permission missing, **or the "Applies to" scope is wrong.**
4. **Can nobody reach it?** Check the server, the `LanmanServer` service, and the firewall (TCP 445).
5. **Check effective access:** folder Properties → Security → Advanced → **Effective Access** tab. Test with the actual user account, not yours.
6. **Confirm group membership resolved on the client:** `whoami /groups`. A recently added group requires a full logoff.
7. Check for a **deny** ACE. Explicit Deny beats any Allow.

```powershell
Get-SmbShare | Select-Object Name, Path, FolderEnumerationMode
Get-SmbShareAccess -Name "Departments"
Get-Acl D:\Departments\Sales | Format-List
(Get-Acl D:\Departments\Sales).Access | Format-Table IdentityReference, FileSystemRights, AccessControlType, InheritanceFlags
Get-SmbOpenFile | Select-Object ClientUserName, Path        # who has files open right now
Get-SmbSession                                              # active sessions to this server
```

### `[FILE-09]` Take ownership and rebuild after a lockout

When an ACL cleanup removed SYSTEM or Administrators and nobody can reach the data:

```cmd
takeown /F "D:\Departments\Sales" /R /A /D Y
icacls "D:\Departments\Sales" /grant "Administrators:(OI)(CI)F" /T
icacls "D:\Departments\Sales" /grant "SYSTEM:(OI)(CI)F" /T
```

Then rebuild from the standard model in `[FILE-05]`. `(OI)` = object inherit (files), `(CI)` = container inherit (folders), `/T` = recurse.


---

## 09 — HYBRID IDENTITY `[HYB]`

### `[HYB-00]` 🔄 UPDATED — product names and what actually exists

**Verified against Microsoft Learn, August 2026.** Older references — including some AI-generated ones — describe a "modern engine" using a `ConnectSync.exe /SyncCycle` command line. **That does not exist.** Do not go looking for it.

| Product | What it is | Notes |
|---|---|---|
| **Microsoft Entra Connect Sync** | The current name for what was called **Azure AD Connect**. Same product, renamed. | Installer: `AzureADConnect.msi`. Sync engine path: `C:\Program Files\Microsoft Azure AD Sync\`. Wizard path: `C:\Program Files\Microsoft Azure Active Directory Connect\`. Managed by the **`ADSync` PowerShell module** and `Start-ADSyncSyncCycle`. |
| **Microsoft Entra Cloud Sync** | A *different*, lighter product. Agent-based, no SQL. | Configured in the Entra portal, not by PowerShell cmdlets on the server. |
| ~~`ConnectSync.exe /SyncCycle Delta`~~ | **Does not exist.** | Use `Start-ADSyncSyncCycle -PolicyType Delta`. |
| ~~`MSOnline`, `AzureAD` PowerShell modules~~ | **Retired.** | Use `Microsoft.Graph`. |

### `[HYB-01]` Connect Sync or Cloud Sync? The choice is determined, not preferred

| Capability | Entra Connect Sync | Entra Cloud Sync |
|---|---|---|
| Users, groups, contacts | Yes | Yes |
| **Device objects / hybrid join** | **Yes** | **No** |
| Sign-in methods | PHS, PTA, federation | PHS only |
| Sync interval | 30 min (floor) | ~2 min |
| On-prem footprint | Server + SQL Express | Lightweight agent |
| Disconnected / multiple forests | No | Yes |
| Exchange hybrid, group writeback | Yes | No |

**If you need hybrid Entra join, Connect Sync is the only option.** Cloud Sync does not synchronize device objects, and hybrid join requires the computer object to reach Entra ID. Choosing Cloud Sync would sync your users perfectly and make hybrid join **structurally impossible**.

Cloud Sync is right for cloud-first environments where devices are Entra *joined* rather than hybrid joined, for merged or disconnected forests, and where a lighter footprint matters. Microsoft is investing in it as the long-term default, so expect this balance to shift.

### `[HYB-02]` Install Entra Connect Sync

**🛑 Install on a member server, not a domain controller.** Entra Connect runs a SQL Express instance and a service account with directory-wide read access. On a DC that expands the attack surface of the most sensitive machine you have and complicates both patching and DC recovery. Microsoft's documented guidance is a dedicated member server. In a single-box lab you will install it on the DC and it will work — **know that it is a lab compromise and say so if asked.**

**Choose Customize, not Express.** Express gives no control over sync scope, which is the setting that matters most.

| Wizard page | Selection |
|---|---|
| Sign-in method | **Password Hash Synchronization** + **Enable single sign-on** |
| Domain and OU filtering | Explicitly select `OU=Employees`, **`OU=Workstations`**, and `OU=Groups` |
| Optional features | Leave defaults unless there is a specific requirement |
| **Configure device options** | **Configure Microsoft Entra hybrid join — in this same sitting** |
| Device operating systems | Windows 10 or later domain-joined |
| SCP configuration | Check the forest · Authentication Service = **Microsoft Entra ID** · supply Enterprise Admin credentials |

**⚠ WHY the Workstations OU must be in scope:** hybrid Entra join requires the **computer object** to exist in Entra ID before a device can complete registration. If that OU is not synced, clients report `AzureAdJoined : NO` with `error_missing_device` — which looks like a client problem and is actually a sync-scope problem.

### `[HYB-03]` 🛑 STOP — verify the SCP before going any further `[HYB-SCP]`

**This is the single easiest step in the entire build to skip without knowing.**

"Configure device options" is **not part of the linear install wizard.** It is a separate task chosen from the menu when Entra Connect is launched *again* after installation. **The installer can complete, report success, and synchronize every user flawlessly — with hybrid join never configured.** Nothing warns you. The failure only surfaces later, on a client, as `AzureAdJoined : NO`.

Treat the check below as mandatory:

```powershell
# On a domain controller
$scp = Get-ADObject -Filter 'Name -eq "62a0ff2e-97b9-4513-943f-0d221bd30080"' `
        -SearchBase "CN=Configuration,DC=ad,DC=contoso,DC=com" -Properties keywords
$scp.keywords
```

**Required output — exactly two values:**
```
azureADName:yourtenant.onmicrosoft.com
azureADId:<your-tenant-guid>
```

Anything else — no object found, empty keywords, only one value — means hybrid join was never configured. Relaunch Entra Connect → **Configure device options → Configure Microsoft Entra hybrid join**, then re-run this check.

*(The GUID `62a0ff2e-97b9-4513-943f-0d221bd30080` is the well-known device registration configuration object. It is the same in every forest.)*

### `[HYB-04]` Running sync cycles `[HYB-SYNC]`

```powershell
Import-Module ADSync

Start-ADSyncSyncCycle -PolicyType Delta      # only objects changed since last cycle — routine
Start-ADSyncSyncCycle -PolicyType Initial    # full reimport and reevaluation of everything
Stop-ADSyncSyncCycle                         # stop a running cycle so you can change config

Get-ADSyncScheduler                          # is the scheduler enabled? when is the next run?
Set-ADSyncScheduler -SyncCycleEnabled $true  # re-enable after maintenance
Set-ADSyncScheduler -SyncCycleEnabled $false # disable before an uninstall or major change

Get-ADSyncConnector | Select-Object Name, Type
Get-ADSyncGlobalSettings | Select-Object Version
```

**🛑 After ANY configuration change, run a FULL sync.** `-PolicyType Delta` only processes objects that have **changed**. Your computer objects have not changed — **what changed is the sync engine's rule set.** A delta sync will appear to succeed and move nothing. Use `Initial` after every configuration change, including a repair.

**The default cycle is 30 minutes.** A large share of "it didn't work" during hybrid setup is actually "it hasn't synced yet." When testing, force the sync rather than waiting — and when something appears broken, **check the clock before you check the configuration.**

**⚠ Do not run multiple sync cycles simultaneously.** Concurrent operations are not supported and can produce conflicts, partial updates, or service instability.

**⚠ Do not leave the scheduler disabled.** While it is off, object changes in AD stop propagating to Entra ID entirely. If you disable it for maintenance, put a reminder in the ticket to turn it back on.

### `[HYB-05]` ADSync module won't load

```powershell
Get-Module -ListAvailable ADSync           # is it visible to PowerShell at all?
Import-Module "C:\Program Files\Microsoft Azure AD Sync\Bin\ADSync"   # load from disk directly
Get-Command -Module ADSync                 # confirm it loaded
$env:PSModulePath -split ";"               # is the module directory in the search path?
```

**Common causes, in order:**
1. PowerShell is not running **as Administrator**
2. Entra Connect is not installed on the machine you are querying
3. The session was opened **before** the install — module paths are read at session start. Open a new elevated session.
4. The module path is not registered in `PSModulePath`
5. The `Microsoft Azure AD Sync` (ADSync) Windows service is stopped or errored — `Get-Service ADSync`
6. **The wrong product is installed** — Entra **Cloud** Sync does not include the ADSync module at all

### `[HYB-06]` Diagnostics and logs

- **Synchronization Service Manager** — `C:\Program Files\Microsoft Azure AD Sync\UIShell\miisclient.exe`. Graphical view of connector state, import/export statistics, and run history. **The most efficient tool for object-level sync errors.**
- **Event Viewer** → Application and System logs, sources *Directory Synchronization*, *ADSync*, *Microsoft Entra Connect*.
- **Entra Connect Health** in the Entra admin center, if licensed.

**🛑 The sync server is Tier 0.** It holds highly privileged credentials for both on-premises AD and the Entra tenant. Restrict access to identity administrators only, apply least privilege to its service accounts, and patch and monitor it consistently with your domain controllers.

### `[HYB-07]` Group-based licensing — three steps, all required `[HYB-LIC]`

```
1. CREATE the group
   Entra admin center > Groups > New group > Security > "LIC-M365-BusinessPremium"

2. ASSIGN the SKU to the group
   M365 admin center > Billing > Licenses > select SKU > Assign licenses > select the group

3. PUT SOMEONE IN THE GROUP        <-- THE STEP THAT GETS MISSED
   Add the synced GG-AllEmployees group as a MEMBER of LIC-M365-BusinessPremium
```

**🛑 An empty licensing group throws no error and shows no warning.** Users sync to Entra correctly, appear in the portal correctly, and are simply unlicensed. **The symptom does not appear until much later and in a completely different product:** Intune enrollment silently fails, because the MDM auto-enrollment GPO runs in the *user's* context and an unlicensed user cannot enroll a device. Intune does not report "unlicensed user" — it simply never shows the device.

Working backwards from an absent device to an empty licensing group is a long walk. **Verify licensing at this phase instead.**

**Nest the on-prem role group into the cloud licensing group, once:**
```
GG-AllEmployees  (synced from on-prem AD)
      |
      +--> member of --> LIC-M365-BusinessPremium  (Entra, holds the SKU)
```

Your user-creation script already adds each new user to a `GG-` department group, which nests into `GG-AllEmployees`, which now nests into the licensing group. **Create a user, and they are licensed on the next sync — no manual assignment, ever.** This is the same AGDLP chaining logic applied to licensing.

**On direct license assignment:** assigning a license straight to a user is the **correct diagnostic step** — it isolates whether the problem is the license or the group plumbing. That is not a contradiction of the group model. **Remove the direct assignment once the root cause is fixed**, or you create a user whose licensing survives removal from every group — exactly the offboarding gap group licensing exists to prevent.

**✅ VERIFY BEFORE LEAVING THIS PHASE**
- M365 admin center → Billing → Licenses → select the SKU. **Assigned count should equal your user count.**
- Users should show as licensed **via group**, not by direct assignment.
- M365 admin center → Users → Active users → [a user] → Licenses and apps. **Confirm Intune is checked in the app list, not just the parent SKU.**
- Check **Licenses → Errors & Issues**. Group licensing failures — usually insufficient licenses or a conflicting service plan — surface there and nowhere else.

### `[HYB-08]` Hybrid join sequence and expected delays `[HYB-JOIN]`

`AzureAdJoined : NO` immediately after a domain join is **normal**. Hybrid join is a separate registration with a dependency chain, and each link takes time:

```
Domain join
  -> computer object created in AD
     -> Entra Connect syncs it to Entra ID (up to 30 min, or force it)
        -> device object exists in Entra
           -> client scheduled task registers the device
              -> AzureAdJoined : YES
                 -> user logs off and back on
                    -> AzureAdPrt : YES        (PRT is issued at logon)
                       -> Intune enrollment can now proceed
```

**Nothing downstream works until the PRT exists. Do not troubleshoot Intune before `AzureAdPrt : YES`.**

**If `AzureAdJoined` stays NO — work it in this order:**

```powershell
# 1. Read the ACTUAL error, at the bottom of the status output
dsregcmd /status            # scroll to the Diagnostic Data block

# 2. On the DC: is the SCP present?  (see [HYB-SCP])
$scp = Get-ADObject -Filter 'Name -eq "62a0ff2e-97b9-4513-943f-0d221bd30080"' `
        -SearchBase "CN=Configuration,DC=ad,DC=contoso,DC=com" -Properties keywords
$scp.keywords

# 3. Force a FULL sync — delta will not move an unchanged object
Import-Module ADSync
Start-ADSyncSyncCycle -PolicyType Initial

# 4. Confirm the device object arrived
#    Entra admin center > Devices > All devices   (state "Pending" is normal and fine)

# 5. ONLY THEN, on the client: clear stale state and re-register
dsregcmd /leave
Restart-Computer
# after reboot, logged in AS THE END USER:
Get-ScheduledTask -TaskPath "\Microsoft\Windows\Workplace Join\" |
    Start-ScheduledTask -TaskName "Automatic-Device-Join"
dsregcmd /status
```

### `[HYB-09]` Reading the `dsregcmd /status` Diagnostic Data block

| What it says | What it means |
|---|---|
| `error_missing_device` with `Server operation: DeviceRenew` | The client holds a **cached device ID** and is trying to renew a registration that no longer exists in Entra. Clear it with `dsregcmd /leave` and reboot — **a plain retry will keep failing.** |
| `error_missing_device` with `Server operation: DeviceJoin` | The device object genuinely is **not in Entra**. Sync scope or SCP problem. |
| `0x80090303` on `DEVICE_AUTO_KERB` | Cloud Kerberos trust is not configured. **Expected and harmless** — the client falls back to `DEVICE_AUTO`. Not your problem. |
| `AzureAdPrt : NO` but `AzureAdJoined : YES` | Registration succeeded; the user has not logged on since. **Sign out and back in.** |
| `DomainJoined : NO` | It never joined the on-prem domain. You are troubleshooting the wrong layer. |

Key fields in `dsregcmd /status`:
```
DomainJoined : YES        <- on-prem AD
AzureAdJoined : YES       <- hybrid Entra registration
AzureAdPrt : YES          <- Primary Refresh Token, issued at user logon
MdmUrl / MdmEnrollmentUrl <- present means MDM enrollment is configured
```

Once hybrid join succeeds, confirm in Intune that the device appears within about 15 minutes and **Ownership shows Corporate**. If it shows Personal, fix it now — see `[MDM-OWNERSHIP]`.

### `[HYB-10]` Entra dynamic device groups — create these early

```
Entra admin center > Groups > New group
  Type: Security     Membership type: Dynamic Device

DYN-Windows-Corporate:
  (device.deviceOSType -eq "Windows") and (device.deviceOwnership -eq "Company")

DYN-Hybrid-Joined:
  (device.deviceTrustType -eq "ServerAD")

By naming convention:
  (device.displayName -startsWith "WS-") and (device.deviceOSType -eq "Windows")
```

**🛑 You cannot use a synced on-premises group to target devices in Intune.** Computer objects arrive in Entra as **device objects**, and an on-premises group's membership of computer objects **does not translate** into Entra device group membership. You cannot fix device targeting by widening group sync scope.

**Dynamic device groups are the answer:** define the rule once, and every matching device joins automatically, forever, with no human step. It scales to any fleet size and requires no maintenance. Group sync from on-premises remains useful for **user** groups; it is the wrong tool for devices.

**⚠ Dynamic group membership takes several minutes to populate** after a device registers. When an assignment appears to do nothing, open the group and confirm the device is actually in it before troubleshooting anything else.

---

## 10 — INTUNE AND DEVICE MANAGEMENT `[MDM]`

### `[MDM-01]` Build order

Confirm the tenant side first:
```
Entra admin center > Devices > Mobility (MDM and MAM) > Microsoft Intune
    MDM user scope = All  (or a pilot group)
```

Then build policy **in this order**:

| Item | Location | Why in this order |
|---|---|---|
| Compliance policy | Devices → Compliance | Defines what "healthy" means. Everything downstream references it. |
| Conditional Access | Entra → Protection → Conditional Access | Require compliant device + MFA. **Exclude the break-glass account.** |
| BitLocker | Devices → Configuration → Endpoint protection | Encryption with recovery key escrow to Entra |
| Update rings | Devices → Windows Update | Patch management with a pilot ring |
| Microsoft 365 Apps | Apps → All apps → Add → Microsoft 365 Apps | 64-bit, Current Channel, Remove other versions = Yes. Assign to `DYN-Windows-Corporate`. |
| Defender for Endpoint | Endpoint security | Baseline antivirus and EDR policy |

**⚠ Portal paths change constantly.** Microsoft rearranges these admin centers regularly, and any written click-path — including this one — will go stale. **Search the portal for the feature name** ("Automatic enrollment", "Device settings", "Compliance policies") rather than following a path from a document. Distrusting a stale path is a correct instinct, not a failure to follow instructions.

### `[MDM-OWNERSHIP]` 🛑 Device ownership — the most instructive failure in hybrid work

**The failure chain, as it actually plays out:**

| Day | What happened |
|---|---|
| **3** | Intune auto-enrollment is not working. As a workaround, the technician signs in as `DOMAIN\Administrator` and manually adds a work account through Settings. The device enrolls. Problem apparently solved. |
| **6** | Microsoft 365 Apps will not deploy to that machine. Company Portal shows a "functionality limited" banner. Hours are spent chasing a missing Intune Management Extension, clearing enrollment registry keys, attempting manual agent installs. |
| — | The two events are never connected during troubleshooting. |

**Actual cause:** manually adding a work account through Settings is **user-driven enrollment**, and Intune marks devices enrolled that way as **Personal**. Personal-owned devices have deliberately reduced management capability. Devices enrolled through **GPO auto-enrollment, Autopilot, or a pre-registered corporate identifier** are marked **Corporate** and get full management.

**The day-3 shortcut caused the day-6 failure.**

**Correction — you do not have to abandon the device:**
```
Intune admin center > Devices > All devices > [select device]
  > Properties > Device ownership > change to Corporate
```

**Prevention — set ownership correctly before enrollment ever happens:**
```
Intune admin center > Devices > Enrollment > Corporate device identifiers
  > Add serial numbers (CSV import)
```

Or simply **let the Phase 8 MDM auto-enrollment GPO do it** — see `[GPO-04]` item D.

### `[MDM-02]` Know which delivery mechanism you are troubleshooting

| What you're deploying | Delivery mechanism | Requires IME? |
|---|---|---|
| Microsoft 365 Apps | **Office CSP** over the MDM channel | **No** |
| Configuration profiles | **OMA-DM** | No |
| Store apps | MDM channel | No |
| Packaged `.intunewin` Win32 apps | **Intune Management Extension** | Yes |
| PowerShell scripts | **Intune Management Extension** | Yes |
| Proactive remediations | **Intune Management Extension** | Yes |

**The IME is not in the path for Microsoft 365 Apps, so its absence is never the cause of that app failing to install.** Hours have been lost to this exact mistake. Confirm the component is actually in the path before spending time on it — `[DOCTRINE-01]`.

### `[MDM-03]` Verify an app deployment from the client, not the portal

The Intune portal reports installation status on its own schedule and lags reality by a long way. **Check the client directly** — an answer in seconds instead of waiting an hour on a console.

```powershell
# Is the Office installer actually running?
Get-Process OfficeClickToRun, setup, OfficeC2RClient -ErrorAction SilentlyContinue |
    Select-Object Name, StartTime, CPU

# Is the Intune Management Extension present? (Win32 apps and scripts only)
Get-Service IntuneManagementExtension -ErrorAction SilentlyContinue

# What did the MDM channel actually do?
Get-WinEvent -LogName "Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin" `
    -MaxEvents 30 | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-List

# Did Office land?
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" -ErrorAction SilentlyContinue |
    Select-Object ProductReleaseIds, VersionToReport, UpdateChannel

# IME logs (Win32 apps / scripts)
Get-ChildItem "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs"
```

**`OfficeClickToRun.exe` consuming CPU means the deployment fired and is downloading. That is a successful outcome** — you do not need to wait for the portal to confirm it.

### `[MDM-04]` When an assignment appears to do nothing

Work this list in order — the first item is the cause the large majority of the time.

1. **Licensing.** The user must have an **Intune** license. Check the service plan, not just the parent SKU. Check Licenses → Errors & Issues. See `[HYB-LIC]`.
2. **Group membership.** A dynamic device group can take several minutes to populate after a device registers. **Open the group and confirm the device is actually in it.**
3. **Targeting type.** A **device-targeted** assignment installs per-machine; a **user-targeted** one installs at user logon. Mixing them up produces "nothing happened."
4. **Group type.** On-premises synced groups **cannot contain Entra device objects** — see `[HYB-10]`.
5. **Sync.** Force one from the client: Settings → Accounts → Access work or school → select the account → Info → **Sync**.
6. **PRT.** `dsregcmd /status` must show `AzureAdPrt : YES`. Without it the device cannot authenticate to Intune at all.

### `[MDM-05]` Device sync from the client — three routes

- Company Portal app → **Settings → Sync**
- Right-click the Company Portal app on the taskbar/Start → **Sync this device**
- Windows Settings → **Accounts → Access work or school → [account] → Info → Sync**

Use this when a work app installation or a policy change appears stalled.

### `[MDM-06]` Retire vs Wipe

| Action | Use case | Effect |
|---|---|---|
| **Retire** | Personally owned device, or a device leaving org control | Removes company data, unenrolls the device, removes managed apps/settings/profiles. **Preserves personal data and the OS.** |
| **Wipe** | Device reset, repurpose, lost/stolen, secure erase | **Factory resets** the device — removes personal and organizational data, apps, and configuration. |

Rule of thumb: **BYOD → Retire. Company-owned → Wipe.**

### `[MDM-07]` Device not compliant — checklist

- Confirm the device is **enrolled** (it appears in Intune at all)
- Confirm the user has the required **license**
- Confirm the compliance policy is actually **assigned** to a group containing this device or user
- Ask the user to **sync** the device
- Open the device → **Device compliance** → read the specific failing setting
- Confirm the required security settings: encryption, password/PIN, minimum OS version, threat protection
- Note the **grace period** — a device can be non-compliant but not yet blocked
- Document status and escalation path

### `[MDM-08]` Enrollment failure — checklist

- Confirm the user **license**
- Confirm the user is **allowed to enroll** (MDM user scope includes them)
- Confirm the **device platform** is supported
- Confirm **device limit** restrictions have not been hit
- Confirm **enrollment restrictions** (device type, personally-owned block)
- Confirm network access to Microsoft endpoints
- **Collect the exact error code and a screenshot** — Intune error codes are specific and searchable

### `[MDM-09]` BitLocker recovery

```powershell
manage-bde -status C:                        # local state
Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage
(Get-BitLockerVolume -MountPoint C).KeyProtector    # includes the recovery password ID
```

**Retrieval, in order of preference:**
1. **Entra admin center** → Devices → [device] → BitLocker keys
2. **Intune** → Devices → [device] → Recovery keys
3. **ADUC** → computer object → BitLocker Recovery tab (on-prem escrow, requires the AD BitLocker feature)
4. The user's own Microsoft account, for personal devices — `account.microsoft.com/devices/recoverykey`

**🛑 Process, every time:**
- **Verify the requester's identity** through an out-of-band channel
- Confirm device ownership
- Retrieve the key **only through the approved admin process**
- **Document why the key was accessed** — this is an auditable event
- Confirm the device boots successfully
- Consider rotating the key afterward


---

## 11 — MICROSOFT 365 ADMINISTRATION `[M365]`

### `[M365-00]` Admin portals

| Area | Portal |
|---|---|
| Microsoft 365 Admin Center | `https://admin.microsoft.com` |
| Microsoft Entra Admin Center | `https://entra.microsoft.com` |
| Exchange Admin Center | `https://admin.exchange.microsoft.com` |
| Intune Admin Center | `https://intune.microsoft.com` |
| Azure Portal | `https://portal.azure.com` |
| Teams Admin Center | `https://admin.teams.microsoft.com` |
| SharePoint Admin Center | `https://admin.microsoft.com/sharepoint` |
| Microsoft 365 Defender | `https://security.microsoft.com` |
| Microsoft Purview compliance | `https://purview.microsoft.com` |
| Company Portal (user-facing) | `https://portal.manage.microsoft.com` |
| Service health / message center | `https://admin.microsoft.com/Adminportal/Home#/servicehealth` |

### `[M365-01]` Microsoft Graph PowerShell — the current standard

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "User.Read.All","Group.Read.All","Directory.Read.All"
Get-MgContext                                     # what am I connected as, with what scopes?
Disconnect-MgGraph

# Discovery — which cmdlet and which permission do I need?
Find-MgGraphCommand -Command Get-MgUser
Find-MgGraphCommand -Command Get-MgUser | Select-Object -First 1 -ExpandProperty Permissions
Find-MgGraphCommand -Uri "/users/{id}" -Method GET

# Users
Get-MgUser -All
Get-MgUser -UserId user@contoso.com
Get-MgUser -Filter "displayName startswith 'John'"
Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled,OnPremisesSyncEnabled |
    Select-Object DisplayName, UserPrincipalName, AccountEnabled, OnPremisesSyncEnabled

# Groups and membership
Get-MgGroup -Filter "displayName eq 'GG-Sales'"
Get-MgGroupMember -GroupId <id> -All

# Licensing
Get-MgSubscribedSku | Select-Object SkuPartNumber, ConsumedUnits, @{n='Enabled';e={$_.PrepaidUnits.Enabled}}
Get-MgUserLicenseDetail -UserId user@contoso.com

# Security actions
Revoke-MgUserSignInSession -UserId user@contoso.com     # invalidate all refresh tokens
Update-MgUser -UserId user@contoso.com -AccountEnabled:$false
```

**⚠ `Connect-MgGraph` scopes are least-privilege and additive.** If a cmdlet returns "Insufficient privileges," you almost certainly connected without the scope it needs. Reconnect with the scope that `Find-MgGraphCommand` reported.

**⚠ Graph cmdlets default to a page of results.** Use `-All` when you want the whole set, or you will silently analyze the first 100 users and draw a wrong conclusion.

**🔄 `MSOnline` and `AzureAD` modules are retired.** Any guide showing `Get-MsolUser`, `Set-MsolDirSyncEnabled`, or `Get-AzureADUser` is out of date and will fail.

### `[M365-02]` Exchange Online PowerShell

```powershell
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName admin@contoso.com
# ... work ...
Disconnect-ExchangeOnline

# Mailboxes
Get-Mailbox user@contoso.com | Format-List
Get-Mailbox -ResultSize Unlimited | Select-Object DisplayName, PrimarySmtpAddress, RecipientTypeDetails
Get-MailboxStatistics user@contoso.com | Select-Object DisplayName, TotalItemSize, ItemCount, LastLogonTime

# Permissions and delegation
Get-MailboxPermission user@contoso.com | Where-Object {$_.User -notlike "NT AUTHORITY\*"}
Add-MailboxPermission -Identity user@contoso.com -User manager@contoso.com -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity user@contoso.com -Trustee manager@contoso.com -AccessRights SendAs

# Forwarding and rules — check these during any compromise investigation
Get-Mailbox user@contoso.com | Select-Object ForwardingAddress, ForwardingSmtpAddress, DeliverToMailboxAndForward
Get-InboxRule -Mailbox user@contoso.com | Select-Object Name, Enabled, ForwardTo, RedirectTo, DeleteMessage

# Offboarding
Set-Mailbox user@contoso.com -Type Shared              # convert to shared (frees the license)
Set-Mailbox user@contoso.com -LitigationHoldEnabled $true

# Distribution groups
Get-DistributionGroup
Get-DistributionGroupMember -Identity "GroupName"

# Mail flow
Get-MessageTrace -SenderAddress a@x.com -StartDate (Get-Date).AddDays(-2) -EndDate (Get-Date)
Get-MessageTraceDetail -MessageTraceId <id> -RecipientAddress b@y.com
```

**⚠ A shared mailbox under 50 GB does not need a license — but it does if you put it on litigation hold, or if it exceeds 50 GB.** Converting to shared to save a license and then applying a hold quietly re-creates the licensing requirement.

### `[M365-03]` SharePoint Online / OneDrive PowerShell

```powershell
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser
Connect-SPOService -Url https://contoso-admin.sharepoint.com

Get-SPOSite -Limit All | Select-Object Url, Owner, StorageUsageCurrent, LastContentModifiedDate
Get-SPOSite | ForEach-Object { Get-SPOSiteGroup -Site $_.Url } | Format-Table
Get-SPOSite | ForEach-Object { Get-SPOUser -Site $_.Url }

# Grant site collection admin — e.g. to recover a departed user's OneDrive
$tenant = "contoso"; $site = "contosotest"; $user = "manager"
Set-SPOUser -Site "https://$tenant.sharepoint.com/sites/$site" `
    -LoginName "$user@$tenant.com" -IsSiteCollectionAdmin $true

# A user's OneDrive URL follows a predictable pattern:
# https://contoso-my.sharepoint.com/personal/jdoe_contoso_com
Get-SPOSite -IncludePersonalSite $true -Limit All -Filter "Url -like '-my.sharepoint.com/personal/'"
```

**Permission model notes:**
- SharePoint permissions **inherit from parent objects by default**.
- Assigning unique permissions **stops inheritance** for that object — and it does not resume.
- Use built-in groups and default permission levels where possible. Custom permission levels are the thing nobody documents and everybody later has to reverse-engineer.

**OneDrive sync troubleshooting checklist:**
- Confirm license, and that the user can sign in
- Confirm file path length and characters are valid (`" * : < > ? / \ |` and paths over ~400 chars fail)
- Confirm available local disk space
- Check OneDrive client status (icon → Settings → Account)
- Restart the sync client; if needed, **Unlink this PC** and re-link
- Confirm the same file is reachable via the web — this separates a sync problem from a permission problem
- **Escalate rather than guess if data loss or a sync conflict cannot be resolved safely**

### `[M365-04]` New user provisioning checklist `[SOP-ONBOARD-M365]`

- [ ] Create the user account (on-prem if hybrid — **let it sync**, don't create it twice)
- [ ] Add to the correct `GG-` role group — **this is the only membership step if group licensing is wired**
- [ ] Confirm license landed (via group, not direct)
- [ ] Confirm mailbox provisioned
- [ ] Configure/confirm MFA registration requirement
- [ ] Verify Teams access
- [ ] Verify OneDrive provisioning (it provisions on first access — have them open it once)
- [ ] Verify SharePoint site access
- [ ] Confirm the user can sign in
- [ ] Document assigned license, groups, and workstation asset tag in the ticket

### `[M365-05]` Licensing notes

- Assign or unassign from the Microsoft 365 admin center via the **Active users** page or the **Licenses** page.
- Required admin roles: **License Administrator** or **User Administrator**.
- **Prefer group-based licensing** — see `[HYB-LIC]`. Per-user assignment does not scale and drifts silently; you discover the gaps during an audit or when someone cannot sign in.
- Group-based licensing requires **Entra ID P1** (included in Business Premium and E3).
- Check **Licenses → Errors & Issues** for group licensing failures — they surface there and nowhere else.

### `[M365-06]` Entra ID core concepts

| Concept | Meaning |
|---|---|
| **Authentication (AuthN)** | Proves **who the user is**. Happens first. |
| **Authorization (AuthZ)** | Determines **what they may access**. Cannot happen until AuthN succeeds. |
| Users | Cloud identities in the tenant (or synced from on-prem) |
| Groups | Collections used for access assignment and licensing |
| Roles | Administrative privileges **over the directory** |
| Devices | Registered, joined, or hybrid-joined endpoints |
| MFA | Additional verification from a **different factor category** |
| Conditional Access | **If/then** policy engine sitting between successful authentication and actual access |
| External Identities | Guest (B2B) or customer identity scenarios |

**MFA factor categories — a password plus a security question is NOT MFA** (both are "something you know"):

| Category | Examples |
|---|---|
| Something you **know** | Password, PIN, security question |
| Something you **have** | Phone with authenticator app, hardware token, smart card |
| Something you **are** | Fingerprint, facial recognition |

**Passwordless options in Entra ID — exactly three:** Windows Hello for Business · Microsoft Authenticator app · FIDO2 security keys.

### `[M365-07]` Sign-in troubleshooting — cloud

1. Confirm the user exists and the UPN is what you think it is
2. Confirm sign-in is not blocked (`AccountEnabled`)
3. Confirm password status; check for a recent forced reset
4. Confirm MFA registration state and whether prompts are reaching the user's device
5. **Confirm Conditional Access policy impact** — the most common cause of "it works at the office but not at home"
6. Confirm license assignment (an unlicensed user can sign in but reaches nothing)
7. Confirm device compliance requirements if access is blocked by a compliant-device policy
8. **Read the sign-in logs.** Entra admin center → Users → [user] → Sign-in logs. The failure reason and the CA policy that fired are both listed there. This is the single most under-used diagnostic in cloud identity.

### `[M365-08]` Which admin center — task-to-portal decision table

`[M365-00]` lists the portals. This table answers the more useful question: **given a task, where do I go?** Most "I can't find the setting" tickets are this table, not a missing permission.

| Task | Portal |
|---|---|
| Create a user, assign a license, reset a password | **Microsoft 365 admin center** |
| Add or verify a custom domain; tenant-wide org settings | **Microsoft 365 admin center** |
| Service health, Message Center, usage reports | **Microsoft 365 admin center** |
| Copilot licenses, agents, Copilot billing and usage | **Microsoft 365 admin center** → Copilot (`[AI-09]`) |
| Mailboxes (user/shared/resource), distribution groups, mail flow rules, accepted domains, litigation hold | **Exchange admin center** |
| Sites, sharing policy, storage limits, **OneDrive settings**, DAG reports, RAC/RCD | **SharePoint admin center** |
| Teams, channels, meeting/messaging/app policies, call quality | **Teams admin center** |
| Conditional Access, **sign-in logs**, PIM, Identity Protection, Identity Secure Score, app registrations, enterprise apps | **Microsoft Entra admin center** |
| Sensitivity labels, DLP, retention, IRM, Communication Compliance, eDiscovery, **unified audit log search**, DSPM for AI | **Microsoft Purview portal** (§26) |
| Incidents, alerts, Threat Explorer, attack simulation, **Microsoft Secure Score** | **Microsoft Defender portal** |
| Power Platform environments, environment roles, agent capacity, connector DLP | **Power Platform admin center** — `admin.powerplatform.microsoft.com` |

**⚠ TRAP — three portal locations people reliably get wrong:**

1. **OneDrive settings are in the SharePoint admin center**, not the Microsoft 365 admin center.
2. **Conditional Access is in Entra**, not the Microsoft 365 admin center.
3. **Sign-in logs are in Entra. The unified audit log is in Purview.** Two different logs answering two different questions — see `[M365-18]`.

---

### `[M365-09]` Exchange recipient objects — pick the right one

Choosing the wrong recipient object is cheap to do and expensive to unwind, because mail history and permissions do not migrate cleanly between types.

| Object | What it is | License? | Use it when |
|---|---|---|---|
| **User mailbox** | An individual's mailbox, auto-provisioned when an Exchange Online license is assigned | Yes | Each person needs their own email |
| **Shared mailbox** | One mailbox several people open from their own Outlook; replies can go out as the shared address | **No** — until it exceeds 50 GB, is placed on hold, or someone signs into it directly | `support@`, `info@`, `billing@` |
| **Resource mailbox — Room** | Represents a physical room; can auto-accept or auto-decline | No | Booking a conference room from Outlook |
| **Resource mailbox — Equipment** | Represents a bookable non-room asset | No | Projectors, vehicles, loaner laptops |
| **Distribution group** | Email distribution only. **Cannot be used to assign permissions.** | No | All-staff announcements, mailing lists |
| **Mail-enabled security group** | Assigns permissions **and** receives mail | No | A team needs share access *and* a group address |
| **Dynamic distribution group** | Membership calculated at send time from recipient attributes | No | "Everyone whose Department is Sales, always current" |

**🛑 A shared mailbox that gets a litigation hold needs a license.** This is `[M365-02]`'s warning restated because it is the single most common licensing surprise: converting a departed user's mailbox to shared to free the seat, then applying a hold for legal, quietly re-creates the licensing requirement. Budget for it at offboarding time — `[SOP-02]`.

**⚠ Distribution group vs mail-enabled security group vs Microsoft 365 group.** Distribution = mail only, no permissions. Mail-enabled security = mail **and** permissions, no shared workspace. Microsoft 365 group = shared workspace (mailbox, calendar, SharePoint site, Planner, optional Team). See `[M365-10]`.

---

### `[M365-10]` Entra and Microsoft 365 group types — the security-object decision table

This is the cloud equivalent of `[AD-AGDLP]`, and it is the table to check before creating anything.

| Group type | Assign permissions? | Shared resources? | What it is for |
|---|---|---|---|
| **Security group** | **Yes** | No | Resource access; targeting Conditional Access, Intune policies, and licensing |
| **Microsoft 365 group** | Yes, to its own resources | **Yes** — shared mailbox, calendar, SharePoint site, Planner, optional Team | Team or project collaboration |
| **Mail-enabled security group** | **Yes** | Receives mail; **no** shared workspace | Permissions *and* a group email address |
| **Distribution group** | **No** | Mail distribution only | Announcements, mailing lists |
| **Dynamic group** | Depends on the underlying type | Depends | Membership calculated automatically from user attributes |

**Dynamic groups** populate from attributes (`department -eq "Sales"`, `city`, `jobTitle`). Members are added and removed automatically as attributes change, and **you cannot manually add or remove a member**. Requires **Entra ID P1**.

**WHY this matters operationally:** a dynamic group is only as good as the attribute hygiene behind it. If HR does not maintain `department`, a dynamic licensing group silently under- or over-licenses and nobody notices until an audit. **Do not build dynamic groups on attributes nobody owns.**

**⚠ Every Team is backed by a Microsoft 365 group**, which is why creating a Team also provisions a SharePoint site, a group mailbox, and a calendar. Deleting the group deletes all of it. This is the mechanism behind "we deleted a Team and lost the files."

---

### `[M365-11]` SharePoint objects, roles, and permission inheritance

**Content hierarchy — know the order:** **Site → Document library (or List) → Folder → File/Item**

| Object | What it is | Notes |
|---|---|---|
| **Team site** | Collaboration site connected to a **Microsoft 365 group**; provisioned with every Team | Membership managed through the group |
| **Communication site** | Broadcast site for a wide audience. **Not** group-connected | Permissions managed with SharePoint groups directly |
| **Document library** | File container: versioning, metadata columns, content types, co-authoring | The unit most permission and DLP scenarios target |
| **List** | Structured rows and columns for non-file data | Extended with Power Automate / Power Apps |
| **Folder** | Organization within a library | Can carry unique permissions if inheritance is broken |

**Site permission levels — exactly three defaults:**

| Role | Permission level | Can do |
|---|---|---|
| **Visitor** | Read | View and download. Change nothing. |
| **Member** | Edit / Contribute | Add, edit, delete content |
| **Owner** | Full Control | Everything, including permissions and site settings |

**🛑 Broken permission inheritance is the number-one cause of permission sprawl.** A library inherits from its site, a folder from its library, a file from its folder. Breaking inheritance at any level creates a permission set nobody tracks and nothing reports on by default. It does not resume on its own — this is the same failure mode as `[FILE-02]` on NTFS, and it is what makes an environment unsafe for Copilot (`[AI-03]`).

**⚠ SharePoint Administrator ≠ site owner.** SharePoint Administrator is a tenant-level Entra role governing all sites, sharing policy, and storage. Site owner is a per-site permission level. "Change sharing settings for the organization" is the role. "Add a colleague to this one site" is the owner.

**Teams channel types — where the files actually live:**

| Channel type | Who sees it | File location |
|---|---|---|
| **Standard** | Every team member | A folder in the team's SharePoint site |
| **Private** | Only the subset added to the channel | **Its own separate SharePoint site** |
| **Shared** | Members plus people from other teams or tenants, without joining the parent team | **Its own separate SharePoint site** |

**WHY this matters:** private and shared channels each create a **separate site collection**. Any site-scoped control — a retention policy, a DAG report, a sensitivity label, Restricted Content Discovery — must account for them, or you will govern the parent team and leave its private channels wide open. A tenant with 200 Teams may have 500+ site collections.

---

### `[M365-12]` Teams policies

Teams behavior is governed by **policies** created in the Teams admin center and assigned to users individually, in bulk, via **policy packages**, or by **group assignment**.

| Policy | Governs |
|---|---|
| **Meeting policy** | Recording, **transcription**, lobby behavior, anonymous join, breakout rooms |
| **Messaging policy** | Chat features, message deletion, GIFs, external chat |
| **App permission / app setup policy** | Which Microsoft, third-party, and custom apps are allowed and pinned |
| **Calling, voice, live events policies** | Telephony and broadcast features |

**⚠ Copilot meeting recap depends on transcription.** If meeting transcription is disabled by policy, Copilot cannot produce a recap for that meeting, and the user experiences it as "Copilot is broken." It is the cleanest example of an AI capability gated by a non-AI setting — see `[AI-19]`.

**🔄 Office 365 Connectors in Teams have been retired in favor of Workflows (Power Automate).** Any runbook that configures a Teams connector for alerting needs rewriting against Workflows.

---

### `[M365-13]` Licensing mechanics — service plans, usage location, group licensing limits

A license determines **which services a user may consume**. Roles and permissions determine **what they may do inside those services**. Both must line up before a user sees a feature. **A license is not a permission.**

**Service plans.** A license is a *bundle of service plans*, and an admin can disable individual service plans per user. This is the mechanism behind almost every "the user is licensed but the feature isn't there" ticket — check the service plans inside the license before you check anything else.

| Tier | What it unlocks that changes your design |
|---|---|
| **Business Basic / Standard / Premium** | **Hard cap of 300 seats.** Premium adds Intune, Entra ID P1, Defender for Business |
| **Microsoft 365 / Office 365 E3** | No seat cap. Core Purview (retention, sensitivity labels, DLP for Exchange/SPO/OneDrive/Teams), Entra ID P1 |
| **Microsoft 365 E5** | Adds **Entra ID P2** (PIM, Identity Protection), full Defender XDR, **Insider Risk Management**, **Communication Compliance**, endpoint DLP, advanced eDiscovery capability |
| **F1 / F3** | Frontline. Reduced app entitlements; F3 gets web/mobile Office and a smaller mailbox |
| **Microsoft 365 Copilot** (add-on) | Copilot in the apps, work-grounded Copilot Chat, Microsoft-built agents, **and SharePoint Advanced Management** — see `[AI-05]` |

**🛑 Usage location is mandatory.** A user with no usage location set **cannot be licensed**, because service availability varies by country/region. With group-based licensing, users without a usage location inherit the directory default. When a license assignment fails, the two causes are **usage location unset** and **no seats available** — in that order.

**Group-based licensing limits — the two that bite:**

| Limit | Reality |
|---|---|
| **Nested groups** | **Not supported.** License a group that contains groups and only **first-level user members** get licensed. The nested members get nothing and no error is raised. |
| **20 groups** | You can assign licenses to a maximum of **20 groups at a time** — a batch-operation limit in the admin center, **not** a cap on how many groups in the tenant may hold licenses. The reprocess operation likewise handles 20 users at a time. |

**⚠ The nested-group limitation is the one that causes outages.** A tidy-looking `GG-AllStaff` containing `GG-Sales`, `GG-Finance`, and `GG-Ops` licenses **nobody**, because none of those groups' members are first-level members of `GG-AllStaff`. License the leaf groups. See `[HYB-LIC]`.

**✅ VERIFY:** Microsoft 365 admin center → **Licenses → Errors & Issues**. Group licensing failures surface there and nowhere else — not in the user blade, not in a notification.

---

### `[M365-14]` Conditional Access — anatomy, safe rollout, and the two things that lock you out

Conditional Access is the **if/then policy engine** that sits between successful authentication and actual access (`[SECF-08]`, `[AZ-RBAC-VS-ENTRA]`). It evaluates signals in real time and decides: grant, grant with requirements, or block.

**Anatomy — assignments, then controls:**

| Part | Element | Examples |
|---|---|---|
| **Assignments** | Users and groups | Include Finance; **exclude break-glass accounts** |
| | Target resources | Cloud apps, user actions, authentication context |
| | Network | Named locations, trusted IPs, countries/regions |
| | Conditions | Sign-in risk, user risk, device platform, client app, device state, insider risk |
| **Access controls** | **Grant** | Block · require MFA · require compliant device · require Entra hybrid joined device · require approved client app · require app protection policy · require Terms of Use |
| | **Session** | Sign-in frequency · persistent browser session · app-enforced restrictions · Conditional Access App Control |

**The baseline policy set worth recognizing instantly:** require MFA for admins · **block legacy authentication** · require compliant or hybrid-joined device for SharePoint and Exchange · require MFA or block on high sign-in/user risk · restrict guests to named apps · session controls (browser-only, no download) on unmanaged devices.

**🛑 Security defaults and Conditional Access are mutually exclusive.** Security defaults is a free, all-or-nothing baseline for small tenants. **To use Conditional Access at all you must turn security defaults off.** Tenants cannot run both. Walking into an inherited tenant and finding neither one on is a finding — record it in `[ASSESS-02]`.

**Two safe-rollout tools, and they are not the same tool:**

| Tool | What it does | Use it for |
|---|---|---|
| **Report-only mode** | Evaluates the policy against **every real sign-in** and logs what *would* have happened, without enforcing | **Deployment.** Leave a new policy in report-only for a full business cycle before enforcing |
| **What If** | Simulates **one hypothetical sign-in** on demand — chosen user, app, device, location — and reports which policies apply | **Troubleshooting.** Reproducing a block you cannot reproduce live |

**🛑 Break-glass accounts.** Two cloud-only accounts on the `.onmicrosoft.com` domain, **excluded from every Conditional Access policy**, secured with hardware keys, alerted on. This is already stated in `[BUILD-P?]` and `[APX-B]`; it is repeated here because CA is the specific thing that locks you out. **Create them before the first policy, not after.**

**✅ VERIFY a CA change:** Entra admin center → Users → [user] → **Sign-in logs** → open a sign-in → **Conditional Access** tab. It names every policy evaluated and its result. This is the single most under-used diagnostic in cloud identity — `[M365-07]`.

---

### `[M365-15]` Privileged Identity Management — eliminating standing access

PIM converts **standing** privileged access into **eligible** access that must be activated. It is the JIT/JEA half of Zero Trust's least-privilege principle.

| Capability | What it does |
|---|---|
| **Eligible vs active** | *Eligible* = can activate when needed. *Active* = holds it now. PIM's entire purpose is converting active into eligible |
| **Time-bound activation** | The role deactivates automatically — no manual cleanup, no forgotten elevation |
| **MFA and justification on activation** | Prove identity and record a business reason for every elevation |
| **Approval workflow** | Route activation requests to designated approvers |
| **Access reviews** | Periodic recertification of who should remain eligible |
| **Audit and alerting** | Every request, approval, and activation logged; alert on high-privilege activation |

**License: Entra ID P2** (included in Microsoft 365 E5). If a client on E3 wants just-in-time elevation, the honest answer is that it requires a license upgrade — there is no P1 workaround.

**WHY it matters more than it looks:** PIM reduces the **time window** during which an account holds privilege. A compromised admin credential is only useful while the role is active. The trigger phrases are "reduce standing access," "just-in-time," "temporary elevation," "the contractor needs Exchange admin for a two-hour maintenance window."

**⚠ PIM is not Conditional Access.** PIM governs *whether a role is currently activated*. CA governs *whether this sign-in is allowed at all*. They stack; they do not substitute.

---

### `[M365-16]` App registrations vs enterprise applications

These two objects confuse nearly everyone, and the distinction is the whole question.

| | **App registration** | **Enterprise application** |
|---|---|---|
| What it is | The **application object** — the global definition: identity, redirect URIs, supported account types, required API permissions, credentials | The **service principal** — the local instance of an app in *your* tenant |
| Think of it as | The blueprint / the class | The installed instance / the object |
| Lives where | In the tenant that **owns** the app | In **every tenant** that uses the app |
| You create one when | Your organization is **building** an app that authenticates to Microsoft 365 | You **add** an app — Microsoft, third-party SaaS, or your own — to your tenant |
| You configure there | Client secrets and certificates, API permissions, redirect URIs, token settings | **SSO configuration**, user/group assignment, provisioning, CA targeting, **sign-in activity** |
| Entra path | Identity → Applications → App registrations | Identity → Applications → Enterprise applications |

**Credentials:** an app proves itself with a **client secret** (a string, with an expiry) or a **certificate** (preferred, stronger). **🛑 Expired client secrets are a classic cause of "the integration suddenly stopped working" with no other symptom.** Put secret expiry dates on the same calendar as certificate and license expiry (`[SOP-06]`).

**Consent:** apps request **delegated permissions** (acting as the signed-in user) or **application permissions** (acting as themselves, no user present). **Admin consent** is required for high-privilege scopes and for all application permissions.

**🛑 Restricting user consent is a standard hardening step and stops illicit consent grant attacks — which MFA does not stop.** See `[SECF-12]`. Review what users have already consented to when you inherit a tenant: Entra → Enterprise applications → Consent and permissions. This belongs in `[ASSESS-02]`.

---

### `[M365-17]` Three scores, three scopes — do not mix them up

| Score | Measures | Lives in |
|---|---|---|
| **Identity Secure Score** | **Identity** posture only — MFA coverage, legacy auth, stale accounts, privileged role protection | **Entra admin center** |
| **Microsoft Secure Score** | **Overall security** posture across identity, devices, apps, and data | **Defender portal** |
| **Compliance Score** | **Regulatory** posture against standards (GDPR, HIPAA, ISO 27001) | **Purview → Compliance Manager** (`[PURV-10]`) |

**How to read any of them:** points earned against points available, with prioritized **improvement actions**, each worth a defined number of points, and a status of **Completed / Planned / Resolved via third party / Risk accepted**. That last pair matters — it lets you record a deliberate decision without distorting the trend.

**⚠ These are relative, directional measures, not absolute security ratings.** The signal is the **trend after remediation**, not the number. Do not chase 100%, and be skeptical of anyone who reports the raw number to a client as if it were a grade. **🛑 Microsoft Secure Score is not scored out of 100** — the maximum varies with your licensed products. Any reference quoting "45 out of 100" is wrong about the scale.

---

### `[M365-18]` The unified audit log — who did what to which content

Two different logs answer two different questions, and getting them backwards wastes an hour every time.

| Question | Log | Where |
|---|---|---|
| Who signed in, from where, was it blocked, which CA policy fired? | **Sign-in logs** | **Entra admin center** |
| Who accessed, changed, shared, or deleted what content? | **Unified audit log** | **Microsoft Purview portal → Audit → Search** |

| Aspect | Detail |
|---|---|
| **Coverage** | Exchange, SharePoint, OneDrive, Teams, Entra ID, Purview, **and Copilot interactions** |
| **Permissions** | **Audit Logs** role (search and configure) or **View-Only Audit Logs**, granted through a Purview role group |
| **Filters** | Date range, activity type, user, file/folder/site, IP address, workload |
| **Retention — Audit (Standard)** | **180 days** |
| **Retention — Audit (Premium)** | **1 year**, extendable to **10 years** with an add-on |
| **Export** | CSV, or stream to a SIEM |

**Typical investigations:** who downloaded a file (`FileDownloaded`, `FileAccessed`) · who was assigned an admin role · who changed a mailbox permission or Teams policy · **what Copilot prompts and responses occurred**.

**🛑 Audit retention is a hard deadline, not a preference.** Under Audit (Standard), evidence older than 180 days is gone. If an investigation might reach back further — an insider matter, a long-running fraud — **export before the window closes**, or the question becomes unanswerable. This is `[DOCTRINE]`-level: the log you did not export is the log you do not have.

**✅ VERIFY audit is on:** search for a known-recent activity (your own sign-in or file access from yesterday). An empty result set with a valid query means auditing was disabled or the role is wrong, not that nothing happened.

---

### `[M365-19]` Authentication methods, ranked, and the three hybrid models

**The three MFA factor categories** are already in `[M365-06]`. This is the strength ranking, which is what you actually need when writing a Conditional Access requirement:

| Method | What it is | Phishing-resistant? |
|---|---|---|
| **FIDO2 security key** | Physical USB/NFC key, public-key crypto, no shared secret transmitted | **Yes** |
| **Windows Hello for Business** | Biometric or PIN bound to the device by asymmetric keys | **Yes** |
| **Certificate-based authentication** | Smart card or device certificate, usually with a PIN | **Yes** |
| **Authenticator — passwordless / push with number matching** | Approve with biometric or PIN on a registered phone | Strong, not fully phishing-resistant |
| **Authenticator — TOTP code** | Time-based one-time passcode | No |
| **SMS / voice call** | Code by text or call | **No — weakest. Microsoft actively discourages it** |

**⚠ Number matching exists because plain push approval was being defeated by MFA fatigue** — spam the user with prompts until one is approved by reflex. If a tenant still uses plain push, that is a finding.

**🛑 Blocking legacy authentication is the highest-value single Conditional Access action.** Legacy auth means basic username/password protocols — **POP3, IMAP, SMTP AUTH** — that cannot perform MFA. They are the answer to "our accounts are being password-sprayed despite MFA," because legacy auth bypasses it entirely.

**Hybrid authentication — three methods, one default:**

| Method | Where the password is validated | Choose it when |
|---|---|---|
| **Password hash synchronization (PHS)** | In the cloud, against a synced hash | **Default recommendation.** Simplest, most resilient, and the only one that supports leaked-credential detection |
| **Pass-through authentication (PTA)** | On-premises, in real time, via a lightweight agent | Policy forbids password hashes in the cloud, or real-time on-prem policy enforcement is required |
| **Federation (AD FS)** | At an external identity provider | Heavily regulated environments needing full control of the sign-in experience or third-party MFA. **Most infrastructure to maintain, most to break** |

Both PHS and PTA are configured through **Entra Connect Sync** or **Entra Cloud Sync** — `[HYB-SYNC]`, and note correction #1 in `[APX-C]` about what those two products actually are.

**WHY PHS is the default:** if the on-premises environment burns down, PHS users can still authenticate. PTA and federation both keep an on-premises dependency in the critical path of every cloud sign-in. That is an availability decision, not a security one, and it is usually the deciding argument.

---

### `[M365-20]` Defender XDR and the threat-protection features worth naming

Defender XDR correlates signals across email, endpoints, identities, and cloud apps into unified **incidents**, so an analyst sees one attack rather than four disconnected alerts.

| Component | Protects | Signature detections |
|---|---|---|
| **Defender for Office 365** | Email and collaboration — Exchange, Teams, SharePoint, OneDrive | Phishing, BEC, malicious URLs and attachments |
| **Defender for Endpoint** | Devices | EDR, next-gen AV, attack surface reduction, automated investigation, **device isolation** |
| **Defender for Identity** | **On-premises Active Directory** — sensor-based on domain controllers, AD CS, AD FS, Entra Connect servers | Pass-the-Hash, Golden Ticket, reconnaissance, lateral movement |
| **Defender for Cloud Apps** | SaaS applications | **Shadow IT discovery**, app governance, session controls |

**🛑 CORRECTION — Defender for Identity does not monitor Entra ID traffic.** It is sensor-based and centered on **on-premises AD**. Cloud identity risk — risky sign-ins, leaked credentials, impossible travel — is **Microsoft Entra ID Protection**, a different product. Reference material stating otherwise is wrong; see `[APX-C]` #29.

- "Golden Ticket," "Pass-the-Hash," "compromised domain controller" → **Defender for Identity** (`[SECF-10]`, `[SYSF-05]`)
- "Impossible travel," "leaked credentials," "risky sign-in" → **Entra ID Protection**

**⚠ Defender for Cloud Apps ≠ Defender for Cloud.** *Cloud Apps* = SaaS visibility and shadow IT. *Defender for Cloud* = Azure/multicloud infrastructure posture. One word apart, completely different products.

**Email threat protection — the four features you will be asked about by name:**

| Feature | What it does | The distinguishing detail |
|---|---|---|
| **Safe Links** | Rewrites URLs and scans them **at time of click** | Catches a link weaponized *after* delivery |
| **Safe Attachments** | Detonates attachments in a sandbox before delivery | Delays delivery slightly; that is the trade |
| **Zero-hour Auto Purge (ZAP)** | **Retroactively removes** already-delivered messages once a threat is identified | The only one that acts on mail already in mailboxes |
| **Spoof intelligence / impersonation protection** | Detects senders impersonating trusted domains and lookalike executives | The BEC control |

**⚠ ZAP is the retroactive one.** Delivered, later found malicious → ZAP. Safe at delivery, malicious at click → Safe Links. This distinction comes up in real incident response, not just on paper — `[SOP-10]`.

**Investigation tools:** **Threat Explorer** (Defender for Office 365 **Plan 2**) pivots by sender, subject, URL, or file hash and answers "who else got this and did anyone click?" **Real-time detections** is the Plan 1 equivalent with less depth. **Threat Analytics** supplies curated reports mapped to MITRE ATT&CK with exposure assessment.

**Positioning: Purview is not part of Defender XDR.** Defender does threat detection and response; Purview (§26) does data governance, compliance, and insider risk. They interoperate — DLP alerts route into Defender XDR and Sentinel — but they are separate product families with separate portals and separate role models.

---

## 12 — AZURE FUNDAMENTALS REFERENCE `[AZ]`

Principles only. Exam-specific material has been stripped.

### `[AZ-01]` Cloud service models and shared responsibility

| Layer | On-prem | IaaS | PaaS | SaaS |
|---|---|---|---|---|
| Information and data | C | C | C | **C** |
| Devices (mobile, PCs) | C | C | C | **C** |
| Accounts and identities | C | C | C | **C** |
| Identity and directory infrastructure | C | Shared | Shared | Shared |
| Applications | C | C | Shared | P |
| Network controls | C | C | Shared | P |
| **Operating system** | C | **C** | **P** | P |
| Physical hosts | C | P | P | P |
| Physical network | C | P | P | P |
| Physical datacenter | C | P | P | P |

**Always yours, in every model, forever:** information and data · devices · accounts and identities.
**Always the provider's, in every cloud model:** physical datacenter · physical network · physical hosts.
**Depends on the service type:** operating system · network controls · applications · identity and directory infrastructure.

**The cleanest discriminator between IaaS and PaaS: if you patch the OS, it is IaaS. If the provider patches it, it is PaaS or SaaS.**

| | IaaS | PaaS | SaaS |
|---|---|---|---|
| What you rent | Hardware in a cloud datacenter | A managed development and hosting environment | A finished application |
| You manage | OS install/config/patching, network config, storage config, applications | Your application and your data | Your data, identity/access settings, device posture |
| Control | Maximum | Moderate | Minimum |
| Operational overhead | Largest | Moderate | Lowest |
| Azure examples | Virtual Machines, VM Scale Sets, Virtual Network, Disk Storage | App Service, Functions, Container Instances, Container Apps, Azure SQL Database | Microsoft 365, Dynamics 365 |

**Transport analogy:** On-prem = you own the car. IaaS = you rent a car. PaaS = you take a taxi. SaaS = you ride the bus.

### `[AZ-02]` Deployment models

| Model | Definition | Signal phrases |
|---|---|---|
| **Public** | Built, owned, operated by a third-party provider; anyone can buy | "provider owns everything," "anyone can purchase" |
| **Private** | A cloud environment used by a single entity, on-prem or dedicated off-site | "single organization," "dedicated hardware," "regulatory mandate" |
| **Hybrid** | Public and private used together, interconnected | **"surge capacity," "cloud bursting"** |
| **Multicloud** | More than one public cloud provider | "Azure and AWS together" |

**Two services that exist for hybrid/multicloud:**
- **Azure Arc** — projects on-premises and other-cloud resources into Azure Resource Manager so Azure Policy, monitoring, and Defender for Cloud apply to them as if native. The answer to *"manage on-premises or other-cloud resources using Azure tools."*
- **Azure VMware Solution** — run existing VMware workloads natively in Azure without re-platforming.

### `[AZ-03]` Cost models — CapEx vs OpEx and pricing options

| | CapEx | OpEx |
|---|---|---|
| What | Large one-time purchase of a physical asset | Ongoing pay-as-consumed expense |
| Typical of | On-premises, private cloud | Public cloud |
| Cash flow | Money out first, depreciated over years | Money out as value is consumed |
| Risk | Forecast capacity years ahead; pay for peak even when idle | Cost tracks usage; risk shifts to governance and sprawl |

| Pricing model | Commitment | Best for | Trade-off |
|---|---|---|---|
| **Pay-as-you-go** | None | Unpredictable, spiky, short-lived, experimental | Highest unit price |
| **Reservations** | A specific resource (VM series + region) for 1 or 3 years | Steady-state workloads whose size and region you know | Large discount, locked to that resource shape |
| **Azure savings plan for compute** | A fixed **hourly spend** on eligible compute for 1 or 3 years | Steady total spend where the specific services may change | Smaller discount than reservations, more flexibility |
| **Spot VMs** | None, but Azure can **evict** you when it needs capacity | Fault-tolerant, interruptible, batch, dev/test | Deepest discount, zero availability guarantee |
| **Azure Hybrid Benefit** | Requires existing Windows Server / SQL Server licenses **with Software Assurance** | Migrating already-licensed Microsoft workloads | Not a discount you can buy — you must already own the licenses |

**⚠ "Consumption-based" does not mean "always cheapest."** A workload running continuously at a known size is usually cheaper on a reservation. The benefit of the consumption model is **aligning cost to usage and eliminating up-front capital**, not lowest price in all cases.

**Other cost factors:** resource type and settings · region (prices differ by geography) · **egress** (outbound data transfer out of Azure is billed; **ingress is generally free**) · subscription type · Azure Marketplace third-party software billed on top.

**Cost optimization levers:**

| If the workload is… | Use |
|---|---|
| Predictable, long-running, known VM family and region | Reservations |
| Steady total spend but changing services/families | Savings plan |
| Fault-tolerant and interruptible | Spot |
| Already licensed Windows Server / SQL Server | Azure Hybrid Benefit |
| Variable in demand | Autoscaling; deallocate what is not in use |
| Non-production, idle outside business hours | Shut down or deallocate on a schedule |

**Orphaned resources are the classic silent cost:** unattached managed disks, unassociated public IP addresses, idle non-production environments.

### `[AZ-04]` Architecture — physical and management hierarchy

**Physical:**

| Concept | Definition | Can you deploy to it? |
|---|---|---|
| **Datacenter** | A physical facility with its own power, cooling, networking | No — Azure abstracts it away |
| **Region** | A set of datacenters within a latency-defined perimeter | **Yes — this is what you choose** |
| **Geography** | A discrete market (country or group of countries) containing 2+ regions; exists for **data residency and compliance** | Indirectly, by choosing a region inside it |
| **Availability zone** | Physically separate datacenters within one region, with independent power/cooling/networking | Yes, for zonal services |
| **Region pair** | Two regions in the same geography, **at least 300 miles apart**, paired by Azure (you cannot choose or change the pair) | N/A — it's a relationship |
| **Sovereign region** | An **entirely separate instance** of Azure for strict regulatory environments — Azure Government (US), Azure operated by 21Vianet (China) | Requires a separate account |

**What region pairing buys you:** replication across a geography · **prioritized recovery** (one region of each pair is restored first in a major outage) · **sequential updates** (Azure never updates both halves of a pair simultaneously) · data residency within the geography.

**Blast radius — match the protection to the failure:**
- **Availability set** → rack-level failure and planned maintenance, **inside one datacenter**. Free.
- **Availability zone** → a whole **datacenter** failing, inside one region.
- **Region pair / geo-redundancy** → a whole **region** failing.

A minimum of **three** availability zones exist in every AZ-enabled region. Not all regions support them.

**Availability zone service categories:** **Zonal** = you pin it to a zone yourself (VMs, managed disks, IPs). **Zone-redundant** = Azure spreads it automatically (ZRS, Azure SQL Database). **Non-regional** = no region at all (Azure DNS, Microsoft Entra ID, Traffic Manager).

**Management hierarchy — governance flows downward, billing rolls upward:**

```
Management Groups     (nestable up to 6 levels, excluding root and subscription level)
  └─ Subscriptions    (billing boundary AND access-control boundary)
      └─ Resource Groups   (CANNOT be nested; cannot be renamed; deleting one deletes everything in it)
          └─ Resources     (each belongs to exactly ONE resource group; can be moved between them)
```

- Every Entra tenant has one top-level **Tenant Root Group**.
- A subscription is associated with exactly **one** Entra tenant; one tenant may hold many subscriptions.
- **A resource group has a location** (where its metadata lives), but the resources inside it can be in different regions. **It is not a geographic boundary.**
- Reasons to create multiple subscriptions: environment separation (dev/test/prod), team or project boundaries, and separate cost tracking with different spending limits.

### `[AZ-05]` Compute

| | Virtual Machines | Containers | Functions |
|---|---|---|---|
| What is virtualized | **The hardware** | **The operating system** | Nothing you see — code only |
| Do you manage the OS? | Yes | No | No |
| Service model | IaaS | PaaS | PaaS / serverless |
| Billing | While allocated, busy or idle | Compute consumed while running | **Only CPU time while running** |
| Choose when | Total OS control, custom software, custom hosting | Portable, fast, dense, microservices | Event/timer/message triggered, completes quickly |

**Resources required to create a VM:** region · VM size · OS image · storage disks (OS disk required, data disks optional) · virtual network + subnet · NIC · **private IP required, public IP optional** · network security group · availability option · admin credentials.

**Availability options:**

| Option | Protects against | Autoscales? |
|---|---|---|
| **VM Scale Sets** | Instance failure and, more importantly, **insufficient capacity under load** | **Yes — its defining feature** |
| **Availability sets** | A single planned maintenance event (**update domains**) or a single rack/power failure (**fault domains**). **Adds no cost.** | No — pure resilience |
| **Availability zones** | A whole datacenter failing | No, but scale sets can be zone-aware |

*Update domain = planned reboots. Fault domain = shared power and network.*

**Container services:** **ACI** = simplest way to run one container, no VMs to manage · **Container Apps** = same simplicity plus built-in load balancing and autoscaling · **AKS** = orchestration of a **fleet**. The word *orchestration* means AKS; for one or two containers, AKS is the over-engineered answer.

**Serverless** — four defining characteristics: no infrastructure management · event-driven execution · automatic elastic scaling **including scale to zero** · pay only for what executes. Azure Functions, Logic Apps, Container Apps, Event Grid.

**PaaS vs serverless:** both are managed. **The discriminator is idle cost.** An App Service web app is PaaS but it is *running* and billed with no traffic. A Function scales to zero and costs nothing when idle.

**Azure Virtual Desktop** — desktop and application virtualization. The distinguishing feature is **multi-session Windows**: several users share one Windows instance, more efficient than a VM per user. Answer for "many users, centralized management, BYOD."

**Application hosting decision:**

| Scenario | Answer |
|---|---|
| Full OS control, custom software, lift-and-shift an existing server | Azure Virtual Machines |
| Web app / REST API / mobile back end with minimal infra work, CI/CD from GitHub | Azure App Service |
| Microservices, portable, run a container image | ACI / Container Apps / AKS |
| Run code in response to an event, pay only when it runs | Azure Functions |
| Full Windows desktop from any device | Azure Virtual Desktop |

### `[AZ-06]` Networking

**Azure Virtual Network's seven capabilities:** isolation and segmentation · internet communications · communication between Azure resources · communication with on-premises · route network traffic · filter network traffic · connect virtual networks (peering).

**Subnets** are ranges carved from the VNet address space so you can apply different security and routing to different application tiers (web / app / database). Each subnet can have its own NSG and route table. Some services require a **dedicated subnet** — the VPN gateway is the classic example.

**Connecting to on-premises:**

| Method | Connects | Over the internet? | Use when |
|---|---|---|---|
| **Point-to-site (P2S)** | A single computer to the VNet | Yes, encrypted | Individual remote users or admins |
| **Site-to-site (S2S)** | An on-prem VPN device/gateway to the Azure VPN gateway | Yes, encrypted | A whole office needs persistent connectivity |
| **ExpressRoute** | A **dedicated private connection** | **No — never touches the public internet** | Greater bandwidth, consistent latency, or higher security than the internet allows |

**Traffic control:** **Route tables / UDRs** define how traffic is directed · **BGP** propagates on-prem routes into Azure · **NSGs** allow/block by source and destination IP, port, and protocol · **NVAs** are specialized VMs running a firewall or WAN optimizer.

**VNet peering** connects two Azure VNets directly, privately, **on the Microsoft backbone**, and can span regions. *(Both peering and ExpressRoute "never touch the internet" — the difference is what they connect: peering joins two Azure VNets; ExpressRoute joins on-prem to Azure.)*

**VPN Gateway:** deployed into a dedicated subnet · **one gateway per VNet**, but one gateway can connect to multiple locations · authentication is a **preshared key** · **route-based** is preferred over policy-based (resilient to topology changes, and required for VNet-to-VNet, P2S, multisite, and ExpressRoute coexistence) · default is **active/standby** with failover typically within a few seconds for planned maintenance and ~90 seconds for unplanned.

**Azure DNS** hosts zones (it does **not** register domain names) on an anycast network. **Alias record sets** point at an Azure resource and **update themselves automatically** if the underlying IP changes — the answer whenever a DNS record must track a changing Azure resource.

**Endpoints:** **public** = a public IP, reachable worldwide · **private** = a private IP from the VNet's address space, reachable only from inside the network.

### `[AZ-07]` Storage

**Two separate choices at account creation, frequently conflated:**

**1. Storage account type:**

| Type | Services | Use |
|---|---|---|
| **Standard general-purpose v2** | Blob (incl. Data Lake), Queue, Table, Files | **The default and recommended type for most scenarios** |
| Premium block blobs | Blob | High transaction rates, smaller objects, low latency |
| Premium file shares | Files only | Enterprise/high-performance; SMB and NFS |
| Premium page blobs | Page blobs | Specialized — notably unmanaged VM disks |

*Standard = HDD-backed, general purpose, cheapest. Premium = SSD, low latency, higher cost, narrower service support.*

**2. Redundancy option:**

| Option | Where copies live | Copies | Durability | Protects against |
|---|---|---|---|---|
| **LRS** | Three copies in **one datacenter**, synchronous | 3 | 11 nines | Drive, server, rack failure. **Not** a datacenter disaster. |
| **ZRS** | Three copies across **three availability zones** in the primary region, synchronous | 3 | 12 nines | Loss of an entire availability zone |
| **GRS** | LRS in primary + asynchronous to a **paired secondary region** stored as LRS | 6 | 16 nines | A complete regional outage |
| **GZRS** | ZRS in primary + asynchronous to the paired secondary as LRS | 6 | 16 nines | Both zone-level and region-level failure |

**Data is always replicated three times in the primary region.** There is no single-copy option.

**Read access to the secondary:** by default the secondary is **not readable** — it is a passive standby usable only after a failover. To read it while the primary is healthy you need **RA-GRS** or **RA-GZRS**. Plain GRS gives you durability, not readability.

**⚠ Data residency:** if data must not leave a country or region, **ZRS is correct and GRS/GZRS are wrong** — geo-redundancy moves a copy to another region.

**The five core storage services:**

| Service | Stores | The signal |
|---|---|---|
| **Blob Storage** | Massively scalable **object** store for unstructured data | Images, video, backups, logs, analytics data; accessed by application code over HTTP/HTTPS |
| **Azure Files** | Fully managed **file shares** | **SMB or NFS**, mountable with a drive letter, concurrently by cloud and on-prem. "Shared drive," "mapped network drive," "lift-and-shift a file server." |
| **Queue Storage** | **Messages** for asynchronous processing | "Decouple components," "buffer work." Max **64 KB** per message. Commonly paired with Functions. |
| **Disk Storage** | Block-level volumes **attached to a VM** | A VM's OS disk and data disks |
| **Table Storage** | NoSQL **structured, non-relational** data | "Key-value / key-attribute," "schemaless," "no joins needed" |

*Blob vs Files vs Disk is the most common mix-up. If the scenario mentions SMB or mapping a drive letter, it is **Files**, never Blob.*

**Blob access tiers:**

| Tier | For | Minimum duration | Retrieval |
|---|---|---|---|
| **Hot** | Frequently accessed | None | Immediate. Highest storage cost, lowest access cost. |
| **Cool** | Infrequent, stored ≥30 days | 30 days | Immediate |
| **Cold** | Infrequent, stored ≥90 days | 90 days | Immediate |
| **Archive** | Rarely accessed, ≥180 days, **flexible latency** | 180 days | **Offline — must be rehydrated, which takes hours.** Lowest storage cost, highest access cost. |

**⚠ "Flexible latency requirements" is doing a lot of work in the Archive definition.** Archive data is offline. If data must be available immediately, Archive is wrong no matter how rarely it is accessed.

**Moving and migrating data:**

| Tool | Category | The signal |
|---|---|---|
| **AzCopy** | Moving files | "Scriptable," "command line," "automate a transfer," "copy from S3" |
| **Azure Storage Explorer** | Moving files | "GUI," "drag and drop," "browse storage visually" |
| **Azure File Sync** | Moving files | "Keep the local Windows File Server but centralize the data in Azure," ongoing sync rather than a one-time move |
| **Azure Migrate** | Migration | "Assess our on-premises servers," "plan and track a datacenter migration" |
| **Azure Data Box** | Migration | **"Bandwidth is the constraint."** Physical device, max usable capacity **80 TB**, shipped by carrier. Also works in the **export** direction. |

*AzCopy vs Data Box is decided by one variable: bandwidth.*

### `[AZ-08]` Identity, access, and security

| Service | What it is | What it does NOT do |
|---|---|---|
| **Microsoft Entra ID** | Cloud identity and access management. Authentication (SSPR, MFA, banned password lists, smart lockout), SSO, application management, device management. | **Not a cloud version of AD DS.** No domain join, Group Policy, LDAP, or Kerberos/NTLM. |
| **Microsoft Entra Domain Services** | **Managed** domain services — domain join, Group Policy, LDAP, Kerberos/NTLM — without you deploying or patching DCs. Deploys **two** DCs as a replica set in your chosen region. | Not a full AD DS replacement in every scenario; you do not get Domain Admin over it. |
| **Microsoft Entra Connect Sync** | Synchronizes identities between on-prem AD and Entra ID | **Not an authentication service** — it is the sync engine that makes hybrid identity possible |

*If a scenario mentions legacy apps needing **LDAP, Kerberos, NTLM, Group Policy, or domain join**, the answer is **Entra Domain Services**, not Entra ID.*

**External identities:**

| Capability | In your directory? |
|---|---|
| **B2B collaboration** | **Yes** — represented as guest users |
| **B2B direct connect** | **No** — mutual two-way tenant trust; visible only within a shared Teams channel |
| **External ID for customers** | Managed in a separate customer-facing tenant |

**Conditional Access** is an **if/then policy engine** between successful authentication and actual access. Any scenario with an if/then shape about access — location, device, risk, client app — is Conditional Access, **not RBAC**. RBAC has no notion of location, device, or risk.

### `[AZ-RBAC-VS-ENTRA]` 🛑 Entra roles and Azure RBAC are two different systems

**Entra ID roles** (Global Administrator, Intune Administrator, User Administrator) govern **the directory** — users, groups, devices, tenant configuration.

**Azure RBAC roles** (Owner, Contributor, Reader) govern **Azure resources** — subscriptions, resource groups, VMs, storage accounts.

**They are deliberately separate**, so that directory administration and cloud spend can be delegated independently.

**The practical consequence:** a brand-new Global Administrator often cannot see a single Azure subscription, and it looks like a bug. **It is not.** Grant RBAC explicitly at subscription or resource-group scope. **Prefer Contributor over Owner for a working account** — Owner can also grant access to others, which is rarely needed day to day.

**Azure RBAC properties:**
- Applied at exactly four scopes — **management group, subscription, resource group, resource** — the same four levels as the management hierarchy
- **Permissions inherit downward**
- **Additive, allow-based.** Your effective permissions are the sum of your assignments. **Deny assignments take precedence over allow.**
- Enforced through **Azure Resource Manager**, which is why every management action is subject to it

**Zero Trust — exactly three principles:** **Verify explicitly** (authenticate and authorize on all available data points) · **Use least privilege access** (JIT/JEA, risk-based adaptive policies) · **Assume breach** (segment access, verify end-to-end encryption, use analytics for detection).

**Defense in depth — seven layers, outermost to innermost:** Physical · Identity and access · Perimeter (**DDoS lives here**) · Network (segmentation, NSGs) · Compute (VM hardening, patching, endpoint protection) · Application · **Data** (usually the ultimate target).

**Azure Key Vault** stores exactly three things: **secrets, keys, certificates.** If a scenario mentions a hard-coded password in a configuration file, the answer is Key Vault.

**Microsoft Defender for Cloud** (formerly Azure Security Center — the old name is retired) does three things: **continuously assess** (know your posture), **secure** (harden using the Microsoft Cloud Security Benchmark), **defend** (detect and resolve threats). Surfaces a **secure score**. **Azure Arc extends Defender plans to non-Azure and on-premises machines** — that is the mechanism that makes the hybrid claim real.

### `[AZ-09]` Governance and management tools

| Tool | Governs | The distinction |
|---|---|---|
| **Azure RBAC** | **Users** | "Only the network team may modify virtual networks" |
| **Azure Policy** | **Resource configuration** | "No VM may be created outside East US" / "no VM larger than size X" |
| **Resource locks** | **Existing resources** | Prevents deletion or change **even by an Owner** — overrides RBAC |
| **Microsoft Purview** | **Data** | Discovery, sensitive-data classification, end-to-end lineage |

**Azure Policy** lets you define individual policies and groups of them called **initiatives**. It evaluates resources, highlights non-compliant ones, and **can prevent non-compliant resources from being created.** Set at any hierarchy level; inherits downward.

**Resource locks — two types:**

| Lock | You can still | Blocked |
|---|---|---|
| **Delete** (CanNotDelete) | Read and modify | Deleting |
| **ReadOnly** | Read | Deleting **or updating** — stricter |

**Locks apply regardless of RBAC.** Even a subscription Owner cannot delete a resource under a Delete lock without removing the lock first. To modify a locked resource, remove the lock, act, re-apply.

**⚠ Tags are NOT inherited.** A resource does not automatically pick up its resource group's or subscription's tags. **To guarantee every resource carries a tag, use Azure Policy** — it can audit for missing tags or append/enforce them at creation. A practical starter tag set: `Environment`, `Owner`, `CostCenter`, `Workload`.

**Management tooling:**

| | Azure Cloud Shell | Azure CLI | Azure PowerShell |
|---|---|---|---|
| What | Browser-based shell | Cross-platform CLI | PowerShell modules |
| Syntax | Hosts either of the others | `az vm create` — **double dash, lowercase `az`** | `New-AzVM` — **Verb-Noun, `Az` prefix, single dash** |
| Sign-in | Already authenticated | `az login` | `Connect-AzAccount` |
| Note | **Requires an Azure Files share to persist files between sessions** | Runs in Bash, PowerShell, or CMD | |

**⚠ Azure CLI is not "Bash."** It is a cross-platform tool whose commands begin with `az`, and it runs in Bash, PowerShell, Windows Command Prompt, or Cloud Shell. Cloud Shell offers two **shell environments** (Bash and PowerShell) and you can run the CLI in either. **The distinction that matters is command syntax, not the host shell.**

Anatomy of the same task in both:
```bash
az group create --name Study-RG --location eastus
#  az          the executable — every Azure CLI command starts with this
#  group       the command group (resource groups). Others: vm, storage, network
#  create      the action. Others: list, show, delete, update
#  --name      named parameter, double dash
#  --location  the region the resource group's metadata lives in
```
```powershell
New-AzResourceGroup -Name Study-RG -Location eastus
#  New-             the verb. Others: Get-, Set-, Remove-, Start-, Stop-
#  AzResourceGroup  the noun. The Az prefix marks it as an Azure PowerShell cmdlet
#  -Name/-Location  parameters, single dash
```

Both call the Azure REST API, and both go through **Azure Resource Manager**.

**Azure Resource Manager (ARM)** is the management layer every request passes through — portal, CLI, PowerShell, SDKs, and REST API are all front ends onto it. Because every request funnels through one place you get consistent results, consistent access control, and consistent auditing regardless of tool.

**Infrastructure as Code:**

| | Imperative | Declarative |
|---|---|---|
| What you write | The steps, in order | The desired end state |
| Examples | Azure CLI / PowerShell scripts | **ARM templates (JSON)**, **Bicep** |
| Who handles ordering | You | ARM — it works out dependencies and parallelism |

*ARM template = JSON, verbose. Bicep = a simpler language that compiles to the same ARM template. Both declarative and idempotent.*

### `[AZ-10]` Monitoring — four tools, three questions

| Tool | Looks at | The question it answers |
|---|---|---|
| **Azure Advisor** | Your **resource configuration**, vs best practice | "Am I doing this the recommended way?" |
| **Azure Service Health** | **Azure's own** health | "Is the problem Microsoft's fault?" |
| **Azure Monitor** | **Telemetry** from your resources and apps | "What is actually happening inside my systems?" |

**Azure Advisor — five categories:** Reliability · Security · Performance · Operational Excellence · Cost.

**Service Health — three views, narrowing in scope:** **Azure Status** = the whole world · **Service Health** = my subscription's services and regions, including planned maintenance · **Resource Health** = this one resource.

**Azure Monitor components:** **Log Analytics** = where you write **KQL** queries against collected data · **Alerts** = an alert rule (the condition) plus an action group (who gets notified) · **Application Insights** = monitors a web application's request rates, response times, failure rates, dependency calls, page load times, and server performance counters.

*Log Analytics is where you query. Application Insights is what you instrument an app with. Both are parts of Azure Monitor, not competitors to it.*

### `[AZ-11]` Numbers worth knowing

| Number | What it is |
|---|---|
| 3 | Minimum availability zones in an AZ-enabled region · copies always held in the primary region · Zero Trust principles · passwordless options · Service Health views · ways to connect on-prem to Azure |
| 300 miles | Minimum distance between the two regions in a region pair |
| 6 | Levels management groups can be nested (excluding root and subscription level) · total copies held by GRS and GZRS |
| 0 | Levels a **resource group** can be nested — they cannot be nested at all |
| 1 | Resource groups a resource belongs to · VPN gateways per VNet · parents a management group or subscription has |
| 11 / 12 / 16 / 16 | Nines of durability: LRS / ZRS / GRS / GZRS |
| 30 / 90 / 180 days | Minimum storage duration: Cool / Cold / Archive. Hot has none. |
| 64 KB | Max size of an Azure Queue Storage message |
| 80 TB | Max usable capacity of an Azure Data Box |
| 2 | DCs deployed by Entra Domain Services · resource lock types |
| ~90 seconds | Typical VPN gateway failover for an **unplanned** disruption (planned is a few seconds) |
| 1 or 3 years | Commitment terms for Reservations and the savings plan |
| 4 | Levels in the management hierarchy · valid RBAC scopes · App Service types |
| 5 | Advisor categories · core Storage data services |
| 7 | Defense-in-depth layers · key capabilities of Azure Virtual Network |


---

## 13 — WINDOWS CLIENT BUILD AND DOMAIN JOIN `[WIN]`

### `[WIN-01]` Media preparation

**Evaluation ISOs** (Microsoft Evaluation Center, free Microsoft account required):
- **Windows Server** — 180 days
- **Windows 11 Enterprise** — 90 days

**Record the evaluation start date so you know when the clock runs out.** See the licensing trap in `[BUILD-P0]`.

**Bootable USB with Rufus:**
1. Insert a 16 GB+ USB.
2. Select the ISO → Partition scheme **GPT** → Target system **UEFI (non-CSM)** → File system **NTFS**.
3. **Rufus offers to strip Windows 11 requirements and pre-create a local account.** This is the most reliable local-account method — see `[WIN-OOBE]`.

**BIOS/firmware prep:** enable **UEFI** and **Secure Boot** · confirm TPM 2.0 is present and enabled (required for Windows 11 and for BitLocker) · set the boot order · note the boot menu key (F9/F10/F12 depending on vendor).

### `[WIN-OOBE]` 🔄 UPDATED — creating a local account at OOBE

**Verified August 2026. Read this before quoting older guides.**

Windows 11 OOBE requires a Microsoft account and an internet connection by default. Microsoft has progressively closed every command-line bypass:

| Method | Status as of Aug 2026 |
|---|---|
| `OOBE\BYPASSNRO` (Shift+F10 → `oobe\bypassnro`) | **Blocked.** The `bypassnro.cmd` script was removed from the build in 2025. Either does nothing or loops back to the sign-in gate. |
| `start ms-cxh:localonly` | **Blocked** in current builds. Was the recommended replacement for BYPASSNRO; also now neutered. |
| Registry toggle `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\BypassNRO = 1` | **Ineffective** in patched builds. |
| Fake / blocked email addresses | Blocked. |

**What still works — and both are appropriate for professional builds:**

1. **"Domain join instead" — Windows 11 Pro / Enterprise only.** At the sign-in screen there is a *Sign-in options* → **Domain join instead** path that creates a local account. **This is the correct route for a machine you are about to domain-join anyway**, and it is the one to use in a business build.
2. **Customized install media.** Rufus (and Ventoy) can build an ISO with the local-account requirement removed and optionally with TPM/Secure Boot/RAM checks bypassed. For fleet work, an **`unattend.xml` answer file** is the supported, documented equivalent and is what you should be using at any scale.

**⚠ Report this behavior as version-dependent.** Microsoft has changed it repeatedly, and it may change again. If a method fails, do not assume the machine is broken — check the build number and try the media-based route. **Test on one machine before promising a deployment schedule.**

### `[WIN-02]` Client build sequence

1. Install **Windows 11 Pro or Enterprise**. **Home cannot join a domain** — verify the edition before promising anything.
2. Complete OOBE with a **local account** — see `[WIN-OOBE]`.
3. **Set the time zone. Then verify the clock.** Not optional — see `[AD-TIME]`.
4. Patch fully. Install vendor drivers and firmware.
5. **Rename to the planned hostname.** Reboot.
6. Run the pre-join verification block below. **Do not attempt the join until it passes.**
7. Join the domain. The object lands in `OU=Workstations` automatically because of `redircmp`.
8. Reboot.
9. **Log in as a real domain user — never as an administrator.**

### `[WIN-PREJOIN]` Pre-join verification — run all four, in order

Every one of these is a hard prerequisite. Any failure means the join will fail, **and the error Windows returns will not tell you which one.**

```powershell
# 1. DNS must point at a domain controller
ipconfig /all | Select-String "DNS Servers" -Context 0,2

# 2. SRV records must resolve — THIS is how a DC is located, not by ping
nslookup -type=SRV _ldap._tcp.dc._msdcs.ad.contoso.com

# 3. Clock skew must be under 5 minutes
w32tm /stripchart /computer:10.10.10.10 /samples:3 /dataonly

# 4. The DC must answer on LDAP
Test-NetConnection 10.10.10.10 -Port 389
```

### `[AD-JOIN-FAIL]` 🛑 "An Active Directory Domain Controller could not be contacted" — decode it

**This message describes a symptom, not a cause**, and it covers at least five unrelated failures. Work the list in order:

| Real cause | How to confirm | Fix |
|---|---|---|
| **Wrong DNS server** | `ipconfig /all` shows the router or a public resolver | Fix DHCP option 6. **Never set client DNS by hand.** |
| **SRV records unresolvable** | `nslookup -type=SRV` returns nothing | DNS is wrong, or the zone lost its records — `net stop netlogon && net start netlogon` on the DC to re-register |
| **Clock skew** | `w32tm /stripchart` shows > 5 min offset | **Set the time zone.** Kerberos rejects the request; the client reports it as "no DC found." |
| **Firewall / routing** | `Test-NetConnection` on 389 or 445 fails | Permit **53, 88, 123, 135, 389, 445, 464** between the VLANs |
| **Typo in the domain name** | Re-read it character by character | Use the **FQDN**, not the NetBIOS name |

**🛑 Ping proves nothing here.** A successful ping tests IP reachability using an address you supplied by hand. Domain join uses **DNS SRV lookup and Kerberos**, and both can fail completely on a network where ping works perfectly. **Time zone in particular is nowhere in the error text** and is a frequent cause on laptops, which ship configured for whatever region the image was built in.

### `[WIN-03]` 🛑 Step 8 determines device ownership permanently

**The first user to sign in triggers MDM auto-enrollment under their identity.** Signing in as `DOMAIN\Administrator` and manually adding a work account produces **Personal** ownership, reduced management capability, and application deployments that silently never install. **Let the GPO do it** — see `[MDM-OWNERSHIP]`.

### `[WIN-POSTJOIN]` Standard post-join verification

```powershell
whoami                            # DOMAIN\user
nltest /dsgetdc:ad.contoso.com    # DC locator succeeds; note WHICH DC answered
gpresult /r                       # computer and user GPOs listed
net use                           # drive maps present
dsregcmd /status                  # DomainJoined : YES
manage-bde -status C:             # BitLocker on, key escrowed
```

**Confirm visually:** legal banner at logon · drives mapped · Documents → Properties → Location shows the server path · **no Folder Redirection errors in Event Viewer → Application log**.

### `[WIN-04]` Broken machine account trust

Symptom: *"The trust relationship between this workstation and the primary domain failed."*

```powershell
Test-ComputerSecureChannel                 # returns $false when broken
Test-ComputerSecureChannel -Repair -Credential (Get-Credential)
Reset-ComputerMachinePassword -Credential (Get-Credential)
```

**Do not unjoin and rejoin.** That destroys the computer object's SID, its group memberships, its BitLocker escrow, and its Intune/Entra device registration. `-Repair` resets the machine account password in place and keeps all of it.

### `[WIN-05]` Hyper-V notes for lab and DC02 builds

```powershell
Get-VMSwitch
New-VMSwitch -Name "External" -NetAdapterName "Ethernet" -AllowManagementOS $true
Get-VMIntegrationService -VMName "DC02"
Get-VMIntegrationService -VMName "DC02" -Name "Time Synchronization" | Disable-VMIntegrationService
```

- **Generation 2** VM · 4 GB RAM minimum for a DC (6–8 preferred) · 60–80 GB virtual disk.
- **Attach to an External virtual switch.** The **Default Switch is NAT** and cannot reach the LAN — a VM on it will fail every domain-join prerequisite while appearing to have internet.
- **⚠ Creating an external vSwitch briefly drops the host's network,** and afterward the host routes through the new `vEthernet` adapter. **If the host loses internet after creating a vSwitch, set DNS on the vEthernet adapter.** Removing the switch drops the network again.
- **Do not host a domain controller VM on a domain controller.** Use a separate hypervisor host.
- **Disable Time Synchronization integration service on any virtualized DC** — see `[AD-TIME]`.

### `[WIN-06]` Windows update and application troubleshooting

```powershell
winget upgrade                            # what's outdated
winget upgrade --all --silent             # update everything
winget list
winget install <PackageId>

Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10
Get-WindowsUpdateLog                      # decodes ETW traces into a readable log (slow)

# Reset the Windows Update stack when it is genuinely stuck
Stop-Service wuauserv, cryptSvc, bits, msiserver
Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old
Rename-Item C:\Windows\System32\catroot2   catroot2.old
Start-Service wuauserv, cryptSvc, bits, msiserver

# System file integrity
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
```

**Order matters:** run `DISM /RestoreHealth` **before** `sfc /scannow`. SFC repairs from the component store; if the component store itself is damaged, SFC has nothing good to copy from. DISM repairs the store.

**Checklist:** confirm scope (one app / all apps / OS-wide) → check disk space → reboot if updates are pending → update with winget where appropriate → reproduce → **document application name, version, exact error text, and fix.**

### `[WIN-07]` Printer troubleshooting

```powershell
Get-Service Spooler
Restart-Service Spooler -Force
Get-Printer | Select-Object Name, DriverName, PortName, Shared, Published
Get-PrintJob -PrinterName "PrinterName"
Remove-PrintJob -PrinterName "PrinterName" -ID 3
Get-PrinterPort
Add-Printer -Name "Sales-MFP" -DriverName "HP Universal Printing PCL 6" -PortName "IP_10.10.10.50"

# Nuclear option: clear the stuck queue on disk
Stop-Service Spooler -Force
Remove-Item "C:\Windows\System32\spool\PRINTERS\*" -Force
Start-Service Spooler
```

**Checklist:** printer powered and on the network → user on the correct network/VLAN or VPN → ping the printer IP → check the queue → clear stuck jobs **if authorized** → restart the spooler → confirm the correct driver → **test print from another user and another device** (this isolates user vs printer vs driver) → escalate if hardware or vendor issue.

---

## 14 — STORAGE AND DISK OPERATIONS `[DISK]`

### `[DISK-01]` Inspecting disks

```powershell
Get-Disk
Get-Partition
Get-Volume
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, HealthStatus, Size
Get-PSDrive C

# Find what's eating the space
Get-ChildItem C:\ -Recurse -File -ErrorAction SilentlyContinue |
    Sort-Object Length -Descending |
    Select-Object -First 20 Name, @{n='SizeGB';e={[math]::Round($_.Length/1GB,2)}}, FullName

# Directory sizes, one level down
Get-ChildItem C:\ -Directory | ForEach-Object {
    $size = (Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue |
             Measure-Object Length -Sum).Sum
    [PSCustomObject]@{ Folder=$_.Name; SizeGB=[math]::Round($size/1GB,2) }
} | Sort-Object SizeGB -Descending

Repair-Volume -DriveLetter C -Scan       # read-only check
Repair-Volume -DriveLetter C -OfflineScanAndFix   # requires downtime
```

**Common space offenders on a Windows machine:** `C:\Windows\SoftwareDistribution` (update cache — safe to clear with the service stopped) · `C:\Windows\Temp` and `%TEMP%` · `C:\Windows\Installer` (**do not delete manually — it breaks uninstall and repair**) · user profile OneDrive caches · Windows.old after an in-place upgrade (use Disk Cleanup, not `Remove-Item`) · IIS or SQL logs · shadow copies (`vssadmin list shadowstorage`).

### `[DISK-02]` Reformatting a drive after BitLocker partition deletion

**Context:** when a BitLocker partition is deleted, the space becomes **Unallocated**. Because no file system exists there, **the drive will not appear in File Explorer at all** — which reads as "the drive is dead." It is not.

#### Option 1 — Disk Management GUI (simple case)

Use when the drive shows as Unallocated (black header bar) with no leftover system partitions.

1. **Win + X** → **Disk Management**.
2. Locate the drive in the lower graphical panel (Disk 1, Disk 2…). **Match by capacity.**
3. Right-click the Unallocated space → **New Simple Volume**.
4. In the wizard:
   - **Volume Size:** leave at the default maximum
   - **Drive Letter:** any available letter
   - **File system:** **NTFS**, or **exFAT** for cross-platform use with macOS/Linux
   - Check **Perform a quick format**
5. **Finish.**

#### Option 2 — Diskpart (full wipe)

Use when BitLocker metadata, hidden EFI system partitions, or recovery structures prevent normal volume creation.

**🛑 CRITICAL SAFETY WARNING: verify the target disk number before executing `clean`. Selecting the wrong disk index permanently wipes that drive.** There is no undo and no confirmation prompt.

1. **Open Command Prompt as Administrator** — Win+S → `cmd` → right-click → Run as administrator.
2. **Launch Diskpart:**
   ```
   diskpart
   ```
3. **Identify the target disk:**
   ```
   list disk
   ```
   Note the `Disk ###` matching your drive's capacity. **Cross-check with `list volume` and `detail disk` if there is any ambiguity.**
4. **Select and sanitize** — replace `X` with your disk index:
   ```
   select disk X
   detail disk          <-- READ THIS. Confirm it is the right drive before continuing.
   clean
   ```
   `clean` erases all partition tables, BitLocker metadata, and system headers, returning the disk to a factory-blank state.
5. **Initialize and reformat:**
   ```
   convert gpt
   create partition primary
   format fs=ntfs quick
   assign
   ```
6. **Exit:**
   ```
   exit
   ```

**✅ POST-FORMAT VERIFICATION:** open File Explorer (Win+E). The drive appears under **This PC** with its new letter and a clean file system.

**PowerShell equivalent, if you prefer object safety:**
```powershell
Get-Disk | Format-Table Number, FriendlyName, Size, PartitionStyle, OperationalStatus
Get-Disk -Number 1 | Clear-Disk -RemoveData -RemoveOEM -Confirm:$true
Initialize-Disk -Number 1 -PartitionStyle GPT
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false
```

**GPT vs MBR:** use **GPT** for anything modern — required for disks over 2 TB and for UEFI boot. MBR only for legacy compatibility. Full comparison, partition limits, and in-place conversion caveats: `[SYSF-02]`.

**NTFS vs exFAT vs ReFS:** **NTFS** for Windows internal and shared drives (permissions, journaling, compression). **exFAT** for removable media shared with macOS/Linux (no permissions, no journaling). **ReFS** for large data volumes with integrity streams — not bootable, and not a general-purpose replacement.

### `[DISK-03]` BitLocker operations

```powershell
Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage
manage-bde -status
Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector
Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector
BackupToAAD-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId "<id>"   # escrow to Entra
Suspend-BitLocker -MountPoint "C:" -RebootCount 1     # BEFORE a firmware/BIOS update
Resume-BitLocker  -MountPoint "C:"
```

**🛑 Suspend BitLocker before a BIOS/firmware/TPM update.** A firmware change alters the measurements the TPM seals against, and the machine will demand the recovery key at next boot. `-RebootCount 1` auto-resumes after one reboot.

**🛑 Never enable BitLocker without confirming the recovery key is escrowed.** Encryption with an unrecoverable key is data destruction on a delay.

---

## 15 — STANDARD OPERATING PROCEDURES `[SOP]`

Written so someone else could run them — **which is the actual test of whether a procedure is documented or just remembered.**

### `[SOP-01]` New user onboarding

**Trigger:** HR or the client requests a new account. **Do not start without a written request** naming the person, start date, department, and manager.

1. **Confirm a license is available before creating anything.** Running out mid-onboarding is avoidable embarrassment.
2. Create the account in `OU=Employees` using the `[AD-10]` script or its single-user equivalent. Correct UPN suffix, department field populated, change password at next logon set.
3. **Add to the correct `GG-` role group. Nothing else** — role group membership drives everything downstream.
4. Add to the licensing group (`LIC-M365-*`) if not already inherited via `GG-AllEmployees`.
5. Force a sync: `Start-ADSyncSyncCycle -PolicyType Delta`. Wait, then confirm the user appears in Entra **with the right UPN**.
6. Confirm the license landed in the Microsoft 365 admin center.
7. **Deliver credentials by a channel separate from the username. Never both in the same email.**
8. Assign or prepare a workstation per SOP-03.
9. Record in the ticket: account name, UPN, groups, license, workstation asset tag.

**✅ VERIFY:** the user logs in on their assigned machine, drives map, Documents redirect, and they can sign in to Microsoft 365 on the web.

### `[SOP-02]` User offboarding

**Trigger:** written notice from an authorized contact. **This is the SOP clients audit. Get it in writing, every time, and timestamp each step.**

1. **Disable the account. Do NOT delete it** — deletion destroys mailbox and file ownership chains.
2. **Reset the password to something random.** Disabling alone does not invalidate an existing session.
3. **Revoke active sessions:**
   ```powershell
   Revoke-MgUserSignInSession -UserId user@contoso.com
   ```
   Without this a signed-in session can persist for hours.
4. Remove from all `GG-` role groups. **Record what they were in the ticket before removing.**
5. Remove from the licensing group **only after mailbox handling is decided.**
6. Convert the mailbox to shared, or delegate access to the manager, per the client's policy:
   ```powershell
   Set-Mailbox user@contoso.com -Type Shared
   Add-MailboxPermission -Identity user@contoso.com -User manager@contoso.com -AccessRights FullAccess -InheritanceType All
   ```
7. Move the account to `OU=Disabled`.
8. Set out-of-office or mail forwarding **if requested in writing**.
9. **Check for and remove any forwarding rules the user set themselves** — this is both a data-loss and a compromise indicator.
10. Retrieve the device. Wipe or reassign per SOP-03.
11. Remove the device from Intune and Entra if it is being retired.
12. Retrieve or transfer files from the home folder and redirected folders; grant the manager site-collection admin on the user's OneDrive if approved.
13. **Note the retention date.** Delete the account only after the client's retention period expires.

**✅ VERIFY:** sign-in blocked · sessions revoked · group membership empty · device accounted for.

### `[SOP-03]` Workstation deployment

1. **Record asset tag, serial number, model, and assigned user in the asset register before touching it.**
2. Add the serial number to Intune **corporate device identifiers** if using that method.
3. Install or reset Windows 11 Pro/Enterprise. Complete OOBE with a local account — `[WIN-OOBE]`.
4. Patch fully. Install vendor drivers and firmware.
5. Rename to the naming convention. Reboot.
6. **Confirm DHCP delivered both DCs as DNS.**
7. Run the pre-join checks — `[WIN-PREJOIN]`. Join the domain. Reboot.
8. **Log in as the assigned end user.** Not as an administrator, and not as yourself.
9. Wait for MDM auto-enrollment. Confirm in Intune within ~15 minutes.
10. **Confirm Ownership shows Corporate. Fix it immediately if not.**
11. Confirm BitLocker is on and **the recovery key is escrowed to Entra**.
12. Run the verification block. **Hand over only when it is clean.**

```powershell
gpresult /r
net use
dsregcmd /status
manage-bde -status C:
```

### `[SOP-04]` New file share or permission change

1. **Get the request in writing**, naming who needs access and at what level.
2. **Export the current ACL first** if the share exists:
   ```powershell
   Get-Acl D:\Path | Export-Clixml C:\Temp\acl-backup-$(Get-Date -Format 'yyyyMMdd').xml
   ```
3. Create or identify the Domain Local resource group: `DL-<Resource>-<Access>`.
4. **Nest the appropriate Global role group into it. Never add a user directly.**
5. If a new share: create the folder, share it with `Authenticated Users` Full Control, enable ABE.
6. Set NTFS using the standard model — `[FILE-05]`.
7. Add the drive mapping to the Drive Maps GPO with item-level targeting on the `GG-` group, **Action = Update**.
8. **Test with a real account from the group. Then test that a non-member cannot see the folder at all.**
9. Update the share and permission register.

**🛑 Never tick "Replace all child object permission entries" on a production tree without knowing exactly what is beneath it.**

### `[SOP-05]` Add a domain controller

1. **Confirm the existing directory is healthy first:** `dcdiag /v` and `repadmin /replsummary` must be clean. **Never add a DC to a sick domain.**
2. Build the server per `[BUILD-P1]`. If virtual, **disable host time synchronization**.
3. Static IP. Preferred DNS = an existing DC, Alternate = `127.0.0.1`.
4. **Join as a member server. Reboot. Then promote.**
5. Add AD DS role → promote as an additional DC → DNS and Global Catalog checked → DSRM password to the vault.
6. Install GPMC and RSAT tools on it.
7. Set `w32tm /config /syncfromflags:domhier /update`.
8. **Cross-point DNS client settings on all DCs.**
9. **Add the new DC to DHCP option 6 on every scope.**
10. Configure DHCP failover if it will serve DHCP.
11. Update the topology diagram and IP register.

```powershell
Get-ADDomainController -Filter * | Format-Table Name, HostName, IsGlobalCatalog
repadmin /replsummary
dcdiag /test:dns
```

### `[SOP-06]` Monthly maintenance check

**Thirty minutes per client per month. This is what turns reactive break-fix into managed services.**

```powershell
# Directory health
dcdiag /v
repadmin /replsummary
Get-ADDomainController -Filter * | Format-Table Name, IsGlobalCatalog
netdom query fsmo

# Time
w32tm /query /status
w32tm /query /source
w32tm /monitor

# Backup
Get-WBSummary

# Storage
Get-Volume | Where-Object DriveLetter | Format-Table DriveLetter, SizeRemaining, Size

# Security review
Get-ADGroupMember "Domain Admins"     | Select-Object Name
Get-ADGroupMember "Enterprise Admins" | Select-Object Name
Search-ADAccount -AccountDisabled -UsersOnly | Measure-Object
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly | Select-Object Name, LastLogonDate
Search-ADAccount -PasswordNeverExpires -UsersOnly | Select-Object Name

# Licensing and expiry
slmgr /dlv

# Hybrid identity
Get-ADSyncScheduler
```

**Also check:** Intune non-compliant devices · Entra Connect sync errors · **failed backup alerts** · patch compliance · any certificate expiring within 60 days · Entra sign-in risk detections · M365 message center for changes affecting the client.

### `[SOP-07]` Domain controller failure and FSMO seizure

**If the DC is recoverable: repair it and let replication converge. Do NOT seize roles. Seizing is one-way.**

**If the DC is permanently gone:**

1. **Confirm it is truly unrecoverable.** Seizure cannot be undone and **the old DC must never be brought back online afterward.**
2. Identify which roles it held — from your documentation, or `netdom query fsmo`.
3. **Seize the roles onto a surviving DC:**
   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity "SITE-DC02" `
       -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster -Force
   ```
4. **Remove the dead DC's metadata.** On modern Windows Server, deleting the DC's object triggers cleanup automatically:
   - **ADUC** → Domain Controllers OU → right-click the dead DC → **Delete** → confirm the "permanently offline" prompt
   - **AD Sites and Services** → Sites → [site] → Servers → delete the server object
   - **DNS Manager** → delete its A record and its entries under `_msdcs`
5. **If it was the PDC emulator, reconfigure the external time source on the new holder** — `[AD-TIME]`.
6. **Update DHCP option 6 and all DNS client settings** to remove the dead DC's address.
7. **Verify:** `netdom query fsmo` · `dcdiag /v` · `repadmin /replsummary`
8. Build a replacement DC per SOP-05.

### `[SOP-08]` Account lockout triage

See `[AD-LOCKOUT]`. **Find the source before you unlock.**

### `[SOP-09]` Suspected compromised account `[SEC-IR]`

**Speed matters more than completeness here. Do the containment steps first, investigate second.**

**Contain (minutes):**
1. **Escalate per the client's incident process.** Do not go quiet on this.
2. Reset the password to a random value.
3. **Block sign-in** and **revoke all sessions:**
   ```powershell
   Update-MgUser -UserId user@contoso.com -AccountEnabled:$false
   Revoke-MgUserSignInSession -UserId user@contoso.com
   ```
   A password reset alone does not kill an existing refresh token.
4. **Check and remove MFA methods the attacker may have registered.** Entra → User → Authentication methods.

**Investigate:**
5. **Review sign-in activity** — Entra → Sign-in logs. Look for impossible travel, unfamiliar locations, and successful sign-ins from non-corporate IPs.
6. **Check mailbox forwarding and inbox rules** — the single most common attacker persistence mechanism:
   ```powershell
   Get-Mailbox user@contoso.com | Select-Object ForwardingAddress, ForwardingSmtpAddress, DeliverToMailboxAndForward
   Get-InboxRule -Mailbox user@contoso.com | Select-Object Name, Enabled, ForwardTo, RedirectTo, MoveToFolder, DeleteMessage
   ```
   Watch for rules that move mail to `RSS Feeds`, `Archive`, or a single-character folder and mark it read — that is the classic hide-the-evidence pattern.
7. **Check recent admin role changes** and any new app consents / enterprise applications the account granted.
8. Check for new mail-enabled forwarding at the tenant level and any new outbound connectors.
9. **Document the timeline and evidence.** Timestamps, IPs, actions taken and when.

### `[SOP-10]` Suspicious email / phishing

1. **Do not click links or download attachments.**
2. Collect **sender, recipient, subject, timestamp, and message ID**. Get the **original headers**, not a forwarded copy.
3. **Check if other users received it:**
   ```powershell
   Get-MessageTrace -SenderAddress attacker@bad.com -StartDate (Get-Date).AddDays(-2) -EndDate (Get-Date)
   ```
4. Submit/report according to the client's process (Microsoft Defender → Submissions).
5. **Remove the message if authorized by security policy** — Defender → Explorer → Take action, or a Content Search purge.
6. If anyone clicked or entered credentials, go immediately to `[SEC-IR]`.
7. Document impact and actions.

### `[SOP-11]` Remote support session

**Before connecting:** confirm requester identity · confirm the device name · confirm user consent where required · confirm business impact · **review ticket notes and previous actions.**

**During:** explain what you are doing · **avoid accessing unrelated personal or private content** · do not run destructive commands without approval · capture exact error text (screenshot, don't paraphrase) · document commands and changes as you go.

**After:** confirm resolved · **ask the user to validate** · remove temporary tools and files · update the ticket with root cause and fix · **add anything useful to the Lessons Learned KB.**

### `[SOP-12]` Daily MSP rhythm

**Morning:** review ticket queue · review monitoring alerts · **review failed backups** · review security alerts · review failed device compliance or deployment alerts · prioritize VIP and business-critical.

**During the day:** **document as you troubleshoot, not after** · validate fixes with users · escalate with clear notes · save useful commands · **avoid undocumented changes.**

**End of day:** update ticket statuses · record unresolved blockers · add new fixes to the Lessons Learned KB · add reusable commands to the script library · **review what you learned.**


---

## 16 — ASSESSING AN INHERITED NETWORK `[ASSESS]`

Most work is not greenfield. It is inheriting an environment built by someone who left three years ago, with no documentation, where something is broken and the client wants it fixed today.

**The discipline is: find out what is actually there before you change anything.** The temptation on day one is to start fixing. Resist it. **You cannot safely change a system you have not mapped, and the thing that looks broken is often load-bearing.**

### `[ASSESS-01]` Discovery block — run this before touching anything

Run from a domain-joined machine with administrative credentials. **Capture the output to a file and keep it.** It is the "before" picture and it will be the most valuable thing you produce in week one.

```powershell
$out = "C:\Temp\Discovery_$(Get-Date -Format 'yyyyMMdd')"
New-Item -Path $out -ItemType Directory -Force | Out-Null
Import-Module ActiveDirectory

# ---------- FOREST AND DOMAIN ----------
Get-ADForest | Format-List Name, ForestMode, DomainNamingMaster, SchemaMaster, GlobalCatalogs
Get-ADDomain | Format-List Name, DNSRoot, NetBIOSName, DomainMode, PDCEmulator, RIDMaster, InfrastructureMaster
netdom query fsmo > "$out\fsmo.txt"

# ---------- DOMAIN CONTROLLERS AND HEALTH ----------
Get-ADDomainController -Filter * |
    Select-Object Name, HostName, IPv4Address, Site, IsGlobalCatalog, OperatingSystem |
    Export-Csv "$out\dcs.csv" -NoTypeInformation
dcdiag /v                 > "$out\dcdiag.txt"
dcdiag /test:dns          > "$out\dcdiag-dns.txt"
repadmin /replsummary     > "$out\repl-summary.txt"
repadmin /showrepl        > "$out\repl-detail.txt"

# ---------- TIME ----------
w32tm /query /status  > "$out\time-status.txt"
w32tm /query /source >> "$out\time-status.txt"
w32tm /monitor       >> "$out\time-status.txt"

# ---------- DNS ----------
Get-DnsServerZone       | Export-Csv "$out\dns-zones.csv" -NoTypeInformation
Get-DnsServerForwarder  | Out-File   "$out\dns-forwarders.txt"
Get-DnsServerScavenging | Out-File   "$out\dns-scavenging.txt"

# ---------- DHCP ----------
Get-DhcpServerInDC       | Out-File "$out\dhcp-authorized.txt"
Get-DhcpServerv4Scope    | Export-Csv "$out\dhcp-scopes.csv" -NoTypeInformation
Get-DhcpServerv4Scope | ForEach-Object {
    Get-DhcpServerv4OptionValue -ScopeId $_.ScopeId
} | Out-File "$out\dhcp-options.txt"        # CHECK OPTION 6

# ---------- STRUCTURE ----------
Get-ADOrganizationalUnit -Filter * |
    Select-Object Name, DistinguishedName | Export-Csv "$out\ous.csv" -NoTypeInformation
Get-ADDomain | Select-Object ComputersContainer, UsersContainer |
    Out-File "$out\container-redirection.txt"   # was redircmp ever run?

# ---------- IDENTITY INVENTORY ----------
Get-ADUser -Filter * -Properties UserPrincipalName,Department,LastLogonDate,Enabled |
    Select-Object Name,SamAccountName,UserPrincipalName,Department,Enabled,LastLogonDate |
    Export-Csv "$out\users.csv" -NoTypeInformation
Get-ADGroup -Filter * |
    Select-Object Name,GroupScope,GroupCategory,DistinguishedName |
    Export-Csv "$out\groups.csv" -NoTypeInformation
Get-ADComputer -Filter * -Properties OperatingSystem,LastLogonDate |
    Select-Object Name,DNSHostName,OperatingSystem,LastLogonDate,DistinguishedName |
    Export-Csv "$out\computers.csv" -NoTypeInformation

# ---------- GROUP POLICY ----------
Get-GPO -All | Sort-Object DisplayName |
    Select-Object DisplayName,GpoStatus,CreationTime,ModificationTime |
    Export-Csv "$out\gpos.csv" -NoTypeInformation
Get-GPOReport -All -ReportType Html -Path "$out\AllGPOs.html"
Backup-GPO -All -Path "$out\GPOBackup"          # do this BEFORE changing anything

# ---------- PRIVILEGED ACCESS ----------
"Domain Admins","Enterprise Admins","Schema Admins","Account Operators","Backup Operators" |
  ForEach-Object {
    "--- $_ ---" | Out-File "$out\privileged.txt" -Append
    Get-ADGroupMember $_ -ErrorAction SilentlyContinue |
        Select-Object Name, objectClass | Out-File "$out\privileged.txt" -Append
}

# ---------- ACCOUNT HYGIENE ----------
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly |
    Select-Object Name, LastLogonDate | Export-Csv "$out\stale-users.csv" -NoTypeInformation
Search-ADAccount -PasswordNeverExpires -UsersOnly |
    Select-Object Name | Export-Csv "$out\pwd-never-expires.csv" -NoTypeInformation
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -ComputersOnly |
    Select-Object Name | Export-Csv "$out\stale-computers.csv" -NoTypeInformation

# ---------- FILE SERVICES ----------
Get-SmbShare | Where-Object { $_.Name -notlike "*$" } |
    Select-Object Name, Path, FolderEnumerationMode |
    Export-Csv "$out\shares.csv" -NoTypeInformation

# ---------- HYBRID IDENTITY ----------
Get-ADSyncScheduler                                  | Out-File "$out\adsync-scheduler.txt"
Get-ADSyncConnector | Select-Object Name, Type       | Out-File "$out\adsync-connectors.txt"

# ---------- LICENSING ----------
slmgr /dlv

Write-Host "`nDiscovery complete: $out" -ForegroundColor Green
```

**Copy the output folder off the server to somewhere that survives.**

### `[ASSESS-02]` What you will actually find — prioritized by risk, not by ease

| Pri | Finding | What it means and what to do |
|---|---|---|
| **1** | **No tested backup of AD or file data** | Nothing else matters if this is missing. Fix first, then test a restore and document the date. |
| **1** | **RDP exposed to the internet** | Primary ransomware entry vector. **Close it today.** Move to VPN or RMM. **Escalate immediately.** |
| **1** | **Single domain controller** | Authentication, DNS, and often DHCP all fail together. Highest-value upsell and easiest to justify. |
| **1** | **Shared local admin password everywhere** | One machine compromised equals all machines compromised. **Deploy LAPS.** |
| **2** | **Domain Admins with ten or more members** | Usually every IT person's daily account plus service accounts. Separate daily from privileged. Aim for near-empty. |
| **2** | Users with permissions applied **directly** to folders | Unauditable and undocumentable. Migrate to group-based over time; **do not rip it out in one pass.** |
| **2** | `Everyone` with Full Control on shares | Move to the standard model. **Audit what is actually being accessed before restricting.** |
| **2** | **No MFA on administrators** | Enable it. **Create a break-glass account first**, excluded from Conditional Access. |
| **2** | PDC emulator syncing from `Local CMOS Clock` | No external time anchor. Fix per `[AD-TIME]`. |
| **3** | Computer objects sitting in `CN=Computers` | Those machines receive **no policy**. Run `redircmp` and move the existing objects. |
| **3** | Everything configured in the Default Domain Policy | Untroubleshootable. Split into purpose-named GPOs **gradually; document before changing.** |
| **3** | Dozens of GPOs, unlinked or unnamed | Generate the full HTML report, map what is actually linked, then archive the orphans. |
| **3** | `.local` domain name | **Note it, do not rename.** Add a routable UPN suffix when cloud services are introduced. |
| **3** | Entra Connect installed on a domain controller | Note as a finding. Plan migration to a member server. |
| **3** | AD Recycle Bin not enabled | **Enable it. Free, immediate, no downside.** |
| **4** | Disabled accounts never cleaned up | Establish a Disabled OU and a retention policy. |
| **4** | No reverse DNS zone or scavenging | Create the zone, enable scavenging. Stale records cause intermittent, confusing failures. |
| **4** | Server **evaluation** licenses in production | Check `slmgr /dlv`. **Plan the conversion before expiry — it requires demotion on a DC.** |

### `[ASSESS-03]` Triage decision trees

#### "I can't log in"

1. **One user or many?** Many means infrastructure. One means account.
2. **One user:** `Search-ADAccount -LockedOut`. If locked, go to `[AD-LOCKOUT]` and **find the source before unlocking.**
3. **Account fine?** Try a different machine. Works elsewhere means it is the machine, not the account.
4. **Many users, one machine:** check the machine's secure channel — `Test-ComputerSecureChannel -Repair`.
5. **Many users, many machines:** check DNS, then the DCs, then time.
   ```powershell
   nltest /dsgetdc:ad.contoso.com
   w32tm /query /status        # skew over 5 minutes breaks Kerberos everywhere
   dcdiag /v
   ```
6. **Is a DC down, and do clients have a second DNS server to fall back to?**
7. Cloud sign-in involved? Check Conditional Access and license state — `[M365-07]`.

#### "I can't get to the file share"
See `[FILE-TRIAGE]`.

#### "Group Policy isn't applying"
See `[GPO-TRIAGE]`.

#### "The device isn't showing up in Intune"

1. `dsregcmd /status`. **`DomainJoined : YES` and `AzureAdJoined : YES` are both required.**
2. **`AzureAdJoined : NO`** → the computer object is not in Entra. Check Entra Connect sync scope includes the workstation OU, then force a **full** sync.
3. **Both YES but not in Intune** → check the user has an **Intune** license and that MDM user scope includes them.
4. Check the MDM auto-enrollment GPO is applying to the machine.
5. In Intune, check **Ownership**. Personal means it was enrolled by hand and will behave badly — change to Corporate.
6. **App not installing** → confirm the assignment targets a group that actually contains this device. On-premises groups **cannot** contain Entra devices — use a dynamic device group.

---

## 17 — DECOMMISSIONING A HYBRID ENVIRONMENT `[DECOM]`

Client offboarding and tenant decommissioning are **billable MSP work**. It is also the only realistic opportunity to practice a forced domain controller removal and metadata cleanup, because in production that only happens during an outage.

### `[DECOM-00]` 🛑 The one rule that governs the whole sequence

> **Tear down from the top of the stack to the bottom.**
>
> Applications → policies → device identity → user identity → the sync bridge → the directory → the servers → **the billing, last.**

**Every layer depends on the one beneath it. Remove a lower layer first and the layer above becomes orphaned and unmanageable.**

The classic version of this mistake: **wiping the domain controller while Entra Connect is still syncing.** The cloud objects stay marked as on-premises-mastered, become read-only, and can no longer be deleted normally.

**Corollary: cancel the paid subscription absolutely last.** Canceling deactivates your licenses, and you need a live Intune license to administer Intune.

### `[DECOM-P0]` Phase 0 — Stop the financial clock (do this first, today)

- [ ] M365 admin center → **Billing → Your products** → three-dot menu on the subscription → **Turn off recurring billing**
- [ ] Confirm the Renewal column now reads **Expires on**, not *Renews on*
- [ ] **Do NOT click "Cancel subscription" yet.** Turning off recurring billing removes the charge at the renewal date while leaving the subscription fully functional until then — giving you weeks of licensed time to work through this runbook without deadline pressure.
- [ ] Check **Azure separately** — it bills independently and does not appear on that page: Azure portal → Cost Management + Billing → Subscriptions. Note the subscription type (Free Trial vs Pay-As-You-Go), whether credit remains, and whether it has already auto-converted.

**Record:** M365 subscription expires ______ · Azure subscription type ______ · Azure credit remaining / spend ______

### `[DECOM-P1]` Phase 1 — Capture the "before" state

**This is the step that separates a decommission from a deletion.** Real offboarding requires evidence of what existed, both for the client's records and for your own protection. **You cannot screenshot an environment after you have destroyed it.**

- [ ] Run the `[ASSESS-01]` discovery block and save the output
- [ ] **Copy the output folder off the server** to somewhere that survives the wipe

**In the cloud portals — screenshot these:**
- [ ] Entra → Users (list view)
- [ ] Entra → Groups
- [ ] Entra → Devices → All devices (**showing Join type and Ownership**)
- [ ] Entra → Devices → Mobility (MDM and MAM) configuration
- [ ] Intune → Devices → Windows devices
- [ ] Intune → Apps → All apps
- [ ] Intune → any Compliance or Configuration policies
- [ ] Azure Arc → Machines
- [ ] Entra Connect Health / sync status

**Also capture:**
- [ ] `dsregcmd /status` from each client — the **full** block
- [ ] `gpresult /h` from each client
- [ ] Entra Connect configuration details — sync scope OUs, sign-in method, whether hybrid join was configured

**✅ VERIFY:** you have a folder you could hand to another technician that fully describes the environment. **If you cannot rebuild a diagram from what you captured, capture more.**

### `[DECOM-P2]` Phase 2 — Application and policy layer (Intune)

**Remove assignments before deleting the objects they point at.** An orphaned assignment on a deleted group is one of the more annoying things to chase later.

- [ ] Apps → All apps → [app] → Properties → **Assignments → remove all** → Review + save
- [ ] Wait for the assignment removal to show as saved, **then** Delete the app
- [ ] Devices → Configuration → delete each profile
- [ ] Devices → Compliance → delete each policy
- [ ] Devices → Enrollment → Corporate device identifiers → remove any serials
- [ ] Devices → Enrollment → Enrollment restrictions → revert to defaults
- [ ] Endpoint security → delete any baselines or antivirus policies

**Training exercise if you have two machines — do one of each so you see the behavior firsthand:**
- [ ] Machine A → **Retire.** Removes company data, apps, and policies; leaves personal data and the OS intact. *(What you use when an employee leaves with a BYOD device.)*
- [ ] Machine B → **Wipe.** Factory-resets the device. *(What you use for a company-owned device being reassigned or returned.)*
- [ ] Note how long each takes and what state the device ends in. **Record what you observe.**
- [ ] After both complete: Devices → All devices → delete both device records

**✅ VERIFY:** Intune shows no devices, no apps, no policies.

### `[DECOM-P3]` Phase 3 — Device identity (Entra)

Unregister cleanly rather than orphaning. **Do this while the machines are still domain-joined and can reach the DC.**

```powershell
# On each client, elevated
dsregcmd /status     # confirm current state before
dsregcmd /leave      # removes the hybrid Entra registration
dsregcmd /status     # AzureAdJoined should now read NO
```

- [ ] Entra admin center → Devices → All devices → delete any device objects still listed

**✅ VERIFY:** `dsregcmd /status` shows `AzureAdJoined : NO` on each client, and Entra → Devices is empty.

### `[DECOM-P4]` Phase 4 — User and group identity via sync (the critical phase)

**The DC must still be running with Entra Connect functional. This is the phase that prevents orphaned cloud objects.**

- [ ] **Confirm your actual OU paths first** — they may differ from the recommended structure

```powershell
# Delete the on-premises objects (substitute your real paths)
Get-ADUser -Filter * -SearchBase "OU=Employees,OU=Contoso,DC=ad,DC=contoso,DC=com" |
    Remove-ADUser -Confirm:$false

Get-ADComputer -Filter * -SearchBase "OU=Workstations,OU=Contoso,DC=ad,DC=contoso,DC=com" |
    Remove-ADComputer -Confirm:$false

Get-ADGroup -Filter * -SearchBase "OU=Groups,OU=Contoso,DC=ad,DC=contoso,DC=com" |
    Remove-ADGroup -Confirm:$false
```

**If an OU refuses to give up its content**, it is protected from accidental deletion. Clear the flag:
```powershell
Get-ADOrganizationalUnit -Filter * |
    Set-ADObject -ProtectedFromAccidentalDeletion $false
```

- [ ] Force a delta sync: `Start-ADSyncSyncCycle -PolicyType Delta`
- [ ] Wait 5–10 minutes

**🛑 VERIFICATION GATE — do not proceed until this passes:**
- Entra → Users — only your global admin remains
- Entra → Groups — only cloud-only groups you created by hand remain
- Entra → Devices — empty

**If synced objects are still present, the sync did not propagate the deletions.** Check Synchronization Service Manager on the sync server for export errors before continuing. **Do not move to Phase 5 with synced objects still in the cloud — that is exactly how they become orphaned.**

- [ ] Delete any remaining cloud-only groups by hand

### `[DECOM-P5]` Phase 5 — Remove hybrid join configuration from AD

The **Service Connection Point** tells domain-joined machines which tenant to register with. Removing it is part of a proper decommission and **it is the step almost everyone skips.**

```powershell
# On the DC — the GUID is the well-known device registration object
$scp = Get-ADObject -Filter 'Name -eq "62a0ff2e-97b9-4513-943f-0d221bd30080"' `
        -SearchBase "CN=Configuration,DC=ad,DC=contoso,DC=com"
$scp                              # confirm it found EXACTLY ONE object before deleting
Remove-ADObject -Identity $scp -Confirm:$false
```

- [ ] Confirm removal by re-running the `Get-ADObject` query — it should return nothing

### `[DECOM-P6]` Phase 6 — Uninstall Entra Connect

Microsoft's guidance is explicit that **the sync client comes out before directory sync is disabled in the cloud.** Doing it the other way leaves the portal showing sync disabled while Password Hash Sync still reads enabled — harmless, but confusing.

```powershell
# Stop the scheduler first so nothing syncs mid-uninstall
Set-ADSyncScheduler -SyncCycleEnabled $false
Get-ADSyncScheduler       # confirm SyncCycleEnabled : False
```

- [ ] Control Panel → Programs and Features → **Microsoft Entra Connect** → Uninstall
- [ ] Also uninstall **Microsoft Entra Connect Sync** and the bundled **Microsoft SQL Server Express LocalDB** if listed separately
- [ ] Reboot

**✅ VERIFY:** the `ADSync` service is gone, and no Entra Connect entries remain in Programs and Features.

### `[DECOM-P7]` Phase 7 — Disable directory synchronization in the tenant

If Phase 4 verified clean, this is now a formality — there are no synced objects left to convert. **Do it anyway; it is the correct final state for a decommissioned tenant.**

```powershell
Install-Module Microsoft.Graph -Force
Connect-MgGraph -Scopes "Organization.ReadWrite.All","Directory.ReadWrite.All"

# Confirm current state
Get-MgOrganization | Select-Object OnPremisesSyncEnabled

$organizationId = (Get-MgOrganization).Id
$params = @{ onPremisesSyncEnabled = $false }
Update-MgOrganization -OrganizationId $organizationId -BodyParameter $params

# Confirm the change
Get-MgOrganization | Select-Object OnPremisesSyncEnabled
```

**🔄 Note the module: `MSOnline` and `AzureAD` are retired. Any older guide showing `Set-MsolDirSyncEnabled` will fail.**

**⚠ There is a 72-hour lockout before directory sync can be re-enabled.** Irrelevant if you are abandoning the tenant; **it matters if you intend to reuse it.**

### `[DECOM-P8]` Phase 8 — Purge Entra

- [ ] Entra → Users → **Deleted users** → select all → **Delete permanently** (objects otherwise sit in a 30-day recycle bin)
- [ ] Entra → Groups → Deleted groups → purge any Microsoft 365 groups
- [ ] Entra → **Enterprise applications** → remove service principals created by Entra Connect (look for the Entra Connect / sync entries)
- [ ] Entra → App registrations → delete anything you created
- [ ] Entra → Devices → Mobility (MDM and MAM) → note the config, then **leave it** (tenant scaffolding, cannot cause charges)

**✅ VERIFY:** Users contains only your global admin · Deleted users is empty · Devices is empty.

### `[DECOM-P9]` Phase 9 — Azure decommission

- [ ] Azure portal → Azure Arc → Machines → delete the server entries
- [ ] Resource groups → delete the resource group containing the Arc resources (type the name to confirm)
- [ ] Subscriptions → [subscription] → Resources → **confirm empty.** *(Log Analytics workspaces are the usual straggler.)*
- [ ] Cost Management → Cost analysis → confirm current spend is zero or trailing to zero
- [ ] Subscriptions → [subscription] → Overview → **Cancel subscription**

**Timing note:** a canceled Azure subscription can be **deleted** from the portal 7 days after cancellation (3 days for a free trial or pay-as-you-go). **You do not need to complete that deletion — cancellation stops billing immediately.** It only matters if you later want to delete the tenant entirely.

### `[DECOM-P10]` Phase 10 — On-premises teardown

**Order matters. Demote the secondary DC first, then the last one.**

**10.1 Remove supporting services**
```powershell
# If the DC runs DHCP, unauthorize it BEFORE demotion
Remove-DhcpServerInDC -DnsName "SITE-DC01.ad.contoso.com" -IpAddress 10.10.10.10
Get-DhcpServerInDC       # confirm it is gone
```

**10.2 Optional training exercise — forced removal and metadata cleanup**

**This is the highest-value item in the entire runbook and you will never get to practice it in production.** Skip to 10.3 for the clean path only.

Simulate DC01 dying permanently:
- [ ] **Power off DC01 without demoting it**
- [ ] On DC02, confirm the domain still functions: `Get-ADUser -Filter *`
- [ ] Seize all five FSMO roles onto DC02:
  ```powershell
  Move-ADDirectoryServerOperationMasterRole -Identity "SITE-DC02" `
      -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster -Force
  ```
- [ ] Verify: `netdom query fsmo` — all five should now show DC02
- [ ] Remove DC01's metadata. On modern Windows Server, **deleting the DC's object triggers cleanup automatically:**
  - ADUC → Domain Controllers OU → right-click DC01 → **Delete** → confirm the "permanently offline" prompt
  - AD Sites and Services → Sites → [site] → Servers → delete the DC01 server object
  - DNS Manager → delete DC01's A record and its entries under `_msdcs`
- [ ] Verify cleanup: `dcdiag /v` and `repadmin /replsummary` on DC02 should no longer reference DC01
- [ ] **Record what you observed:** time to seize roles ______ · errors encountered ______ · what dcdiag said before/after ______

**10.3 Demote the remaining domain controller**

```powershell
# Demoting a NON-final DC
Uninstall-ADDSDomainController `
    -LocalAdministratorPassword (Read-Host -AsSecureString -Prompt "New local admin password") `
    -Force

# Demoting the LAST DC in the domain — note the extra switches
Uninstall-ADDSDomainController `
    -LastDomainControllerInDomain `
    -RemoveApplicationPartitions `
    -LocalAdministratorPassword (Read-Host -AsSecureString -Prompt "New local admin password") `
    -Force
```

The server reboots as a standalone workgroup machine. **The domain no longer exists.**

**10.4 Wipe the hardware**
- [ ] Reflash / reimage the physical servers
- [ ] Delete VMs and their VHDX files from the hypervisor host
- [ ] Remove the Hyper-V external virtual switch if no longer needed — **it will briefly drop the host's network when removed**
- [ ] Reflash the client workstations
- [ ] Return any repurposed machines to their normal VLAN

### `[DECOM-P11]` Phase 11 — Cancel the subscription (last)

Only now, with everything torn down and nothing left to administer.

- [ ] M365 admin center → Billing → Your products
- [ ] [subscription] → three-dot menu → **Cancel subscription**
- [ ] Complete the feedback form and confirm
- [ ] Change the Subscription status filter to **All** and confirm nothing shows Active with a future renewal date
- [ ] Billing → Billing profiles → confirm no other products are attached
- [ ] **Leave Microsoft Entra ID Free alone.** It is automatically added, costs nothing, and cannot be canceled.

**Final financial verification:**
- [ ] **Check the actual card statement in about 45 days.** Date canceled ______ · Statement verified clear on ______

**Verifying the charge actually stopped, rather than trusting that the portal said it would, is the same discipline as testing a restore instead of trusting the backup job's success message.**

### `[DECOM-P12]` Post-decommission writeup

**While it is fresh**, write half a page covering:
- What the environment consisted of
- **The order you decommissioned it in, and why that order**
- What broke or surprised you
- What you would do differently

**That document plus the Phase 1 capture is a genuine portfolio artifact.** Almost nobody applying for a technician role can show a decommission they planned and executed — most have only ever built things.


---

## 18 — ERROR → CAUSE → FIX MASTER INDEX `[ERR]`

**Search this table first.** Every row is a real failure traced to its actual cause.

### Domain join and authentication

| Symptom | Actual cause | Fix |
|---|---|---|
| Domain join fails, "domain not found" | Client DNS not pointing at a DC | Fix DHCP option 6. **Never set client DNS statically.** `[NET-10]` |
| "A domain controller could not be contacted" — **but ping works** | Clock skew over 5 min (often a wrong time zone), or DNS not pointing at a DC | `w32tm /stripchart` and `nslookup -type=SRV`. **Ping tests neither.** `[AD-JOIN-FAIL]` |
| SRV records won't resolve | DNS wrong, or the zone lost its records | On the DC: `net stop netlogon && net start netlogon` to re-register |
| "The trust relationship between this workstation and the primary domain failed" | Machine account password out of sync | `Test-ComputerSecureChannel -Repair`. **Do not unjoin/rejoin.** `[WIN-04]` |
| Second DC promotion fails with bad credentials | Name resolution, IPv6 registration, or time hierarchy | Join as a member server first, fix the time source, then promote `[BUILD-P13]` |
| Virtualized DC with odd intermittent Kerberos errors | Taking time from the hypervisor host | Disable the Time Synchronization integration service; `syncfromflags:domhier` `[AD-TIME]` |
| Account locks out repeatedly | Cached credentials on a phone, mapped drive, or service | **Event 4740 names the source device.** Clear with `cmdkey`. `[AD-LOCKOUT]` |
| Everyone in the building can't authenticate at once | PDC emulator clock drifted, or the only DC is down | `w32tm /query /status` on the PDC. Check DC availability. |

### Group Policy

| Symptom | Actual cause | Fix |
|---|---|---|
| GPO absent from `gpresult` | Linked to an OU that does not contain the object | **Link where the user or computer object actually lives** `[GPO-01]` |
| New PC receives no policy at all | Object landed in `CN=Computers` | `redircmp`, then move the existing objects `[BUILD-P5]` |
| GPO shows as **denied** in gpresult | Security filtering — object lacks Read + Apply | Fix security filtering on the GPO |
| `gpupdate /force` **hangs** | Drive map action = **Replace** with the drive in use | **Change the action to Update** `[GPO-DRIVEMAP]` |
| Drive shows up "eventually," after 2–3 reboots | Fast logon optimization | Enable **"Always wait for the network at computer startup and logon"** `[GPO-04]` |
| Folder Redirection settings never take effect | Redirection applies **at logon only** | **Full log off and log back on.** `gpupdate` will never show it. |
| Drives appear for the wrong people | Item-level targeting on the wrong group | Fix targeting; **enable ABE so folders hide too** `[FILE-04]` |
| New group membership has no effect | Token was built at logon | **Full logoff.** Verify with `whoami /groups`. |
| GPMC fails to open when a DC is down | Console targeting the offline DC | Change Domain Controller in GPMC; then **fix DNS redundancy properly** `[AD-FAILOVER]` |

### Files and permissions

| Symptom | Actual cause | Fix |
|---|---|---|
| Can browse the share, cannot open files | **NTFS** permissions, not share permissions | Grant Modify to the resource group; **verify the "Applies to" scope** `[FILE-05]` |
| Can open but cannot save | Modify missing, or "Applies to" scope wrong | Same |
| Total access loss after a permissions cleanup | **SYSTEM or admin removed from the ACL** | `takeown` + `icacls`, rebuild from the standard model `[FILE-09]` |
| Folder Redirection **Event ID 502**, Access Denied | Home and redirected roots collide; folder not owned by the user | **Separate the roots** `[FILE-502]` |
| "The name has already been shared" (**error 2118**) | `New-SmbShare` only creates; the share already exists | `Set-SmbShare` to modify, or `Remove-SmbShare` then re-create `[FILE-03]` |
| User sees a department folder they shouldn't | ABE not enabled | `Set-SmbShare -FolderEnumerationMode AccessBased` |
| `\\domain.com\shares\...` returns "network path was not found" | **The DFS namespace was never created** | Install FS-DFS-Namespace and create the namespace `[FILE-07]` |

### Hybrid identity

| Symptom | Actual cause | Fix |
|---|---|---|
| `AzureAdJoined : NO`, `error_missing_device` (DeviceJoin) | Computer OU not in Entra Connect sync scope | Add the OU to scope, **full** sync, `dsregcmd /leave` then rejoin `[HYB-JOIN]` |
| `error_missing_device` (**DeviceRenew**) | Client holds a cached device ID for a registration that no longer exists | `dsregcmd /leave` + reboot. **A plain retry will keep failing.** |
| Users sync fine, but hybrid join never works | **The SCP was never configured** — "Configure device options" is a separate wizard task | Relaunch Entra Connect → Configure device options → verify with `[HYB-SCP]` |
| **Full sync run but nothing moved** | Used `-PolicyType Delta` after a config change | **`-PolicyType Initial`** — delta only processes *changed objects*, and your objects didn't change `[HYB-SYNC]` |
| `Start-ADSyncSyncCycle` not recognized | ADSync module not loaded; session predates the install | `Import-Module ADSync` **in a new elevated session** `[HYB-05]` |
| `AzureAdPrt : NO` but `AzureAdJoined : YES` | User has not logged on since registration | Sign out and back in |
| `0x80090303` on `DEVICE_AUTO_KERB` | Cloud Kerberos trust not configured | **Expected and harmless.** Ignore it. |

### Intune

| Symptom | Actual cause | Fix |
|---|---|---|
| Intune apps never install | Device ownership = **Personal** from manual enrollment | Change ownership to Corporate; **enroll via GPO going forward** `[MDM-OWNERSHIP]` |
| Intune assignment does nothing | Targeted an on-prem group that **cannot contain Entra devices** | Use an **Entra dynamic device group** `[HYB-10]` |
| Device in Entra but never enrolls in Intune | User has no **Intune** license — often an **empty licensing group** | Confirm the licensing group has members; check Licenses → Errors & Issues `[HYB-LIC]` |
| Assignment made, nothing happens, no errors | Dynamic group hasn't populated yet | Open the group and confirm the device is in it. Wait several minutes. |
| Hours lost chasing the Intune Management Extension | **The IME is not in the path for Microsoft 365 Apps** | Confirm the delivery mechanism first `[MDM-02]` |
| Company Portal shows "functionality limited" | Personal-owned enrollment | `[MDM-OWNERSHIP]` |

### Azure and cloud

| Symptom | Actual cause | Fix |
|---|---|---|
| **Global Admin cannot see any Azure subscription** | **Entra roles do not grant Azure RBAC** | Assign Contributor at subscription scope, or temporarily elevate access `[AZ-RBAC-VS-ENTRA]` |
| Arc agent shows not connected | Expired onboarding token | `azcmagent disconnect --force` then `connect` with explicit parameters `[AZ-ARC]` |
| `azcmagent` not recognized | PATH not refreshed in the current session | New elevated session, or call by full path |
| Resources tagged at the RG level but child resources untagged | **Tags are not inherited** | Use Azure Policy to append/enforce tags `[AZ-09]` |
| Cannot delete a resource even as Owner | A **resource lock** is applied — locks override RBAC | Remove the lock, act, re-apply |

### PowerShell and scripting

| Symptom | Actual cause | Fix |
|---|---|---|
| Multi-line PowerShell fails oddly | **Whitespace after a backtick** | Collapse to one line, or **use splatting** `[PS-09]` |
| Script blocked, "not digitally signed" | Execution policy | `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` `[PS-EXEC]` |
| Script from another machine won't run even after policy change | Mark-of-the-web | `Get-ChildItem *.ps1 \| Unblock-File` |
| Re-running a setup script produces a wall of errors | Not idempotent — partial prior run | Add existence checks; create-or-update `[PS-10]` |
| Piped output to CSV is garbage | `Format-Table` earlier in the pipeline destroyed the objects | **Format last, always** `[PS-03]` |
| `Get-EventLog` / `Get-WmiObject` not recognized | Running PowerShell 7 | `Get-WinEvent` / `Get-CimInstance` `[PS-11]` |
| Cmdlet returns fewer results than expected | Graph and some cmdlets paginate by default | Add `-All` |

### Networking and infrastructure

| Symptom | Actual cause | Fix |
|---|---|---|
| Random client loses network / duplicate IP | **DHCP pool overlaps the static infrastructure range** | Add an exclusion range, or start the pool above the static block `[BUILD-P4]` |
| Everything dies across the whole site at once, server logs show nothing | A client was leased the domain controller's IP | Same as above. **This is the failure mode of the pool overlap.** |
| Client got a 169.254.x.x address | DHCP failed — no server reachable | Check scope exhaustion, VLAN assignment, DHCP relay |
| VM cannot reach the LAN | Attached to the Hyper-V **Default Switch**, which is NAT | Attach to an **External** virtual switch `[WIN-05]` |
| Host loses internet after creating a vSwitch | Host now routes through the new `vEthernet` adapter with no DNS set | **Set DNS on the vEthernet adapter** |
| Short names don't resolve but FQDNs do | DHCP option 15 missing, or conflicting with an appliance "Search Domain" field | Set both to the AD domain `[NET-10]` |
| Domain resolves to a public IPv6 address | DC registered ISP-assigned global IPv6 in AD-integrated DNS | **Fix at the router.** Do NOT unbind IPv6 from the DC. `[BUILD-P2]` |
| Intermittent failures after "fixing" IPv6 | Stale AAAA records persist in the zone | Delete the AAAA records, `ipconfig /registerdns`, restart netlogon |

### Windows client

| Symptom | Actual cause | Fix |
|---|---|---|
| OOBE will not offer a local account | Windows 11 requires an MSA; **BYPASSNRO and ms-cxh:localonly are both blocked as of 2026** | Use **"Domain join instead"** on Pro/Enterprise, or Rufus/unattend media `[WIN-OOBE]` |
| Cannot join the domain — Windows edition | **Windows 11 Home cannot join a domain** | Upgrade to Pro or Enterprise |
| Machine demands BitLocker recovery key at boot | A firmware/BIOS/TPM update changed the sealed measurements | Suspend BitLocker **before** firmware updates `[DISK-03]` |
| External drive missing from File Explorer | BitLocker partition deleted; space is Unallocated with no file system | Disk Management or diskpart `[DISK-02]` |
| Server begins shutting down on a schedule | **Windows Server Evaluation expired (180 days)** | `slmgr /dlv`. **Cannot convert while a DC — demote, convert, re-promote** `[BUILD-P0]` |
| Domain controller missing from `OU=Servers` | **Not a fault.** DCs live in the built-in Domain Controllers OU. | **Leave it.** Moving a DC out breaks its default policy. `[BUILD-P13]` |
| `sfc /scannow` reports unrepairable corruption | The component store itself is damaged | Run `DISM /Online /Cleanup-Image /RestoreHealth` **first**, then SFC `[WIN-06]` |

### Microsoft 365, identity, and licensing

| Symptom | Actual cause | Fix |
|---|---|---|
| License assignment fails with no useful message | **Usage location not set**, or no seats available | Set usage location on the user; check `Licenses → Errors & Issues` `[M365-13]` |
| Group-based licensing licenses **nobody** | **Nested groups are not supported** — only first-level members are licensed, silently | License the leaf groups, not the umbrella `[M365-13]` |
| User is licensed but the feature is missing | A **service plan** inside the license is disabled | Users → Active users → Licenses and apps → expand the license `[M365-13]` |
| "It works at the office but not at home" | A **Conditional Access** location or device condition | Read the CA outcome in the **sign-in log** — it names the policy `[M365-14]` |
| TOTP codes are always rejected | **Device clock drift** — TOTP depends on synchronized time | Enable automatic time sync on the device `[M365-19]` |
| An old mail client cannot connect | **Legacy authentication** (POP/IMAP/SMTP AUTH) is blocked | Move the user to a modern-auth client. **Do not re-enable legacy auth** `[M365-19]` |
| Cannot create a Conditional Access policy | **Security defaults are enabled** — the two are mutually exclusive | Turn security defaults off, **after** creating break-glass accounts `[M365-14]` |
| A working integration suddenly fails, nothing changed | **Client secret expired** on the app registration | Rotate the secret or move to a certificate `[M365-16]` |
| Deleting a Team also deleted the files | **Every Team is backed by a Microsoft 365 group** that owns the SharePoint site | Restore the group within the deleted-groups window `[M365-10]` |
| A site-scoped policy misses content | **Private and shared channels each have their own SharePoint site** | Scope the policy to the channel sites too `[M365-11]` |
| Audit search returns nothing for a known event | Auditing disabled, wrong role, or **past the 180-day Standard retention** | Verify with a recent known activity; check the Audit Logs role `[M365-18]` |

### Purview and Copilot

| Symptom | Actual cause | Fix |
|---|---|---|
| DLP policy generates unmanageable false positives | Keyed off a **pattern-matching SIT** where the data needs **EDM**, or never run in simulation | Re-run in simulation, tune, or switch to EDM `[PURV-02]`, `[PURV-04]` |
| Content that should have been deleted is still there | **Retention beats deletion; longest retention wins** — another policy or a hold applies | Check for overlapping policies and holds. This is by design `[PURV-07]` |
| Releasing a legal hold caused a mass deletion | Retention timers were suspended by the hold and applied **immediately** on release | Expected behavior. Confirm closure with Legal **in writing before** releasing `[PURV-07]` |
| Runbook references eDiscovery "Standard" or "Premium" | **Classic eDiscovery retired 31 August 2025** — one unified case-based experience now | Rewrite against cases; Content Search lives in a system-generated case `[PURV-08]` |
| Copilot surfaced a document the user should not have seen | **Pre-existing oversharing.** Copilot bypassed nothing | Permissions remediation; RCD as immediate containment `[AI-03]`, `[AI-07]` |
| Copilot cannot use a file the user **can** open | **Sensitivity label encryption denies EXTRACT rights**, or a DLP-for-AI policy excludes that label | Check the label's usage rights and AI-scoped DLP `[AI-02]` |
| RCD enabled, content still appears in Copilot | **Reindexing incomplete** (up to 24h, longer on very large sites), or the user owns / recently opened the file | Wait and re-verify with `Get-SPOSite`. RCD is partial by design `[AI-06]` |
| Copilot meeting recap will not generate | **Teams meeting transcription is disabled by policy** | Teams admin center → meeting policy → enable transcription `[M365-12]` |
| Copilot answers are vague or cite superseded documents | **Data estate quality** — stale content, no metadata, duplicates | Retention cleanup and content lifecycle. Not a Copilot fault `[AI-01]` |
| Billing policy created but PAYG agents still unavailable | **Step 2 missing** — the policy was never connected to a service | Copilot → Billing & usage → **Pay-as-you-go services** tab `[AI-10]` |
| User cannot create an agent in Copilot Studio | Has the license but **no Environment Maker role**, or the reverse | **Both are required** `[AI-14]` |
| The Agent icon vanished from a SharePoint site | **RCD is enabled** — it disables agent features on that site | Expected. Remove RCD only if the agent is required `[AI-06]` |
| Cannot disable Researcher or Analyst for a group | **Microsoft-managed agents cannot be controlled via availability settings** | Availability settings are not the mechanism `[AI-14]` |
| Two users get different answers from one agent | **Correct** — agents respect per-user permissions | Explain it; do not "fix" it `[AI-15]` |

### Public DNS and mail flow

| Symptom | Actual cause | Fix |
|---|---|---|
| Can send email out, **cannot receive** | Domain verified but not configured — no MX record | Publish the full record set `[DNS-MAIL-00]` |
| Bounce: `Status: 4.4.1`, `connect to domain[IP]:25: Connection timed out` | No MX record; sender fell back to the apex A record (implicit MX) and hit a web server | Publish MX. **`4.x.x` is transient — the sender is still retrying** `[DNS-MAIL-08]` |
| Every DNS record appears to exist, including ones you never created | **Wildcard `*` CNAME in the zone** | Delete the wildcard, re-test. Nothing verified before this is trustworthy `[DNS-MAIL-02]` |
| `Select-Object : Property "Strings" cannot be found` on a TXT lookup | The name returned a **CNAME** (wildcard), not a TXT. `DnsRecord_PTR` has `NameHost`, not `Strings` | **Not a syntax error — the record does not exist** `[DNS-MAIL-02]` |
| MX query returns columns named `PrimaryServer` / `SerialNumber`, Section = **Authority** | **NODATA** — the name exists, no record of that type. The SOA is the proof | Publish the MX record `[DNS-MAIL-02]` |
| Nameserver change made, nothing happens; provider still reports the old nameservers | NS records added **inside the zone** instead of changing the **registrar delegation** | Change the nameserver field on the registrar's domain page; delete the misplaced NS records `[DNS-MAIL-03]` |
| **SERVFAIL from one public resolver, clean answer from another** | DNSSEC: cached DS record at the parent, zone no longer signing | Verify no DS at the parent; wait out the cache; **dnsviz.net** for the full chain `[DNS-MAIL-04]` |
| M365 domain wizard: *"We've detected that [domain] has DS records... DNSSEC is not supported by Microsoft 365 DNS hosting"* | Delegating a DNSSEC-signed zone to Microsoft 365-hosted DNS | Remove DS at the registry first, **then** stop signing — or keep DNS at the registrar and add records manually. **Azure Public DNS is a different product and does support DNSSEC** `[DNS-MAIL-04]` |
| DKIM status stuck on `CnameMissing` with records that look correct | Target built by hand and missing the trailing `.com`, or the wrong format for the domain's vintage | Read the values from the portal or `Get-DkimSigningConfig`. **Never construct them** `[DNS-MAIL-05]` |
| DKIM CNAMEs published, `dkim=pass header.i=@tenant.onmicrosoft.com` | **Custom domain not signing** — the tenant initial domain is. Passes DKIM, fails DMARC alignment | Enable the domain in Defender → Email authentication settings → DKIM `[DNS-MAIL-05]` |
| SPF suddenly stopped authorizing anything | Two `v=spf1` records at the apex (**permanent error**), or the 10-lookup limit exceeded | Merge into one record; count the lookups including nested includes `[DNS-MAIL-06]` |
| Mail from the copier / CRM / website form started bouncing after "we fixed SPF" | `-all` published before the sender inventory was complete | Revert to `~all`, inventory via DMARC `rua`, then re-enforce `[DNS-MAIL-06]` |
| Gmail reports `DMARC: FAIL` while SPF and DKIM pass | No `_dmarc` record published | Publish `v=DMARC1; p=none; rua=...` `[DNS-MAIL-07]` |
| DMARC reports never arrive at an external mailbox | Missing authorization record on the destination domain | Publish `<monitored-domain>._report._dmarc` TXT `v=DMARC1` on the destination `[DNS-MAIL-07]` |
| Forwarded mail started being rejected after DMARC enforcement | **Forwarding breaks SPF.** With `p=reject` and no aligned DKIM, every forward fails | Verify DKIM is signing the custom domain and aligned **before** `p=reject` `[DNS-MAIL-07]` |

### Exchange Online

| Symptom | Actual cause | Fix |
|---|---|---|
| Trace says **Delivered**, user cannot find the message | Inbox rule, Sweep rule, Junk folder, or client-side rule — **after** delivery | **The trace ends at the mailbox door. Pivot to the mailbox** `[EXO-01]` |
| Message missing; trace shows **Quarantined** | Anti-spam policy action | Whether the user can self-release depends on the **quarantine policy**, a separate object `[EXO-06]` |
| Message missing; trace shows **FilteredAsSpam** | Delivered to Junk Email | **User can retrieve it themselves** `[EXO-02]` |
| User cannot release a quarantined phishing message no matter what you configure | **High confidence phishing is always quarantined under `AdminOnlyAccessPolicy`** and users can never self-release it | By design. Release it as an admin `[EXO-06]` |
| Unexplained **Drop** event in a trace | `LED=250 2.1.5 RESOLVER.GRP.Expanded` — parent group recipient retired after fan-out | **Benign. Expand the row and read the reason** `[EXO-03]` |
| Member of a distribution list did not receive a message | Only the group address was traced | **Two searches required** — group address for `Expand DL`, member address for their copy `[EXO-03]` |
| Message trace times do not match the firewall log or the user's clock | Header labels the **standard** offset while rendering **daylight** time | **Correlate in UTC** `[EXO-05]` |
| Need the original client IP for a message from three weeks ago | **Client IP is retained 10 days**, and only in the Enhanced summary / Extended report | Gone. Pull source IP inside ten days or not at all `[EXO-01]` |
| Exchange Online PowerShell starts refusing connections mid-afternoon | Leaked sessions against the per-tenant connection limit | `Disconnect-ExchangeOnline` every time. Close stale consoles `[EXO-00]` |
| `Install-Module` fails with a TLS error on Windows PowerShell 5.1 | Gallery refuses protocols below TLS 1.2 | `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12` `[EXO-00]` |
| Delegate can read a shared mailbox but cannot send from it | Full Access granted, **Send As not granted** — they are independent | Grant Send As separately `[EXO-08]` |
| Send on Behalf configured but never appears | The account **also holds Send As**, which wins | Remove Send As if attribution is the goal `[EXO-08]` |
| Team keeps double-replying from a shared mailbox | Sent copies land only in each delegate's own Sent Items | `Set-Mailbox -MessageCopyForSentAsEnabled $true` **and** the SendOnBehalf switch. Not retroactive `[EXO-08]` |
| Shared mailbox did not automap into Outlook | Permission granted **through a group** — automapping only fires on direct grants | Expected. Add manually, or grant directly `[EXO-08]` |
| Shared mailbox account can sign in | Someone enabled it "to make it easier" — **the sign-in block is the security control** | Re-block. Audit every shared mailbox in an inherited tenant `[EXO-08]` |
| Delegate granted Send on Behalf, recipient sees no "on behalf of" | Recipient's client does not surface the `Sender:` header (Gmail's summary does not) | Expected. **Attribution lives in the audit log, not the rendering** `[EXO-09]` |
| Cannot identify which delegate sent a message | **Send As replaces the sender** — the trace shows only the mailbox | Mailbox auditing / unified audit log, not message trace `[EXO-09]` |
| Cannot add a distribution group to a mailbox permission | It is not a security principal | Use a mail-enabled security group `[EXO-10]` |
| An internal all-staff list is receiving mail from the internet | *Allow external senders* left on | Turn it off. **This is a live phishing vector** `[EXO-10]` |
| Users are adding themselves to a group that carries file access | Group join policy set to **Open** on a mail-enabled security group | Set to Closed. **Self-service privilege escalation** `[EXO-10]` |
| Cannot mail-enable an existing AD group | **Only universal groups can be mail-enabled** — global and domain-local cannot | `Set-Group` to convert scope, or create a separate universal group `[EXO-11]` |
| Group membership field grayed out in EAC | Object is synced from on-premises AD | Manage in ADUC, then sync. Check `IsDirSynced` `[EXO-12]` |
| Alias change in the M365 admin center: **Add** button grayed out, banner about local AD | Synced object — the cloud is read-only for these attributes | Edit `proxyAddresses` in AD, `Start-ADSyncSyncCycle -PolicyType Delta` `[EXO-13]` |
| Address change appears to save, then **reverts within the hour** | Cloud edit on a synced object, overwritten by the next sync cycle | Make the change in AD `[EXO-12]` |
| New address works everywhere except one application | On-premises **`mail`** attribute not updated — separate from `proxyAddresses` | Update `mail` as well `[EXO-13]` |
| Mailbox loses its `onmicrosoft.com` or `SIP:` address | `Set-ADUser -Replace` used on `proxyAddresses`, overwriting the whole array | Restore the entries. **Always use `-Add`** `[EXO-13]` |
| *"I changed my email but it says my password is wrong"* | **UPN ≠ primary SMTP.** They are typing the new address at the sign-in prompt | Explain the distinction; align the UPN deliberately if appropriate `[EXO-14]` |
| A cloud-only user can no longer sign in with their own UPN | **Email as alternate login ID** enabled, and their UPN collides with another user's synced proxy address | Documented collision behavior of the preview feature `[EXO-14]` |
| `Get-ADUser` shows an attribute as empty that you know is populated | **`-Properties` not specified** — the cmdlet returns a minimal default set | Add `-Properties mail,proxyAddresses` `[EXO-13]` |
| Spam filter test using GTUBE does not trip | GTUBE is **not documented as supported by EOP** | Use a blocked sender, or a mail flow rule stamping SCL 9 `[EXO-07]` |

### SharePoint Online, OneDrive, and external sharing

| Symptom | Actual cause | Fix |
|---|---|---|
| Sharing invitation never arrives — **not even in spam** | People picker resolved to an **internal** directory object, not the address typed | **Read the confirmation dialog — it names the recipient** `[SPO-06]` |
| Sharing invitation not received, address typed correctly | Sender's **Entra profile Email property is empty** (separate from mailbox SMTP), or the message was flagged as spam | Populate Entra → user → Contact Information → Email; check Junk `[SPO-05]` |
| No trace of a sharing invitation in message trace | Sent by SharePoint infrastructure from `no-reply@sharepointonline.com`, not through Exchange Online | **Do not use message trace for this** `[SPO-05]` |
| Tenant sharing set to **Anyone**, Anyone link still not offered | Separate **File and folder links** setting, or a more restrictive site-level setting | Check tenant slider → File and folder links → site-level `[SPO-01]` |
| *"Your organization's policies do not allow you to share with these users"* | External sharing off at the tenant or site level | **Diagnose top down** — tenant, then site, then item `[SPO-01]` |
| OneDrive sharing is more permissive than SharePoint | The two sliders are **set independently** and sit side by side | Set both deliberately `[SPO-01]` |
| External user has access but never knew | Guest created, invitation delivery failed — **separate steps** | Verify the guest object exists; deliver the link another way `[SPO-03]` |
| **Manage access** option missing on a file | Missing **SharePoint Administrator** role | Grant that role specifically — **not a stack of admin roles** `[SPO-08]` |
| Breaking inheritance appears to do nothing | Correct — it **copies** the current permissions and stops future flow-down | Expected. **Step two is removing what should not be there** `[SPO-04]` |
| Guest consent screen: *"has not provided links to their terms"* | Privacy statement URL not configured | Entra → External Identities → user settings `[SPO-03]` |
| A file was shared to the break-glass account by accident | Break-glass account has a **person-like display name** and appears in people pickers | Rename the display name — **never the UPN** `[SPO-07]` |
| Client on Business Premium asks for just-in-time admin elevation | **PIM requires Entra ID P2; Business Premium includes P1** | No workaround. Separate admin account is the approximation — say so `[SPO-08]` |

### Purview — labels and DLP
| Symptom | Actual cause | Fix |
|---|---|---|
| Sensitivity label created but invisible to users | **Created is not published** — a separate step under Label policies | Publish it; allow up to 24 h; **check OWA before desktop** `[PURV-15]` |
| Label published, still not in the dropdown after 24 h | Label policy **scope does not include that user** | Check the policy's scope `[PURV-15]` |
| DLP policy tip fires, trace shows DLP rule events, **data still leaves unprotected** | **Policy is in simulation mode** | Switch to enforcement. **Verify at the recipient, not at the policy tip** `[PURV-17]` |
| DLP policy fires but the message still reaches the recipient | Action is **Encrypt**, not **Block** — Encrypt wraps and delivers | Change the action if the requirement is "must not leave" `[PURV-18]` |
| No DLP alerts in Purview despite confirmed matches | Reporting pipeline is **batched (hours)**; simulation results appear only in the policy's own view | Check the policy's simulation results; wait `[PURV-19]` |
| Admin never received a DLP alert but the user got a policy tip | **Two separate notification paths**, two toggles | Enable `Send alerts to Administrator` on the rule `[PURV-19]` |
| Sensitivity label used as a DLP condition never matches | Advanced DLP condition — not evaluated below E5. **Saves cleanly, never fires** | Rebuild on sensitive information types, or upgrade `[PURV-14]` |
| Auto-labeling not available in the portal | Not licensed at E3 / Business Premium — **recommended labeling is also P2** | E5 / AIP P2 required `[PURV-14]` |
| Told a client label encryption needs E3 or E5 | **Wrong — Business Premium includes AIP P1**, which covers RMS encryption and visual markings | Correct it before it becomes a quoted upgrade `[PURV-14]` |
| More DLP rule events in a trace than policies you created | **Microsoft-provisioned default policies ship enabled** in newer tenants | Inventory Purview → DLP → Policies in full `[PURV-19]` |

---

## 19 — SCRIPT LIBRARY AND TOOLKIT PATTERN `[TOOLKIT]`

Typing a forty-line PowerShell block into a console for every client is not sustainable, and it is a syntax error waiting to happen.

**The principle: write the logic once, keep the client-specific values outside the logic, and never edit the script itself again.**

### `[TOOLKIT-01]` Directory layout

Keep this in a **private Git repository** (also fine on a USB stick or OneDrive, but Git gives you version history and rollback). Every client gets a config file; **the scripts are identical everywhere.**

```
Toolkit\
├── config\
│   ├── contoso.psd1
│   └── acme.psd1
├── scripts\
│   ├── New-LabOUStructure.ps1
│   ├── New-LabGroups.ps1
│   ├── New-LabFileShares.ps1
│   ├── New-LabUsers.ps1
│   └── Test-LabHealth.ps1
└── input\
    └── users-contoso.csv
```

### `[TOOLKIT-02]` The client config file

A `.psd1` is a PowerShell **data file** — a hashtable, no executable code. **It is the only file you edit per client.**

```powershell
# config\contoso.psd1
@{
    DomainDN    = "DC=ad,DC=contoso,DC=com"
    OrgOU       = "Contoso"
    UPNSuffix   = "contoso.com"
    NetBIOS     = "CONTOSO"
    FileServer  = "SITE-DC01"
    ShareRoot   = "D:"
    HomeShare   = "\\SITE-DC01\Home"
    Departments = @("Sales","Accounting","IT")
}
```

Load it with one line:
```powershell
$Cfg = Import-PowerShellDataFile ".\config\contoso.psd1"
$Cfg.UPNSuffix        # contoso.com
```

### `[TOOLKIT-03]` A parameterised script

```powershell
# scripts\New-LabUsers.ps1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$ConfigPath,
    [Parameter(Mandatory)][string]$UserCsv,
    [string]$OutputPath = "C:\Temp\NewUsers.csv"
)

Import-Module ActiveDirectory
$Cfg = Import-PowerShellDataFile $ConfigPath
$OU  = "OU=Employees,OU=$($Cfg.OrgOU),$($Cfg.DomainDN)"

function New-StrongPassword {
    $chars = 'abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@#$%'
    -join ((1..16) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}

$Report = foreach ($U in (Import-Csv $UserCsv)) {
    if (Get-ADUser -Filter "SamAccountName -eq '$($U.Sam)'" -ErrorAction SilentlyContinue) {
        Write-Warning "$($U.Sam) already exists - skipping"
        continue
    }
    $Password = New-StrongPassword
    if ($PSCmdlet.ShouldProcess($U.Sam, "Create AD user")) {
        try {
            $Params = @{
                Name                  = "$($U.First) $($U.Last)"
                GivenName             = $U.First
                Surname               = $U.Last
                SamAccountName        = $U.Sam
                UserPrincipalName     = "$($U.Sam)@$($Cfg.UPNSuffix)"
                DisplayName           = "$($U.First) $($U.Last)"
                Department            = $U.Dept
                Path                  = $OU
                AccountPassword       = (ConvertTo-SecureString $Password -AsPlainText -Force)
                Enabled               = $true
                ChangePasswordAtLogon = $true
                HomeDrive             = "H:"
                HomeDirectory         = "$($Cfg.HomeShare)\$($U.Sam)"
            }
            New-ADUser @Params
            Add-ADGroupMember -Identity $U.Group -Members $U.Sam
            Write-Host "Created $($U.Sam)" -ForegroundColor Green
            [PSCustomObject]@{
                User     = $U.Sam
                UPN      = "$($U.Sam)@$($Cfg.UPNSuffix)"
                Password = $Password
            }
        }
        catch { Write-Host "FAILED $($U.Sam): $_" -ForegroundColor Red }
    }
}

$Report | Export-Csv $OutputPath -NoTypeInformation
Write-Host "`nCredentials at $OutputPath - deliver securely, then DELETE." -ForegroundColor Yellow
```

**The input file:**
```csv
Sam,First,Last,Dept,Group
jsmith,John,Smith,Sales,GG-Sales
sjohnson,Sarah,Johnson,Accounting,GG-Accounting
```

**Running it:**
```powershell
# Dry run first — shows what would happen, changes nothing
.\scripts\New-LabUsers.ps1 -ConfigPath .\config\contoso.psd1 -UserCsv .\input\users-contoso.csv -WhatIf

# For real
.\scripts\New-LabUsers.ps1 -ConfigPath .\config\contoso.psd1 -UserCsv .\input\users-contoso.csv
```

### `[TOOLKIT-04]` Why each piece is there

| Element | What it buys you |
|---|---|
| `param()` with `[Parameter(Mandatory)]` | PowerShell **prompts** for anything missing rather than failing halfway through |
| `SupportsShouldProcess` | **Gives you `-WhatIf` free.** Dry-run any destructive script before committing. Use on **every** script that writes. |
| Splatting (`@Params`) | **Kills the backtick continuation problem entirely.** No line-continuation characters, no trailing-whitespace failures, and the parameters stay readable. |
| CSV input | Onboarding 40 users is the same effort as onboarding 2. **The client can even fill in the CSV.** |
| Existence check + `continue` | **Idempotent** — safe to re-run after a partial failure |
| `try`/`catch` per item | **One bad row does not abort the other 39** |
| Config file separate from logic | New client = one new `.psd1`. The scripts never change, **so they never accumulate client-specific bugs.** |

### `[TOOLKIT-05]` Getting them to run

```powershell
Get-ChildItem .\scripts\*.ps1 | Unblock-File                    # clear mark-of-the-web
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass       # this session only
```

**Do not set `Bypass` machine-wide on a client's server.** `RemoteSigned` is the correct persistent setting if one is needed.

### `[TOOLKIT-06]` Build order for your own toolkit

**Do not try to write all of these at once. Convert one procedure per session, starting with what you type most often.**

| Order | Script | Covers |
|---|---|---|
| 1 | `New-LabUsers.ps1` | Longest to type, most repeated |
| 2 | `New-LabGroups.ps1` | Both group tiers plus nesting `[AD-AGDLP]` |
| 3 | `New-LabOUStructure.ps1` | OUs plus `redircmp` / `redirusr` `[BUILD-P5]` |
| 4 | `New-LabFileShares.ps1` | Folders, shares, ABE, NTFS `[FILE-03]` |
| 5 | **`Test-LabHealth.ps1`** | The `[ASSESS-01]` discovery block, wrapped as one command |

**That last one is the sleeper.** A single script that runs every health check and dumps a timestamped report is the thing you will actually use every week once you are working a queue.

### `[TOOLKIT-07]` Useful script categories to build over time

UPN migration · bulk onboarding · bulk offboarding · group membership audit · license reporting · Exchange mailbox reporting · Intune device reporting · SharePoint permission review · stale account cleanup · ACL export/compare.

---

## 20 — DOCUMENTATION TEMPLATES `[DOC]`

### `[DOC-01]` Ticket

```
Issue:

User Impact:

Environment:
  - Device:
  - User:
  - Service:
  - OS / version:

Troubleshooting Performed:
  1.
  2.
  3.

Root Cause:

Resolution:

Validation:            <-- how you PROVED it was fixed, not "user says it works"

Follow-up Needed:
```

### `[DOC-02]` Escalation

```
Reason for Escalation:

What has been verified:      <-- what you RULED OUT matters as much as what you found

Commands / tools used:

Exact error messages:        <-- verbatim, not paraphrased

Screenshots / logs attached:

Business impact:

Urgency:

What I recommend / what I need decided:
```

### `[DOC-03]` Knowledge base entry

```
Title:

Symptoms:

Environment:

Cause:

Resolution Steps:
  1.
  2.

Commands Used:

Validation:

Prevention:

Date Learned:
Source:
```

### `[DOC-04]` Personal lessons-learned entry

```
Date:
Client / Environment:
Issue:
Symptoms:
Root Cause:
Fix:
Commands Used:
What I Learned:
Prevention / Future Note:
Was this a workaround or a fix?      <-- if workaround, what is the real fix?
```

### `[DOC-05]` Client handover package — the deliverables list

- [ ] Network topology diagram, one page, current
- [ ] IP and hostname register
- [ ] AD structure: OUs, groups, and **what each group grants**
- [ ] GPO register: name, link, purpose, last reviewed
- [ ] Credential vault entries, complete, **including DSRM and break-glass**
- [ ] Runbooks — the SOPs relevant to this environment
- [ ] Licensing register: what is owned, what it entitles, renewal dates
- [ ] Evaluation and certificate expiry dates, **with calendar reminders set**
- [ ] Backup configuration and **the date a restore was last tested**
- [ ] Monitoring and alerting configuration
- [ ] Known issues and accepted risks, signed off by the client

---

## 21 — APPENDICES

### `[APX-A]` Pre-flight checklists

**Before promoting a domain controller**
- [ ] Server fully patched and rebooted
- [ ] Renamed to its final hostname
- [ ] Static IP configured, DNS pointing correctly
- [ ] Correct time zone, clock accurate within one minute
- [ ] If virtual: **host time synchronization disabled**
- [ ] If additional DC: already joined as a member server, existing directory verified healthy
- [ ] DSRM password chosen and **recorded in the vault**

**Before joining the first client**
- [ ] OU structure built, **`redircmp` and `redirusr` run**
- [ ] Security groups created, **both tiers**
- [ ] Shares created and permissioned, ABE enabled, **tested with a test account — positively and negatively**
- [ ] All GPOs built and validated against one test user and one test machine
- [ ] **UPN suffix added before any real user was created**
- [ ] DHCP handing out the correct DNS servers
- [ ] Licensing group created, SKU attached, **and populated**

**Before changing a client's public DNS**
- [ ] Current zone **exported or screenshotted** — most registrar editors have no undo
- [ ] Existing TTLs recorded; **lowered to 300 the day before a planned cutover**
- [ ] Authoritative nameservers confirmed with an NS query — `[DNS-MAIL-01]`
- [ ] **DNSSEC status checked** — `[DNS-MAIL-04]`
- [ ] **Wildcard records checked for** — every verification is unreliable until this is answered — `[DNS-MAIL-02]`
- [ ] Every system that sends as the domain inventoried — `[DNS-MAIL-06]`
- [ ] **Change window agreed with the client, and the client told what to expect**

**Before declaring a build complete**
- [ ] System State backup running **and a restore tested**
- [ ] AD Recycle Bin enabled
- [ ] External time source configured on the PDC emulator
- [ ] LAPS deployed **and a password successfully retrieved**
- [ ] **Failover tested correctly** — never-before-used account, DC01 off
- [ ] Documentation package complete
- [ ] Monitoring and backup alerting configured
- [ ] Licensing and evaluation expiry dates on a calendar

### `[APX-B]` Least privilege reminders `[SEC-LP]`

- **Use the lowest admin role needed for the task.** Avoid Global Administrator for routine actions unless specifically required.
- **Separate accounts:** daily user account · admin account · break-glass account. Three identities, not one.
- **Never browse the internet or read email from a domain controller or a Tier 0 server.**
- **MFA on every administrator**, no exceptions except the break-glass account (which is excluded from CA policies but secured with a hardware key and alerted on).
- **Domain Admins should be nearly empty** and reviewed quarterly.
- **Prefer Contributor over Owner** in Azure for a working account.
- Direct license assignments and direct ACL entries both survive group removal — **use them for diagnosis, then remove them.**

### `[APX-C]` Corrections applied when this manual was compiled

These are things I found wrong, outdated, or misleading in the source material. They are recorded so you can un-learn them.

| # | Claim in source material | Correction | Verified |
|---|---|---|---|
| 1 | A "modern Entra Connect Sync engine" uses `ConnectSync.exe /SyncCycle Delta`, installed at `C:\Program Files\Microsoft Entra Connect Sync\ConnectSync\` | **This does not exist.** Microsoft Entra Connect Sync **is** the renamed Azure AD Connect. It uses the **`ADSync` PowerShell module** and `Start-ADSyncSyncCycle -PolicyType Delta`. Sync engine path is still `C:\Program Files\Microsoft Azure AD Sync\`. The genuinely different second product is **Entra Cloud Sync**, which is agent-based and configured in the portal. | Microsoft Learn, Aug 2026 |
| 2 | `OOBE\BYPASSNRO` (and its replacement `start ms-cxh:localonly`) create a local account at Windows 11 OOBE | **Both are blocked in current builds.** `bypassnro.cmd` was removed from the image in 2025; `ms-cxh:localonly` and the registry toggle were subsequently blocked too. Working methods are **"Domain join instead"** on Pro/Enterprise, or customized media (Rufus / `unattend.xml`). | Multiple sources, 2025–2026 |
| 3 | Storage durability: LRS 99.99999999999% (13 nines), ZRS 99.999999999999% (14 nines) | **LRS is 11 nines** (99.999999999%), **ZRS is 12 nines** (99.9999999999%), GRS and GZRS are 16 nines. **Memorize the ranking, not the decimals.** | AZ-900 source, already corrected in-document |
| 4 | Redundancy options (LRS/GRS/ZRS/GZRS) are "storage account types" | **They are two separate choices at account creation.** Account **type** = Standard general-purpose v2, Premium block blobs, Premium file shares, Premium page blobs. Redundancy **option** = LRS/ZRS/GRS/GZRS/RA-GRS/RA-GZRS. | Same |
| 5 | Azure CLI is "Bash-based" | Azure CLI is a **cross-platform tool** whose commands begin with `az`. It runs in Bash, PowerShell, CMD, or Cloud Shell. Cloud Shell offers two *shell environments*; the CLI runs in either. **The distinction is syntax, not host shell.** | Same |
| 6 | Share the folder with `Everyone` = Change permission | Use **`Authenticated Users` = Full Control** at the share layer and put all real control in NTFS. `Everyone` includes anonymous/guest contexts. | `[FILE-02]` |
| 7 | Set NTFS then check "Replace all child object permission entries" | **Destructive and irreversible on any existing tree.** Use "Convert inherited permissions into explicit permissions," then remove what does not belong. | `[FILE-02]` |
| 8 | `wmic product get name,version` to list installed software | `Win32_Product` triggers an **MSI reconfiguration of every installed product** — slow, and it writes event log noise. `wmic` itself is deprecated and no longer installed by default. Use the registry Uninstall-key query. | `[WIN-INV]` |
| 9 | `Get-EventLog` and `Get-Package` as general-purpose tools | `Get-EventLog` does not exist in PowerShell 7 — use `Get-WinEvent`. `Get-Package` misses most MSI/EXE installs. | `[PS-11]` |
| 10 | `MSOnline` / `AzureAD` modules for tenant administration | **Both retired.** Use `Microsoft.Graph`. Guides showing `Set-MsolDirSyncEnabled` or `Get-AzureADUser` will fail. | `[M365-01]` |
| 11 | Unbind IPv6 from the adapter to fix a DC resolving to public IPv6 | **Microsoft advises against disabling IPv6 on domain controllers.** Fix the router advertisement, then clean up the stale AAAA records. | `[BUILD-P2]` |
| 12 | Powering off DC01 and logging in successfully proves failover works | **It proves cached credentials work.** Real failover requires DNS listing both DCs and an account that has never logged into that machine. | `[AD-FAILOVER]` |
| 13 | The Intune Management Extension is required for a Microsoft 365 Apps deployment | **It is not in that path at all.** M365 Apps uses the Office CSP over the MDM channel. | `[MDM-02]` |
| 14 | AZ-900 exam mechanics (passing score, time limit, question count, domain weighting) | **Stripped.** You have passed the exam; the principles are retained in Section 12 and the exam scaffolding is gone. | Per your instruction |
| 15 | "Paid regions" receive updates one at a time | The term is **paired regions**. The whole concept is that Azure never updates both halves of a pair simultaneously. | AZ-900 source |
| 16 | "Life-and-shift migration" | **Lift-and-shift.** It is a keyword that signals IaaS / Azure Virtual Machines. | AZ-900 source |
| 17 | `"authn" → Authentication`, `"authnz" → Authorization` | **`authn` and `authz`.** The convention is the first and last letter of each word. **`authnz` is not a standard term** — it appears only as informal shorthand for the pair. See `[SECF-08]`. | Google IT Support notes |
| 18 | A hash function's output is "unique to the input, such that two different inputs should never yield the same output" | **Mathematically impossible.** Unbounded input, fixed-size output — collisions must exist by the pigeonhole principle. The real property is **collision *resistance***: finding a collision must be computationally infeasible. This is exactly why MD5 (2008) and SHA-1 (2017) were retired. See `[SECF-05]`. | Same |
| 19 | OAuth is a way for users to log in | **OAuth 2.0 is an authorization framework, not authentication.** **OpenID Connect** is the authentication layer built on it. The gap between the two is what illicit consent grant attacks exploit — and **MFA does not stop them**. See `[SECF-12]`. | Same |
| 20 | "Round Robin" listed as a DNS resource record type alongside A, CNAME, MX | **Not a record type.** It is a *behavior* — multiple A records for one name returned in rotating order. Crude load distribution with **no health checking**. See `[NETF-10]`. | Same |
| 21 | The SAM is "a database in Windows that stores usernames and passwords" | **It stores password *hashes*.** The distinction is the whole basis of **pass-the-hash**: a hash is usable directly without cracking, which is why local admin password reuse is catastrophic and why LAPS exists. See `[SYSF-05]`. | Same |
| 22 | "There are 13 root name servers" | **13 root server *addresses* (A–M)**, served by **well over a thousand physical instances** worldwide via anycast. The 13 limit came from original UDP packet size constraints, not from server count. See `[NETF-10]`. | Same |
| 23 | "Rootkit: a collection of software or tools that an admin would use." · "Logic bomb: malware that is intentionally installed." | Both omit the defining property. A **rootkit** conceals privileged access; concealment *is* the definition. A **logic bomb** fires on a **conditional trigger**; intentional installation distinguishes nothing. See `[SECF-01]`. | Same |
| 24 | Wi-Fi generation names given as Wi-Fi 0/1/2/3 for 802.11 legacy/b/a/g; 802.11ac ratified 2015 | **Wi-Fi Alliance branding starts at Wi-Fi 4 (802.11n).** Lower numbers are informal and appear on no datasheet. **802.11ac was ratified in 2013** ("wave 2" products arrived 2015–16). Wi-Fi 6 certification began 2019; the standard was ratified 2021. See `[NETF-13]`. | Same |
| 25 | SSL and TLS presented as two current, interchangeable protocols | **SSL is dead.** SSL 2.0 and 3.0 are prohibited; **TLS 1.0 and 1.1 were deprecated in 2021 (RFC 8996)**. Current: **TLS 1.2 and 1.3**. The artifact is an **X.509 certificate**; "SSL certificate" survives only as marketing. See `[NETF-17]`. | Same |
| 26 | WEP described as providing "a very low level of privacy"; MAC filtering presented as a security measure | **WEP is completely broken** — crackable in minutes; treat a WEP network as open. **MAC filtering is not a security control** — MACs cross the air unencrypted in every frame and are spoofed in one command. Source also omits **WPA2 and WPA3 entirely**. See `[NETF-13]` and `[SECF-14]`. | Same |
| 27 | "Agent 365 is currently in Preview" | **Microsoft Agent 365 reached general availability on 1 May 2026** — approximately USD 15 per user per month, included in **Microsoft 365 E7**. At GA the **Agent registry and Agent collections blades in the Entra admin center were retired**, with agent inventory now surfaced in the Microsoft 365 admin center. Entra continues to supply the identity foundation through **Entra Agent ID**. See `[AI-18]`. | Microsoft Security Blog + M365 blog, verified Aug 2026 |
| 28 | eDiscovery comes in two editions, **Standard and Premium**, and **Content Search** is a separate solution | **All classic eDiscovery experiences were retired on 31 August 2025** — classic Content Search, classic eDiscovery (Standard), and classic eDiscovery (Premium). Classic Content Search and Standard were pulled earlier, on **26 May 2025**. There is now **one unified, case-based eDiscovery experience** in the Purview portal, and **Content Search lives inside a system-generated case**. Premium *capabilities* still exist and are still E5-gated — but they are features of one product, not a separate product. See `[PURV-08]`. | Microsoft Learn (`purview/ediscovery-legacy-retirement`), verified Aug 2026 |
| 29 | "Microsoft Defender for Identity monitors Microsoft Entra ID traffic for signs of compromise" | **Defender for Identity is sensor-based and centered on on-premises Active Directory** — domain controllers, AD CS, AD FS, Entra Connect servers. It detects Pass-the-Hash, Golden Ticket, reconnaissance, and lateral movement. **Cloud identity risk — risky sign-ins, leaked credentials, impossible travel — is Microsoft Entra ID Protection**, a different product. See `[M365-20]`. | AB-900 source material |
| 30 | "SharePoint Advanced Management is a paid add-on" | **SAM is included with Microsoft 365 Copilot licenses.** A tenant with **at least one assigned Copilot license** gets the SAM capability set — RAC, RCD, DAG reports, site lifecycle policies, block download, change history. A small number of features (notably **restricted site creation by apps**) still require the standalone **SAM Plan 1** add-on. **Recommending a purchase the client already owns is a credibility problem, not just a technical one.** See `[AI-05]`. | Microsoft Learn (`sharepoint/sharepoint-advanced-management-features-copilot-license`), verified Aug 2026 |
| 31 | "Every prompt or Copilot interaction generates consumption that's metered and billed against Azure subscription resources" | **The Microsoft 365 Copilot seat license is not metered and never has been.** A licensed user's Copilot Chat, in-app Copilot, and the Microsoft-built agents are covered by the per-user subscription with no incremental consumption charge. **Pay-as-you-go is a billing model for agent and agentic consumption**, metered in **Copilot Credits** against a linked **Azure subscription**, and it exists so users **without** a Copilot seat can use agents. See `[AI-08]`. | AB-900 source material |
| 32 | "Copilot Chat can't use your organization's data" | **Half true, and misleading in a licensing conversation.** The *chat itself* is web-grounded and carries enterprise data protection. **Agents surfaced in Copilot Chat can be grounded in work data** — SharePoint sites, connectors, files — billed pay-as-you-go. What the paid seat unlocks is **work-grounded Copilot inside the apps**. See `[AI-08]`. | AB-900 source material |
| 33 | Retired product names still in circulation: **Yammer** · **Office 365 Connectors** (Teams) · **message packs** (Copilot Studio) · **Purview compliance portal** · **Azure AD** | Current names: **Viva Engage** · **Workflows (Power Automate)** · **Copilot Credits** (renamed September 2025) · **Microsoft Purview portal** (`purview.microsoft.com`) · **Microsoft Entra ID**, with the join type now **Microsoft Entra hybrid joined**. Recognize the old names in third-party material; write the current ones. | Multiple, 2025–2026 |
| 34 | Compliance Score is "the percentage of controls that are satisfied" | **It is points-based and risk-weighted.** Points are awarded for completed improvement actions, weighted by how much risk each action mitigates. Two organizations showing the same percentage can be in very different risk positions. **Microsoft-managed controls inflate the starting score** — report the delta on your-organization-managed controls. See `[PURV-10]`. | AB-900 source material |
| 35 | Microsoft Secure Score example "45 out of 100" | **Secure Score is not scored out of 100.** It is points achieved out of points available, and the maximum varies with your licensed products. Do not memorize or quote a scale. Also note there are **three different scores with three different scopes** — see `[M365-17]`. | AB-900 source material |
| 36 | Group-based licensing has "a maximum of 20 groups per assignment" | **The documented limit is that you can assign licenses to a maximum of 20 groups *at a time*** — a batch-operation limit in the Microsoft 365 admin center, **not** a cap on how many groups in the tenant may hold licenses. (The related reprocess operation likewise handles 20 users at a time.) **The real constraint is the nested-group limitation**, which is correct in the source and far more likely to bite: license a group containing groups and only **first-level user members** are licensed, silently. See `[M365-13]`. | AB-900 source material |
| 37 | Restricted Content Discovery described as "restricted site access," treated as immediate and as a security control | Three separate errors. **(a)** The feature is **Restricted Content Discovery**; **Restricted Access Control** is the different, permission-gating feature. **(b)** RCD is **not immediate** — it requires reindexing, typically **up to 24 hours** and **a week or more** on very large sites, in both directions. **(c)** RCD is **partial suppression by design** — a user who owns a file or recently opened it can still find it, searches from within the site are unaffected, and it **cannot be applied to OneDrive**. **It buys time; it is not a security boundary.** See `[AI-06]`. | Microsoft Learn (`sharepoint/restricted-content-discovery`) + practitioner sources, verified Aug 2026 |
| 38 | Restricted SharePoint Search presented as a protective control | **RSS changes no permissions and protects nothing.** It limits Copilot and org-wide search to an allowed list of **up to 100 sites** (hub sites count toward the 100; **their associated sites are included but do not count**). It does **not** stop Copilot surfacing content the user has already accessed, and it degrades Copilot tenant-wide — you have paid for seats and then blindfolded the product. **Use it as a dated stalling tactic with an agreed end date**, never as an outcome. See `[AI-06]`. | Microsoft Learn (`sharepoint/restricted-sharepoint-search`), verified Aug 2026 |
| 39 | "Copilot doesn't store or use data for training the LLM" (stated alone) | Correct but **incomplete in the half that matters legally**. The full statement: prompts, responses, and Graph-accessed data are **not used to train the foundation models**, data stays within the **tenant boundary**, **and interactions ARE logged for audit and discoverable through eDiscovery**. Clients ask about the first half; their legal team asks about the second. See `[AI-01]`. | AB-900 source material |
| 40 | Consumer Copilot branded "Copilot Pro"; Azure OpenAI Service / Azure AI Foundry | **Copilot Pro was retired in late 2025**, with **Microsoft 365 Premium** as the consumer replacement; **Azure AI Foundry has been renamed Microsoft Foundry**. Low operational value — **consumer plans never connect to work-tenant data** under any brand — but the names appear in current material. **⚠ These two are from source material rather than first-hand verification; confirm before quoting to a client.** | AB-900 source material, **not independently verified** |
| 41 | A source that states *"there is no centralized prompt repository or admin-level prompt governance"* and then supplies specific admin-center menu paths for prompt policies | **Both cannot be true, and a self-contradicting section is unreliable throughout.** Treat any specific menu path in it as unverified. The stable anchor is the **prompt lifecycle — save, share, schedule, delete** — and the governance risk attached to each. See `[AI-12]`. **General principle: when a source contradicts itself, discard the specifics and keep only what is corroborated elsewhere.** | AB-900 source material |
| 42 | AB-900 exam mechanics (passing score, time limit, question count, domain weighting, seven-day study plan, question-reading tactics) | **Stripped**, on the same basis as #14. Exam scaffolding is not transferable; the underlying product behavior is. Retained in §11, §26, and §27 with the assessment framing removed. | Per your standing instruction |
| 43 | GTUBE is a universal spam-filter test string | **Not documented as supported by Exchange Online Protection** and does not reliably trip it. Use a blocked-sender entry or a mail flow rule stamping SCL 9. See `[EXO-07]`. | Testing, 23 Aug 2026 |
| 44 | Sensitivity labels can be used as DLP conditions on any SKU | Microsoft classifies label-as-condition under **advanced DLP conditions**, which are E5-tier. Field-tested on Business Premium: **the policy saves without complaint and silently never matches.** It is a **condition**, not an action. See `[PURV-14]`. | Microsoft Learn + testing, verified Aug 2026 |
| 45 | Business Premium sensitivity labels cannot apply encryption | **They can.** Business Premium includes **Azure Information Protection P1**, which covers RMS encryption and visual markings (headers, footers, watermarks). **E3 is not required.** What Business Premium lacks is **automatic *and recommended*** labeling, both of which are P2. See `[PURV-14]`. | Microsoft Learn, verified Aug 2026 |
| 46 | A policy tip proves DLP is protecting data | **Policy tips, user notifications, and message trace DLP events fire identically in simulation mode.** The only reliable verification is confirming the action occurred at the recipient. See `[PURV-17]` and `[DOCTRINE-11]`. | Testing, 23 Aug 2026 |
| 47 | Changing primary SMTP means the user can no longer sign in with the old address | **UPN and primary SMTP are separate attributes; changing one never touches the other.** The old UPN remains the sign-in. Whether the *new* address also works depends on **"Email as an alternate login ID"** — a **public preview** feature, off by default, that requires HRD policy or staged rollout and **explicitly does not support Entra hybrid joined or Entra joined devices**. An apparent success without it enabled is almost always a cached session plus OWA displaying the primary SMTP in the account panel. **Resolved — no longer an open item.** See `[EXO-14]`. | Microsoft Learn, verified Aug 2026 |
| 48 | Publishing DKIM CNAMEs and enabling DKIM signing are always two distinct manual steps | Depends on the path used to obtain the selector values. **Never assume the toggle state — check it in the Defender portal and prove it with `Authentication-Results` on a real message.** See `[DNS-MAIL-05]`. | Testing, 23 Aug 2026 |
| 49 | DKIM selector CNAME targets follow a predictable pattern | **Format changed May 2025** and now includes a **dynamically assigned partition character** (observed: `k`, `r`). Must be read from the portal or `Get-DkimSigningConfig`. **The target ends `.dkim.mail.microsoft.com`** — truncated examples missing the trailing `.com` circulate widely and leave the status stuck on `CnameMissing`. Pre-May-2025 domains keep the older `onmicrosoft.com` format; **the two cannot coexist for one selector**. See `[DNS-MAIL-05]`. | Microsoft Learn + practitioner sources, verified Aug 2026 |
| 50 | Message trace results are interactive under 7 days and CSV-only beyond that | **The current boundary is 10 days, not 7.** Summary report: up to 10 days, ~20,000 results, instant. Enhanced summary and Extended: up to 90 days, ~100,000 results, downloadable CSV generated in the background. **Original client IP is retained only 10 days** and appears only in the downloadable reports. A historical search covers a maximum of 100 addresses. See `[EXO-01]`. | Microsoft Learn, verified Aug 2026 |
| 51 | The quarantine retention default is 15 days | **It depends on where the policy was created.** The default anti-spam policy and policies created in the **Defender portal** default to **30 days**; policies created in **PowerShell** default to **15**. Valid range 1–30. **Read it off the policy rather than quoting a number.** Preset Standard and Strict policies do not allow it to be changed. See `[EXO-06]`. | Microsoft Learn, verified Aug 2026 |
| 52 | Quarantine actions and user self-release are fully admin-configurable | **High confidence phishing and malware are always quarantined**, and **users can never self-release high confidence phishing regardless of the quarantine policy applied.** The "Move to Junk Email" action is effectively deprecated for that verdict — selecting it still quarantines. Quarantine cannot be disabled tenant-wide. See `[EXO-06]`. | Microsoft Learn, verified Aug 2026 |
| 53 | "Microsoft DNS hosting does not support DNSSEC" (stated without qualification) | **True only of Microsoft 365 DNS hosting** (`ns1-4.bdm.microsoftonline.com`). **Azure Public DNS does support DNSSEC** — ECDSAP256SHA256, with automatic ZSK rollover. Conflating the two produces a wrong recommendation in both directions. See `[DNS-MAIL-04]`. | Microsoft Learn, verified Aug 2026 |
| 54 | Tenant Allow/Block List allow entries all expire | **Sender, domain, URL, and file allow entries** expire — 45 days after the filtering system determines the entity is clean, or up to 30 days if set manually. **Spoof allow entries never expire**, and **anti-spam policy allowed-sender lists never expire either.** Those two are where permanent allows accumulate. See `[EXO-07]`. | Microsoft Learn, verified Aug 2026 |

### `[APX-D]` Rebuild-from-scratch drill

**The most useful thing to do with this manual is to prove you do not need it.**

Wipe the lab. Rebuild from Section 06 alone — no AI assistance, no searching, timed. Target for a second pass: Phases 0 through 11 in one working day.

**If you can do it, you own this material rather than having followed it. If you stall, the exact point where you stall identifies the concept you were pattern-matching rather than understanding.** Both outcomes are useful and the second is more useful.

**Things to change on the rebuild, so it is a new problem rather than a repetition:**
- Use a **routable domain name**, not `.local`
- Put **Entra Connect on a member server** rather than the DC
- Build **both domain controllers before joining any client**
- Serve **DHCP from Windows** rather than the firewall
- Deploy **LAPS and backup as part of the build**, not afterward
- **Write the documentation as you go** rather than at the end

**A note on what "finished" means:** environments are never finished. A lab you are still breaking and extending is a better interview story than one that was declared complete and switched off. The value of any build is not the final state — **it is the findings, every one of which came from something not working.**

### `[APX-E]` Learning roadmap

| Phase | Focus |
|---|---|
| **1 — Helpdesk core** | Windows troubleshooting · networking basics · AD users and groups · password resets and lockouts · **ticket documentation** |
| **2 — Microsoft 365 core** | M365 Admin Center · Entra ID users/groups · Exchange Online basics · SharePoint/OneDrive permissions · MFA and Conditional Access |
| **3 — Device management** | Intune enrollment · compliance policies · Company Portal · BitLocker recovery · remote actions |
| **4 — Infrastructure** | Full greenfield build (Section 06) · Group Policy · file services and permissions · DNS/DHCP · second DC and real redundancy |
| **5 — Azure fundamentals** | Resource groups · storage accounts · VMs · VNets · RBAC · cost management · Arc |
| **6 — Automation** | PowerShell scripting · Graph PowerShell · Exchange Online PowerShell · **safe bulk operations** · the toolkit pattern (Section 19) |
| **7 — Security and IR** | LAPS · Conditional Access · incident response · compromised account handling · assessment reporting |

**The transition from phase 4 onward is where "I know PowerShell" becomes "here is my deployment toolkit."** Put the toolkit in a private Git repository — you get version history, rollback, and a portfolio artifact a hiring manager can actually look at.

---

### `[APX-F]` Disambiguation index — the pairs that get confused

**Use this when two products sound like they do the same thing.** Every row is a pair that is genuinely easy to conflate, and where conflating them leads to the wrong tool being deployed.

**Identity and access**

| Pair | The distinction |
|---|---|
| **Authentication vs authorization** | AuthN = who you are, **first**. AuthZ = what you may do, **second**. `[SECF-08]` |
| **MFA vs two passwords** | MFA requires factors from **different categories** (know / have / are). Password + security question is **not** MFA |
| **PHS vs PTA vs federation** | PHS validates in the cloud against a synced hash (**default**). PTA validates on-premises in real time via an agent. Federation delegates to AD FS. `[M365-19]` |
| **Conditional Access vs RBAC** | CA = if/then rules about **the sign-in** (location, device, risk). RBAC = **permissions on resources**. RBAC has no notion of location or risk |
| **Security defaults vs Conditional Access** | **Mutually exclusive.** Defaults is a free all-or-nothing baseline; CA is granular and needs P1. Turn defaults off to use CA. `[M365-14]` |
| **Report-only vs What If** | Report-only logs what **real** sign-ins would have experienced, continuously — a deployment tool. What If simulates **one hypothetical** sign-in on demand — a troubleshooting tool |
| **Entra ID Protection vs Defender for Identity** | ID Protection = **cloud** identity risk (impossible travel, leaked credentials). Defender for Identity = **on-premises AD** attacks (Golden Ticket, Pass-the-Hash). `[M365-20]` |
| **Defender for Cloud Apps vs Defender for Cloud** | *Cloud Apps* = SaaS visibility and shadow IT. *Defender for Cloud* = Azure/multicloud infrastructure posture. One word apart |
| **Identity Secure Score vs Microsoft Secure Score vs Compliance Score** | Identity posture (Entra) / overall security posture (Defender) / regulatory posture (Purview Compliance Manager). `[M365-17]` |
| **Sign-in logs vs audit logs** | Sign-in logs = **Entra**, authentication events. Unified audit log = **Purview**, what was done to content and configuration. `[M365-18]` |
| **App registration vs enterprise application** | Registration = the app **definition** (blueprint). Enterprise app = the **service principal** in your tenant (the instance). `[M365-16]` |
| **Delegated vs application permissions** | Delegated = acts **as the signed-in user**. Application = acts **as itself**, no user present, requires admin consent |
| **Entra roles vs Azure RBAC** | Directory administration vs Azure resource administration. Deliberately separate. `[AZ-RBAC-VS-ENTRA]` |
| **PIM vs Conditional Access** | PIM = whether an eligible role is currently **activated**. CA = whether this **sign-in** is allowed at all. `[M365-15]` |

**Mail, DNS, and sharing**

| Pair | The distinction |
|---|---|
| **Delegation vs NS records in the zone** | Delegation lives in the **parent zone at the registry** and is changed on the registrar's nameserver field. NS records in the zone are supposed to mirror it. Editing the wrong one produces a **lame delegation** and no visible change. `[DNS-MAIL-03]` |
| **SPF vs DKIM vs DMARC** | SPF authenticates the **envelope sender**. DKIM authenticates the **message**. **Neither touches the visible `From:`** — DMARC binds authentication back to it (alignment) and sets policy. `[DNS-MAIL-00]` |
| **NXDOMAIN vs NODATA** | NXDOMAIN = the **name** does not exist. NODATA = the name exists with **no record of that type** — proven by the SOA appearing in the Authority section. `[DNS-MAIL-02]` |
| **M365 DNS hosting vs Azure Public DNS** | Two different services. **M365 DNS hosting does not support DNSSEC; Azure Public DNS does.** `[DNS-MAIL-04]` |
| **Anti-spam policy vs quarantine policy** | Anti-spam decides *should this be quarantined?* Quarantine policy decides *what may the user do about it?* Two objects, two settings, two different answers to "can I get it back myself?" `[EXO-06]` |
| **FilteredAsSpam vs Quarantined** | FilteredAsSpam = **in the mailbox**, in Junk, user-recoverable. Quarantined = **held by the service**, may need an admin. `[EXO-02]` |
| **Message-ID vs MessageTrace ID** | Message-ID is assigned by the **originating** system and follows the message everywhere — your best search key. MessageTrace ID is a Microsoft-internal GUID, useful only for a support case. `[EXO-04]` |
| **Send As vs Send on Behalf** | Send As **replaces** the submitter — attribution is unrecoverable from message trace. Send on Behalf **preserves** it in the `Sender:` header — but whether the recipient sees it depends on their client. `[EXO-09]` |
| **Full Access vs Send As** | **Independent permissions.** Full Access grants no right to send. Granting only Full Access produces "I can read it but I can't reply from it." `[EXO-08]` |
| **UPN vs primary SMTP** | Sign-in identifier vs reply address. **Separate attributes; editing one never touches the other.** `[EXO-14]` |
| **proxyAddresses vs the `mail` attribute** | `proxyAddresses` is multi-valued and drives Exchange routing. `mail` is single-valued and is what many line-of-business apps read. **Updating one does not update the other.** `[EXO-13]` |
| **Anyone link vs specific-person share** | Anyone = anonymous, **no guest object, no identity, no audit trail**. Specific-person = creates a **guest object** and requires a code or sign-in. Different tenant settings, different evidence. `[SPO-02]` |
| **Message trace vs sharing notifications** | SharePoint invitations come from `no-reply@sharepointonline.com` via SharePoint's own infrastructure and **never appear in an Exchange message trace.** `[SPO-05]` |
| **Simulation vs enforcement (DLP)** | **Visually identical** — same policy tips, same trace events, same user notification. The only difference is what the recipient actually receives. `[PURV-17]` |
| **Encrypt vs Block (DLP)** | Encrypt **wraps and delivers** — the data still leaves. Block withholds it. Agreeing to one when the client meant the other is a real compliance gap. `[PURV-18]` |

**Objects and groups**

| Pair | The distinction |
|---|---|
| **Security group vs Microsoft 365 group** | Security group = permissions only. M365 group = permissions **plus** shared mailbox, calendar, site, Planner, optional Team |
| **Distribution group vs mail-enabled security group** | Distribution = email only, **no permissions**. Mail-enabled security = email **and** permissions |
| **Dynamic vs assigned group** | Dynamic membership is calculated from attributes and **cannot be edited by hand**. `[M365-10]` |
| **Shared mailbox vs distribution group** | A shared mailbox is a real mailbox with stored history several people work from. A distribution group just forwards to individual inboxes |
| **Resource mailbox — room vs equipment** | Rooms are locations. Equipment is bookable non-room assets |
| **Team site vs communication site** | Team site = group-connected collaboration. Communication site = broadcast, not group-connected |
| **Standard vs private vs shared channel** | Standard = everyone in the team, files in the team site. **Private and shared each get their own SharePoint site.** Shared reaches outside the team. `[M365-11]` |
| **SharePoint Administrator vs site owner** | Tenant-wide service role vs per-site permission level |
| **Visitor vs Member vs Owner** | Read / Edit / Full Control |

**Data governance**

| Pair | The distinction |
|---|---|
| **SIT vs EDM** | SIT matches a **pattern** (false positives possible). EDM matches your **actual uploaded values** (near-zero false positives). `[PURV-02]` |
| **SIT vs trainable classifier** | Pattern-based vs concept-based. **There is no regex for "resume"** |
| **Sensitivity label vs retention label** | Access and encryption vs how long it is kept. **Independent — an item can carry one of each** |
| **Retention policy vs retention label** | Policy = **location-based**, broad, invisible to users. Label = **item-based**, precise, can declare a record |
| **Retention vs litigation/eDiscovery hold** | Retention = routine lifecycle. Hold = preserve for a legal matter, **overrides retention and deletion**. `[PURV-07]` |
| **DLP vs sensitivity labels** | Labels classify and protect **the content**. DLP watches **movement** and intervenes |
| **DLP vs Insider Risk Management** | DLP acts inline on **content** at the moment of an action. IRM scores **patterns of behavior** over time for human review |
| **DLP vs Communication Compliance** | DLP: is **sensitive data** leaving? CommComp: is **this message** itself inappropriate? |
| **Data Explorer vs Activity Explorer** | *Where the content is* (state) vs *what happened to it* (events). `[PURV-11]` |
| **Compliance Manager vs Secure Score** | Regulatory compliance posture vs security configuration posture |
| **eDiscovery Manager vs eDiscovery Administrator** | Manager works their own cases. Administrator can access **all** cases |
| **Audit (Standard) vs Audit (Premium)** | 180 days vs 1 year default retention; Premium extends to 10 years with an add-on |

**Copilot and agents**

| Pair | The distinction |
|---|---|
| **RAC vs RCD** | RAC controls whether content can be **reached** (permission gate). RCD controls whether it can be **found** (visibility filter, permissions unchanged). `[AI-06]` |
| **RCD vs Restricted SharePoint Search** | RCD is **per site**. RSS is **tenant-wide**, an allowed list of up to 100 curated sites |
| **DAG reports vs SAM controls** | DAG **finds** the risky sites. RAC / RCD / block download **fix** them |
| **Copilot vs an agent** | Copilot assists you across everything you can see. An agent is scoped to a defined body of knowledge and can be shared. `[AI-13]` |
| **Researcher vs Analyst** | Researcher = multi-step research with citations across work data and the web. Analyst = data analysis with Python, trends, charts |
| **Microsoft-managed agents vs everything else** | Researcher, Analyst, Facilitator, Planner, and the M365 Admin agent are **pre-installed and cannot be controlled via availability settings** |
| **Monthly seat vs pay-as-you-go** | Seat = fixed cost per named user, covers the Copilot experience. PAYG = variable cost, meters **agent consumption** in Copilot Credits, no seat required. `[AI-08]` |
| **Copilot Chat vs Microsoft 365 Copilot** | Chat = included, web-grounded, plus agents on PAYG. Copilot = paid seat, **work-grounded** inside the apps |
| **Copilot Studio license vs environment role** | License = the right to use the product tenant-wide. Environment role = what you may do inside a specific environment. **You need both to build.** `[AI-14]` |
| **Using an agent vs building one** | Using needs only endpoint access and availability. Building needs a license **and** Environment Maker |
| **Block vs Remove an agent** | Block prevents access and is reversible. Remove deletes it from the inventory. `[AI-17]` |
| **Admin center usage reports vs Copilot Analytics** | Operational counts (enabled, active, last activity) vs impact and behavior analysis for leaders. `[AI-11]` |
| **AI Administrator vs Global Administrator** | **AI Administrator is the least-privilege answer** for Copilot and agent administration |
| **Agent 365 vs Copilot Control System** | Agent 365 = identity and governance for agents at scale. CCS = day-to-day Copilot agent approval, availability, and monitoring. `[AI-18]` |
| **Billing policy vs PAYG service connection** | Policy defines the billing arrangement and user scope. Connecting it to a service is what turns PAYG on. **Both required.** `[AI-10]` |

---

### `[APX-G]` Requirement → tool index

**When a client describes a problem in their own words, this is the translation layer.** Search the phrase, not the product name.

| The requirement, as stated | The answer |
|---|---|
| "If they're off the corporate network, make them do MFA" | **Conditional Access** `[M365-14]` |
| "Test the policy before it breaks anything" | **Report-only mode** (deployment) or **What If** (one-off simulation) |
| "We turned on security defaults but need custom rules" | Turn security defaults **off**; use Conditional Access. They cannot coexist |
| "Make sure we can't lock ourselves out" | **Break-glass accounts excluded from all CA policies** `[APX-B]` |
| "The contractor needs admin rights for a two-hour window" | **Privileged Identity Management** `[M365-15]` |
| "Impossible travel / leaked credentials / risky sign-in" | **Entra ID Protection** |
| "Golden Ticket / Pass-the-Hash / compromised domain controller" | **Defender for Identity** `[SECF-10]` |
| "What unsanctioned SaaS are people using?" | **Defender for Cloud Apps** |
| "That phishing email was already delivered — get it out of the mailboxes" | **Zero-hour Auto Purge (ZAP)** `[M365-20]` |
| "The link was clean when it arrived and malicious when they clicked" | **Safe Links** |
| "Who else got this phish, and did anyone click?" | **Threat Explorer** (Defender for Office 365 Plan 2) |
| "Our accounts are being password-sprayed despite MFA" | **Block legacy authentication** `[M365-19]` |
| "Give this set of users access to a share, no mailbox needed" | **Security group** |
| "The team needs a shared mailbox, calendar, site, and Planner" | **Microsoft 365 group** |
| "Email everyone, no permissions involved" | **Distribution group** |
| "Both permissions and a group email address" | **Mail-enabled security group** |
| "Membership should update itself when someone changes department" | **Dynamic group** (requires Entra ID P1) |
| "Our developer built an app that needs to read calendars" | **App registration** `[M365-16]` |
| "Set up SSO for the HR SaaS vendor and assign it to the HR group" | **Enterprise application** |
| "The integration stopped working and nothing changed" | **Expired client secret** — check first |
| "Who signed in, and was it blocked?" | **Entra sign-in logs** |
| "Who accessed, changed, or deleted that content?" | **Purview unified audit log** `[M365-18]` |
| "Match a pattern like a credit card number" | **Sensitive information type** |
| "Match our actual list of employee IDs with no false positives" | **Exact Data Match** `[PURV-02]` |
| "Recognize that a document *is* a resume" | **Trainable classifier** |
| "Encrypt it so only Legal can open it, even outside the tenant" | **Sensitivity label with encryption** `[PURV-03]` |
| "Stop them emailing it externally" | **DLP** `[PURV-04]` |
| "A departing employee is downloading confidential files" | **Insider Risk Management** `[PURV-05]` |
| "There's harassment in a Teams chat" | **Communication Compliance** `[PURV-06]` |
| "Someone pasted company data into a public AI chatbot" | **DSPM for AI** `[PURV-12]` |
| "Where does our sensitive data actually live?" | **Data Explorer / Content explorer** `[PURV-11]` |
| "What did they do with that file, and in what order?" | **Activity Explorer** |
| "Are we compliant with GDPR / HIPAA?" | **Compliance Manager** `[PURV-10]` |
| "Preserve everything for litigation" | **eDiscovery hold / litigation hold** `[PURV-08]` |
| "Find every email and file about this legal matter" | **Content search inside an eDiscovery case** |
| "Delete all Teams chats older than 90 days" | **Retention policy** (location-based) `[PURV-07]` |
| "This one contract must be kept 7 years from expiry" | **Retention label** (item-based) |
| "A 7-year retention and a 5-year deletion both apply" | **Retained 7 years, then deleted.** Retention beats deletion |
| "Which SharePoint sites are overshared?" | **Data access governance reports** `[AI-04]` |
| "Hide a site from Copilot **without changing permissions**" | **Restricted Content Discovery** `[AI-06]` |
| "Only this group may access the site, regardless of prior permissions" | **Restricted Access Control** |
| "Pause Copilot across the tenant while we fix permissions" | **Restricted SharePoint Search** — with an end date |
| "The site owner should confirm who still needs access" | **Site access review** (SAM) `[AI-05]` |
| "Browser-only, no downloads from this site" | **Block download policy** (SAM) |
| "Copilot showed someone a document they shouldn't have seen" | **Pre-existing oversharing.** Copilot bypassed nothing `[AI-03]` |
| "What label does Copilot's output get?" | **The most restrictive label of its sources** `[AI-02]` |
| "Multi-step research with citations, work data plus web" | **Researcher agent** |
| "Analyze a large dataset, find trends, build charts" | **Analyst agent** |
| "The meeting recap isn't generating" | **Teams transcription is disabled** `[M365-12]` |
| "Unlicensed users need to query a SharePoint site agent" | **PAYG billing policy connected to SharePoint agents** `[AI-10]` |
| "Finance needs a predictable monthly Copilot cost" | **Monthly per-user seats** |
| "I created a billing policy and PAYG still isn't working" | **Step 2 is missing** — connect the policy to a service |
| "Reclaim licenses from users who never touch Copilot" | **Admin center usage reports** — enabled vs active `[AI-11]` |
| "Show leadership the business impact of Copilot" | **Copilot Analytics / Viva Insights** |
| "Least-privilege role for approving agents" | **AI Administrator** — not Global Administrator |
| "Let this person build agents in Copilot Studio" | Copilot Studio license **+ Environment Maker** role `[AI-14]` |
| "Let this person just use an agent someone published" | **No Studio license and no environment role needed** |
| "Temporarily stop everyone using an agent" | **Block** (reversible) |
| "Govern hundreds of agents as identities" | **Agent 365 + Entra Agent ID** `[AI-18]` |

---

### `[APX-H]` Hard limits, defaults, and thresholds

Numbers that change behavior, not trivia. **Anything Microsoft can revise carries a verification date; check before quoting to a client.**

| Value | What it governs | Ref |
|---|---|---|
| **300 seats** | Hard cap on Microsoft 365 Business plans | `[M365-13]` |
| **20 groups at a time** | Batch limit when assigning licenses to groups (**not** a cap on licensed groups). Reprocess handles 20 users at a time | `[M365-13]` |
| **0 nesting levels** | Group-based licensing does **not** support nested groups — first-level members only, silently | `[M365-13]` |
| **50 GB / 100 GB** | Typical Exchange Online mailbox quota, Plan 1 / Plan 2 | `[M365-09]` |
| **50 GB** | Threshold above which a shared mailbox requires a license (also triggered by a hold, or direct sign-in) | `[M365-09]` |
| **1 TB** | Typical default OneDrive storage per user | `[M365-11]` |
| **180 days** | Unified audit log retention, **Audit (Standard)** | `[M365-18]` |
| **1 year → 10 years** | Unified audit log retention, **Audit (Premium)**, extendable with an add-on | `[M365-18]` |
| **5 minutes** | Maximum Kerberos clock skew before authentication fails | `[AD-TIME]` |
| **50 documents** | Minimum seed set to train a custom trainable classifier (50–500 recommended) | `[PURV-02]` |
| **100 sites** | Maximum on the Restricted SharePoint Search allowed list. Hub sites count; **their associated sites are included but do not count** | `[AI-06]` |
| **~24 hours** | Typical time for Restricted Content Discovery to take effect. **A week or more on very large sites (500k+ items)** — in both directions | `[AI-06]` |
| **10 policies** | Maximum Copilot pay-as-you-go billing policies per tenant | `[AI-10]` |
| **2 steps** | Required to enable Copilot PAYG: create the billing policy, **then** connect it to a service. Step 1 alone does nothing | `[AI-10]` |
| **24–48 hours** | Ingestion delay on Microsoft 365 admin center usage reports | `[AI-11]` |
| **30 days** | Recommended advance notice before retiring an agent | `[AI-17]` |
| **3** | Zero Trust principles · MFA factor categories · SharePoint site permission levels · Teams channel types · hybrid authentication methods · agent availability options · agent approval stages | various |
| **4** | Principles of retention · prompt-management verbs (save, share, schedule, delete) · Azure RBAC scopes | `[PURV-07]`, `[AI-12]` |
| **6** | Zero Trust pillars · Responsible AI principles | `[AI-21]` |
| **7** | Defense-in-depth layers | `[AZ]` |
| **180 days** | Windows Server Evaluation expiry before forced shutdowns begin | `[BUILD-P0]` |
| **10 days** | Message trace interactive Summary report window, and the **only** window in which original client IP is retained | `[EXO-01]` |
| **90 days** | Message trace absolute ceiling (Enhanced summary / Extended, downloadable CSV). **Beyond this the data does not exist** | `[EXO-01]` |
| **~20,000 / ~100,000** | Result caps — Summary report / Enhanced summary and Extended reports | `[EXO-01]` |
| **100 addresses** | Maximum email addresses in a single historical search job | `[EXO-01]` |
| **30 days / 15 days** | Quarantine retention default — Defender portal and the default anti-spam policy / policies created in **PowerShell**. Valid range 1–30 | `[EXO-06]` |
| **45 days** | Default expiry of a Tenant Allow/Block List allow entry, measured from last used. **Spoof allow entries and anti-spam policy allow lists never expire** | `[EXO-07]` |
| **10 DNS lookups** | Hard SPF evaluation limit including nested includes. Exceeding it invalidates the record silently | `[DNS-MAIL-06]` |
| **1** | Number of `v=spf1` records permitted per domain. **Two is a permanent error, not a warning** | `[DNS-MAIL-06]` |
| **2 selectors** | DKIM CNAMEs that must stay published permanently — one signs, one exists for rotation | `[DNS-MAIL-05]` |
| **~96 hours** | DKIM key rotation window. Another rotation cannot start while one is in progress | `[DNS-MAIL-05]` |
| **48 hours** | Microsoft's stated ceiling for DNS hosting changes to reflect after a DNSSEC/delegation change | `[DNS-MAIL-04]` |
| **~48 hours** | Typical sender retry window on a `4.x.x` bounce before it becomes permanent | `[DNS-MAIL-08]` |
| **24 hours** | Documented ceiling for a sensitivity label policy change to reach client apps. **OWA usually beats Outlook desktop** | `[PURV-15]` |
| **3 layers** | External sharing controls — tenant, site, item. **Most restrictive wins; diagnose top down** | `[SPO-01]` |

---

## 22 — NETWORKING FUNDAMENTALS `[NETF]`

Principles and protocol behavior. This section is the *why* underneath Section 04 `[NET]`, which is the *how*. Course-specific and exam-specific scaffolding has been stripped; only transferable material is retained.

**Use this section when a diagnostic result does not make sense.** Section 04 tells you which command to run. This section tells you what the answer means and which layer to move to next.

---

### `[NETF-01]` The layered model — and how to actually use it

Two models are in circulation. They describe the same reality at different resolutions.

| # | TCP/IP 5-layer | OSI 7-layer | Protocol Data Unit | Addressing | Example |
|---|---|---|---|---|---|
| 7 | *(folded into Application)* | Application | Data | — | HTTP, SMTP, DNS |
| 6 | *(folded into Application)* | Presentation | Data | — | TLS, encoding, compression |
| 5 | *(folded into Application)* | Session | Data | — | Session setup/teardown |
| **5 / 4** | **Application** | *(above three)* | **Messages / Data** | — | HTTP, SMTP, DNS, SMB |
| **4** | **Transport** | Transport | **Segment** (TCP) / **Datagram** (UDP) | **Port number** | TCP, UDP |
| **3** | **Network** | Network | **Packet** | **IP address** | IP, ICMP |
| **2** | **Data Link** | Data Link | **Frame** | **MAC address** | Ethernet, Wi-Fi, 802.1Q |
| **1** | **Physical** | Physical | **Bits** | — | Copper, fibre, radio |

**WHY two models:** OSI is the teaching and vendor-documentation model. TCP/IP 5-layer is what the stack actually implements — it folds OSI's Session, Presentation, and Application into one Application layer, because in practice a single application protocol handles all three. Interviewers ask about OSI. Packet captures show you TCP/IP.

**The one thing worth memorising is the PDU and address at each layer**, because that is what tells you which tool can see your problem. A switch cannot help you with an IP problem. A router cannot help you with a port problem.

#### The layer-based triage table — this is the actual point of the model

Extends `[NET-TRIAGE]`. Work **bottom up**. Do not troubleshoot a layer until the layer beneath it is proven.

| Layer | What breaks here | Symptom you will be told | First command |
|---|---|---|---|
| **1 — Physical** | Unplugged, dead port, bad cable, disabled adapter, no PoE | "It's just not working" | `Get-NetAdapter` — is `Status` = `Up`? |
| **2 — Data Link** | Wrong VLAN, switch port security, duplex mismatch, bad NIC driver, stale ARP | Link light on, no traffic | `Get-NetNeighbor` / `arp -a` |
| **3 — Network** | No IP, APIPA, wrong mask, wrong gateway, missing route | "No internet" but LAN works, or reverse | `Get-NetIPConfiguration`, ping the gateway |
| **4 — Transport** | Firewall blocking the port, service not listening | One app fails, everything else fine | `Test-NetConnection -Port` |
| **5–7 — Application** | DNS, certificate expiry, authentication, app config | "The website is down" | `Resolve-DnsName`, event logs |

**⚠ TRAP — the layer-skip.** The most common wasted hour in support is debugging DNS (layer 7) on a machine holding a `169.254.x.x` address (layer 3 failure caused by a layer 2 VLAN problem). **A symptom described at a high layer is not evidence the problem lives there.** See `[DOCTRINE-01]`.

**✅ VERIFY the layer before you leave it:**

```powershell
# L1 — is the interface physically up?
Get-NetAdapter | Where-Object Status -eq 'Up' | Format-Table Name, LinkSpeed, MacAddress

# L2 — can I see neighbours on my own segment?
Get-NetNeighbor -AddressFamily IPv4 | Where-Object State -ne 'Unreachable'

# L3 — do I have a sane address and a reachable gateway?
Get-NetIPConfiguration
Test-NetConnection -ComputerName (Get-NetIPConfiguration).IPv4DefaultGateway.NextHop

# L4 — is the specific service port open?
Test-NetConnection -ComputerName fileserver -Port 445

# L7 — does the name resolve, and to something sensible?
Resolve-DnsName fileserver
```

---

### `[NETF-02]` Encapsulation — why a "packet" is four different things

Each layer wraps the layer above it in its own header. The original data is the **payload**; everything else is header (and, at layer 2, a trailer).

```
Application:                              [        Message        ]
Transport:                  [ TCP/UDP hdr ][        Message        ]
Network:        [ IP header ][ TCP/UDP hdr ][        Message        ]
Data Link:  [Eth hdr][ IP header ][ TCP/UDP hdr ][   Message   ][Eth FCS]
Physical:   1010110101110100101110101110100101011101011101001011101...
```

**WHY this matters in the field:**
- **Overhead is real.** Headers consume payload budget. This is why MTU and fragmentation problems exist, and why VPN tunnels reduce effective throughput — the tunnel adds another full set of headers.
- **"Payload" means "everything that is not a header"** at whatever layer you are currently discussing. Be explicit about which layer you mean, or a conversation with a network engineer will go sideways.
- **De-encapsulation is the reverse**, performed by the receiving host, stripping one header per layer on the way up.

---

### `[NETF-03]` Layer 1 — physical media and link diagnosis

**Demarcation point (demarc):** where one network or system ends and another begins. In practice, **the boundary of your responsibility.** Identify it before you troubleshoot — you cannot fix what is on the other side, and escalating to the ISP is the correct action, not a failure.

#### Reading an RJ45 port without any software

| LED | State | Meaning |
|---|---|---|
| **Link LED** (usually left, amber/yellow) | Solid | Cable is properly connected to two devices that are **both powered on**. Layer 1 is good. |
| **Link LED** | Dark | No physical link. Cable, port, or the far end is dead. **Stop — do not troubleshoot DNS.** |
| **Activity LED** (usually right, green) | Flashing | Data is actively crossing the cable |
| **Activity LED** | Solid or dark with link up | Link negotiated but no traffic — suspect VLAN assignment, port security, or a dead service |

**✅ VERIFY:** a dark link LED and a `Get-NetAdapter` status of `Disconnected` agree with each other. If the OS says `Up` and the port is dark, you are looking at the wrong port.

**⚠ TRAP — the patch panel.** A **patch panel** does no work. It is purely a cable termination container. A run that "goes to the patch panel" is not connected to anything until a patch cable joins that panel port to a switch port. A dead wall jack most often means nobody patched it, not that the cable is broken.

**Common layer 1 causes, ordered by how often they are actually the answer:**
1. Not patched at the panel
2. Wrong wall jack (labeling is frequently wrong — trace it, do not trust it)
3. Cable damaged at the connector, not in the middle
4. Switch port administratively disabled or in err-disabled state
5. Adapter disabled in Windows
6. Actual cable failure

---

### `[NETF-04]` Layer 2 — Ethernet, MAC, ARP, VLANs

#### The Ethernet frame

| Field | Size | Purpose |
|---|---|---|
| Preamble | 7 bytes | Clock synchronisation |
| SFD (Start Frame Delimiter) | 1 byte | Marks the start of the frame proper |
| **Destination MAC** | 6 bytes | Who it is for |
| **Source MAC** | 6 bytes | Who sent it |
| VLAN header (802.1Q) | 4 bytes | **Optional.** Present only on tagged/trunk links |
| EtherType | 2 bytes | What the payload is (`0x0800` = IPv4, `0x0806` = ARP, `0x86DD` = IPv6) |
| **Payload** | 46–1500 bytes | The IP packet |
| FCS (Frame Check Sequence) | 4 bytes | CRC error **detection** — not correction |

**Numbers worth knowing:** minimum frame 64 bytes · standard MTU **1500** bytes · jumbo frames **9000** bytes (both ends and every switch in between must agree, or you get silent black-holing of large packets).

#### MAC addresses

A **MAC address** is a 48-bit identifier burned into a network interface, written as six hex octets. The first three octets are the **OUI**, assigned to the manufacturer — which means you can identify vendor from MAC.

**🔄 UPDATED — "globally unique" is now a half-truth.** The address is *assigned* uniquely, but:
- It is trivially **spoofable** in software on every OS.
- **Randomised MAC is the default** on modern iOS, Android, and Windows for Wi-Fi. The MAC a device presents to your network may change per SSID or per connection.

**Two field consequences you will hit:**
1. **MAC-based DHCP reservations fail intermittently** for phones and laptops until randomisation is disabled for that SSID on the client.
2. **MAC filtering is not a security control** — see `[SECF-14]`.

#### ARP — Address Resolution Protocol

Maps a known **IP address** to the **MAC address** that owns it, on the local segment only. Without ARP, a host knows where to send a packet logically but not physically.

```powershell
Get-NetNeighbor -AddressFamily IPv4          # modern, structured
arp -a                                        # works everywhere, including recovery consoles
Remove-NetNeighbor -IPAddress 10.10.10.1 -Confirm:$false   # clear one stale entry
arp -d *                                      # clear the whole table (elevated)
```

**⚠ TRAP — stale ARP after a device swap.** Replace a firewall or server and keep the same IP, and hosts may keep the **old MAC** cached for minutes. Symptom: the new device is unreachable from some hosts and fine from others. Clear the ARP cache on the complaining host before you troubleshoot anything else.

**ARP never crosses a router.** If you can see a device in your ARP table, it is on your broadcast domain. That is a useful diagnostic fact in itself.

#### VLANs

A **VLAN** lets multiple logical LANs share the same physical switching hardware. Each VLAN is its own broadcast domain, so **traffic cannot pass between VLANs without a router or layer 3 switch.**

**Typical segmentation:** workstations · servers · voice/VoIP · guest Wi-Fi · management/OOB · IoT and printers.

**⚠ TRAP — the wrong-VLAN symptom is not "no network."** A device on the wrong VLAN usually gets a *working* IP from the *wrong* scope. It looks connected, has internet, and cannot reach a single internal resource. See `[NET-TRIAGE]` and `[NETF-11]`.

---

### `[NETF-05]` Layer 3 — the IP datagram

| Field | Why you care |
|---|---|
| Version | 4 or 6 |
| Header Length / Total Length | Sizing and fragmentation math |
| Service Type (DSCP) | **QoS marking** — how VoIP traffic gets prioritized |
| Identification / Flags / Fragment Offset | **Fragmentation.** The `DF` (Don't Fragment) flag is what makes MTU-discovery problems visible |
| **TTL** | Decremented by 1 at every router hop. At 0 the packet is discarded and ICMP Time Exceeded is returned. **This is the entire mechanism traceroute uses** |
| **Protocol** | What is inside: `6` = TCP, `17` = UDP, `1` = ICMP |
| Header Checksum | Header integrity only, not payload |
| **Source / Destination IP** | Routing |

**WHY TTL matters practically:** it is a hop counter, not a time. A default TTL of 128 (Windows) or 64 (Linux) arriving as 122 tells you the packet crossed 6 routers. That is a free topology hint from any ping reply.

**Fragmentation:** if data exceeds the path MTU, IP splits it into multiple packets, reassembled at the destination. Fragmentation is a performance and reliability liability — a single lost fragment discards the entire original datagram. VPNs are the usual trigger.

---

### `[NETF-06]` Addressing — classes, private ranges, and CIDR

#### 🛑 Address classes are obsolete. Learn them only to translate other people's speech.

| Class | Leading bits | Range | Historical default mask |
|---|---|---|---|
| A | `0xxx` | 0.0.0.0 – 127.255.255.255 | /8 |
| B | `10xx` | 128.0.0.0 – 191.255.255.255 | /16 |
| C | `110x` | 192.0.0.0 – 223.255.255.255 | /24 |
| D | `1110` | 224.0.0.0 – 239.255.255.255 | **Multicast** — still current and meaningful |
| E | `1111` | 240.0.0.0 – 255.255.255.255 | **Reserved / experimental** — still current |

**Classful addressing was replaced by CIDR in 1993.** Classes A, B, and C have had **no operational meaning for three decades**. Classes D and E still describe real address usage and are worth knowing.

**WHY this is worth a warning rather than a footnote:** a technician who thinks classfully will assume `10.x.x.x` is a /8 and `192.168.x.x` is a /24. Both assumptions are wrong constantly, and both produce subnet masks that break routing in ways that look like DNS problems. **Always read the actual mask. Never infer it from the first octet.**

#### Reserved ranges you must recognize on sight

| Range | Name | Meaning when you see it |
|---|---|---|
| **10.0.0.0/8** | RFC 1918 private | Internal. Not routable on the internet |
| **172.16.0.0/12** | RFC 1918 private | Internal. Note the range is `172.16`–`172.31`, **not** all of `172.x` |
| **192.168.0.0/16** | RFC 1918 private | Internal. Most common in SMB and home |
| **169.254.0.0/16** | APIPA / link-local | **DHCP failed.** The host self-assigned. See `[NET-TRIAGE]` |
| **127.0.0.0/8** | Loopback | The host itself. `127.0.0.1` = "me". Traffic never leaves the NIC |
| **100.64.0.0/10** | CGNAT (RFC 6598) | Your ISP is NATing you. **You cannot port-forward.** Explains "my VPN worked at the old house" |
| **224.0.0.0/4** | Multicast | One-to-many. Used by mDNS, WSD printer discovery, some clustering |

**⚠ TRAP — the 172.16 range.** `172.20.5.10` is private. `172.35.5.10` is **public** and belongs to someone else. Half of `172.x` is routable. This catches people who half-remember the rule.

**Non-routable address space** exists so that anyone can reuse the same internal addressing without collision. The cost is that reaching those hosts from outside requires NAT (`[NETF-12]`) or a VPN.

#### CIDR — the notation that replaced classes

`/24` means "the first 24 bits are the network portion." It is a bit count, nothing more.

| CIDR | Subnet mask | Total addresses | **Usable hosts** | Typical use |
|---|---|---|---|---|
| /8 | 255.0.0.0 | 16,777,216 | 16,777,214 | Large enterprise / ISP block |
| /16 | 255.255.0.0 | 65,536 | 65,534 | Large campus |
| /20 | 255.255.240.0 | 4,096 | 4,094 | Large site |
| **/24** | **255.255.255.0** | **256** | **254** | **★ The default for offices and homes** |
| /25 | 255.255.255.128 | 128 | 126 | A /24 split in half |
| /26 | 255.255.255.192 | 64 | 62 | Small department subnet |
| /27 | 255.255.255.224 | 32 | 30 | Small segment / DMZ |
| /28 | 255.255.255.240 | 16 | 14 | Very small segment |
| /29 | 255.255.255.248 | 8 | 6 | ISP hand-off block |
| **/30** | 255.255.255.252 | 4 | **2** | **Point-to-point router link** |
| /31 | 255.255.255.254 | 2 | **2** *(RFC 3021)* | Point-to-point, no waste |
| **/32** | 255.255.255.255 | 1 | **1** | **A single host** — firewall rules, host routes, loopbacks |

#### The host-count rule, stated correctly

**Usable hosts = 2^(host bits) − 2**

The two subtracted addresses are:
- The **network ID** — all host bits `0`. Names the subnet itself.
- The **broadcast address** — all host bits `1`. Reaches every host on the subnet.

Neither can be assigned to an interface.

**Two exceptions that are not exceptions to the maths, but to the rule:**
- **/31** — RFC 3021 permits both addresses on a point-to-point link, because a link with exactly two endpoints has no need for a broadcast address. Common on router-to-router links.
- **/32** — a host route or firewall object. It describes one address; the subtraction is meaningless because there is no subnet.

**⚠ TRAP:** if a source tells you `/32 = 1 usable` and also gives you the `−2` rule without qualification, the source is internally inconsistent. The rule applies to broadcast-capable subnets, /30 and larger.

---

### `[NETF-07]` Subnetting — a procedure you can execute under pressure

**Goal:** given an address and a mask, determine network ID, broadcast, usable range, and whether two hosts can talk without a router.

#### Step-by-step

**1. Convert the CIDR to the "interesting octet."**

| CIDR | Interesting octet | Block size |
|---|---|---|
| /25 | 4th | 128 |
| /26 | 4th | 64 |
| /27 | 4th | 32 |
| /28 | 4th | 16 |
| /29 | 4th | 8 |
| /30 | 4th | 4 |
| /17–/24 | 3rd | 128 → 1 |

**Block size = 256 − (mask value in the interesting octet).**
Example: /26 → mask `255.255.255.192` → 256 − 192 = **64**.

**2. Count subnets in blocks from zero.** For /26 the boundaries are `.0`, `.64`, `.128`, `.192`.

**3. Place your address in the correct block.** `192.168.1.100/26` falls between `.64` and `.128`, so it lives in the `.64` block.

**4. Read off the four values.**

| Value | Rule | Example result |
|---|---|---|
| Network ID | Start of the block | `192.168.1.64` |
| First usable | Network ID + 1 | `192.168.1.65` |
| Broadcast | Next block start − 1 | `192.168.1.127` |
| Last usable | Broadcast − 1 | `192.168.1.126` |

**5. Same subnet or not?** Two hosts communicate directly only if **both** produce the same network ID under **their own** masks.

#### ✅ VERIFY with PowerShell instead of trusting your arithmetic

```powershell
function Get-SubnetInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)][string]$IPAddress,
        [Parameter(Mandatory, Position = 1)][ValidateRange(1, 32)][int]$PrefixLength
    )

    function ConvertTo-UInt32([string]$ip) {
        $bytes = ([System.Net.IPAddress]::Parse($ip)).GetAddressBytes()
        [Array]::Reverse($bytes)
        [System.BitConverter]::ToUInt32($bytes, 0)
    }
    function ConvertTo-IPString([uint32]$value) {
        $bytes = [System.BitConverter]::GetBytes($value)
        [Array]::Reverse($bytes)
        ([System.Net.IPAddress]::new($bytes)).IPAddressToString
    }

    $ipInt     = ConvertTo-UInt32 $IPAddress
    $hostBits  = 32 - $PrefixLength
    $blockSize = [uint32][math]::Pow(2, $hostBits)                      # addresses in this subnet
    $maskInt   = [uint32]([uint64]4294967296 - [uint64]$blockSize)
    $netInt    = $ipInt -band $maskInt
    $bcastInt  = [uint32]([uint64]$netInt + [uint64]$blockSize - 1)

    $usable = switch ($PrefixLength) {
        32      { 1 }                       # a single host - firewall rules, host routes
        31      { 2 }                       # RFC 3021 point-to-point, no broadcast
        default { $blockSize - 2 }          # minus network ID and broadcast
    }

    [pscustomobject]@{
        Address     = $IPAddress
        Prefix      = "/$PrefixLength"
        SubnetMask  = ConvertTo-IPString $maskInt
        NetworkID   = ConvertTo-IPString $netInt
        FirstUsable = if ($PrefixLength -ge 31) { ConvertTo-IPString $netInt }   else { ConvertTo-IPString ($netInt + 1) }
        LastUsable  = if ($PrefixLength -ge 31) { ConvertTo-IPString $bcastInt } else { ConvertTo-IPString ($bcastInt - 1) }
        Broadcast   = if ($PrefixLength -ge 31) { 'n/a' }                        else { ConvertTo-IPString $bcastInt }
        UsableHosts = $usable
    }
}

# Usage
Get-SubnetInfo -IPAddress 192.168.1.100 -PrefixLength 26
# Address / Prefix / SubnetMask      / NetworkID     / FirstUsable   / LastUsable     / Broadcast      / UsableHosts
# 192.168.1.100  /26  255.255.255.192  192.168.1.64    192.168.1.65    192.168.1.126    192.168.1.127    62

# Are two hosts on the same subnet? Compare NETWORK IDs, never the addresses themselves.
(Get-SubnetInfo 10.10.10.50 24).NetworkID -eq (Get-SubnetInfo 10.10.11.50 24).NetworkID   # False
```

**⚠ Two PowerShell landmines this function deliberately avoids:** `0xFFFFFFFF` parses as `-1` in Windows PowerShell 5.1, and `-bnot` on a `[uint32]` silently widens to a signed type. Both produce plausible-looking but wrong subnet maths. The version above uses only addition and subtraction on explicitly-sized integers. Verified against every prefix from /1 to /32.

**WHY do the arithmetic by hand at all, if this function exists?** Because you will be standing at a switch with no laptop, and because a mask that "looks wrong" is a hypothesis you need to form in seconds. Use the head for the hypothesis and the function for the commitment.

---

### `[NETF-08]` Routing

A **router** forwards traffic between independent networks based on destination address. Every routing decision answers one question: *which interface, and which next device, gets me closer?*

#### The routing table

| Column | Meaning |
|---|---|
| **Destination network** | The prefix this entry describes |
| **Next hop** | The IP of the neighbouring router to hand the packet to |
| **Metric / hops** | Cost. Lower wins when two routes match equally |
| **Interface** | The local NIC used to reach the next hop |

**Longest prefix match wins.** A packet to `10.10.5.7` matching both `10.0.0.0/8` and `10.10.5.0/24` takes the **/24** — the more specific route always wins, regardless of metric. This is why a stray `/32` route can hijack traffic in a way that looks impossible.

**The default route** is `0.0.0.0/0` — "everything I have no better entry for." It points at the default gateway.

```powershell
Get-NetRoute -AddressFamily IPv4 | Sort-Object -Property DestinationPrefix | Format-Table -AutoSize
Get-NetRoute -DestinationPrefix 0.0.0.0/0     # what is my default gateway, really
Find-NetRoute -RemoteIPAddress 8.8.8.8        # which route and source IP WOULD be used
route print                                   # CMD equivalent, works anywhere
```

**`Find-NetRoute` is underused.** It answers "which path would this actually take" without sending a packet — valuable on multi-homed servers and any machine with a VPN client installed.

#### Routing protocols — the vocabulary

| Term | Meaning |
|---|---|
| **Autonomous System (AS)** | A collection of networks under one operator's control |
| **ASN** | The number identifying an AS, allocated by **IANA** |
| **Interior Gateway Protocol (IGP)** | Routing *within* one AS — OSPF, EIGRP, RIP, IS-IS. Split into **link-state** and **distance-vector** |
| **Exterior Gateway Protocol (EGP)** | Routing *between* autonomous systems |
| **BGP** | The EGP that runs the internet. Routers exchange reachability so each learns optimal paths |

**IANA** allocates IP address space and ASNs. **ICANN** is its sister organization, governing the domain name system. In practice: IANA = numbers, ICANN = names.

**Relevance to SMB support:** you will rarely configure BGP. You will regularly need to say *"the failure is beyond our demarc, in the ISP's AS"* and be right. Traceroute (`[NET-04]`) is how you demonstrate that.

---

### `[NETF-09]` Layer 4 — ports, TCP, and UDP

#### Ports and multiplexing

A **port** is a 16-bit number (0–65535) identifying which service on a host should receive the traffic. One IP address hosts many services; ports are what disambiguate them.

- **Multiplexing** — many services' traffic combined onto one IP on the way out.
- **Demultiplexing** — the receiving host sorting incoming traffic back to the right service by port.

| Range | Name | Notes |
|---|---|---|
| **0–1023** | Well-known / system | Binding requires elevation on Unix and is conventionally privileged on Windows |
| **1024–49151** | Registered | Vendor-assigned (1433 SQL, 3389 RDP) |
| **49152–65535** | **Dynamic / ephemeral** | Source ports for outbound connections |

**Ephemeral port ranges in practice:** IANA specifies 49152–65535. **Windows (Vista and later) uses 49152–65535.** **Linux typically uses 32768–60999.** Confirm before writing a firewall rule for return traffic:

```powershell
netsh int ipv4 show dynamicport tcp
Get-NetTCPConnection -State Established | Select-Object LocalPort, RemoteAddress, RemotePort, OwningProcess
```

**WHY it matters:** a connection is identified by the **5-tuple** — source IP, source port, destination IP, destination port, protocol. **Ephemeral port exhaustion** is a real production failure on busy servers and NAT gateways: connections start failing with no obvious cause while the machine looks idle.

#### TCP vs UDP — choose by failure mode, not by speed

| | TCP | UDP |
|---|---|---|
| Connection | Established before data | None — fire and forget |
| Delivery | Guaranteed, ordered, retransmitted | No guarantee, no ordering |
| Overhead | Higher (20-byte minimum header, ACKs) | Lower (8-byte header) |
| Fails by | **Slowing down** | **Losing data silently** |
| Used by | HTTP/S, SMB, RDP, LDAP, SMTP | DNS queries, DHCP, NTP, VoIP media, streaming |

**The practical statement:** TCP degrades visibly under packet loss; UDP degrades invisibly. A choppy Teams call and a slow file copy on the same link are the *same* underlying problem presenting differently.

#### The three-way handshake — TCP connection setup

| Step | Direction | Flag |
|---|---|---|
| 1 | A → B | **SYN** — "I want to connect, here is my sequence number" |
| 2 | B → A | **SYN/ACK** — "Acknowledged, here is mine" |
| 3 | A → B | **ACK** — "Acknowledged. Connection established" |

**WHY it matters diagnostically:** `Test-NetConnection -Port` reports `TcpTestSucceeded : True` only when a full three-way handshake completed. That is much stronger evidence than a ping — it proves layers 1 through 4 **and** that a process is actually listening and accepting. See `[NET-01]`.

**Reading the failure:**

| Observation | Meaning |
|---|---|
| SYN sent, **RST** returned | Host reachable, **nothing listening** on that port. Service is down or bound to a different interface |
| SYN sent, **no response at all** (timeout) | A **firewall is silently dropping** the traffic. This is the signature of a firewall rule, not a stopped service |
| Handshake completes, application then fails | Layers 1–4 are fine. **The problem is authentication, certificates, or app config** |

**That distinction — RST versus timeout — is one of the highest-value diagnostic facts in this manual.** It separates "the service is down" from "the firewall is blocking me," which are escalated to entirely different teams.

#### The four-way handshake — TCP teardown

`FIN` → `ACK` → `FIN` → `ACK`. Four steps because each direction closes independently; one side can stop sending while still receiving.

**Relevant flags to recognize in a capture:** `SYN` (open), `ACK` (acknowledge), `FIN` (graceful close), `RST` (abrupt reset — *something refused or aborted*), `PSH` (deliver to the app now), `URG` (urgent).

---

### `[NETF-10]` DNS — resolution, servers, and records

**DNS** resolves names into IP addresses. **It is the first thing to check and the most common root cause** — see `[DOCTRINE-01]` and the DNS-first ordering in `[NET-TRIAGE]`.

#### The five server roles

| Role | Job |
|---|---|
| **Caching** | Stores previous lookups for their TTL. Answers repeat queries locally |
| **Recursive** | Performs the *full* resolution on the client's behalf, walking the hierarchy |
| **Root** | Knows which TLD server to ask. Top of the hierarchy |
| **TLD** | Authoritative for a top-level domain (`.com`, `.org`, `.mil`). Knows which authoritative server to ask |
| **Authoritative** | Holds the actual records for a zone and returns the definitive answer |

**🔄 UPDATED — "there are 13 root servers" is misleading.** There are **13 root server *addresses*** (labeled A through M) — a limit derived from the original UDP packet size constraint. Those 13 addresses are served by **well over a thousand physical instances worldwide** via **anycast**, where the same IP is announced from many locations and you reach the topologically nearest one. Saying "13 servers" implies a fragility that does not exist.

#### The resolution chain

1. Client checks its **local cache** (`ipconfig /displaydns`)
2. Client checks the **hosts file** (`[NETF-15]`)
3. Client queries its **configured DNS server** (recursive resolver)
4. Resolver checks **its** cache
5. Resolver asks a **root** server → gets a referral to the TLD
6. Resolver asks the **TLD** server → gets a referral to the authoritative
7. Resolver asks the **authoritative** server → gets the answer
8. Resolver caches the answer for the record's **TTL** and returns it

**⚠ TRAP — you are debugging step 4, not step 7.** When a record was changed and clients still see the old value, the cause is almost always caching at step 1 or step 4, and the fix is time or a flush — not another change to the record.

#### Record types

| Type | Purpose | Field relevance |
|---|---|---|
| **A** | Name → IPv4 | The common case |
| **AAAA** ("quad A") | Name → IPv6 | **Stale AAAA records on a DC cause real outages** — see `[BUILD-P2]` |
| **CNAME** | Alias one name to another name | Cannot coexist with other records at the same name. Cannot be used at a zone apex |
| **MX** | Where to deliver mail for this domain | Includes a **priority** value; lower wins |
| **SRV** | Locates a service: protocol, port, host, priority, weight | **This is how a domain controller is found.** Not by ping — see `[WIN-PREJOIN]` |
| **TXT** | Arbitrary text | Now load-bearing: **SPF, DKIM, DMARC**, and domain-ownership verification for M365/Entra |
| **PTR** | IP → name (reverse lookup) | Lives in a reverse lookup zone. **Mail servers check it**; missing PTR causes delivery failures |
| **NS** | Delegates a zone to a name server | Where delegation breaks |
| **SOA** | Start of Authority — zone serial, refresh, TTL defaults | Zone transfer and replication troubleshooting |

**🛑 "Round robin" is not a record type.** It is a *behavior*: when multiple A records exist for one name, the server returns them in rotating order to spread load. It is crude load distribution with no health checking — a dead host stays in rotation. If a source lists it alongside A/CNAME/MX as a record type, that source is wrong.

#### Zones and delegation

- **Zone** — an administrative portion of the DNS namespace you control.
- **Zone file** — the configuration declaring all records for that zone.
- **Reverse lookup zone** — enables IP → name queries via PTR records.
- **Domains** mark where control passes from a TLD server to an authoritative server.
- **Registrar** — the organization that assigns domain names. Where you change NS records, and the thing clients forget they have.

#### Commands

```powershell
Resolve-DnsName contoso.com                          # default A/AAAA
Resolve-DnsName contoso.com -Type MX                 # mail routing
Resolve-DnsName contoso.com -Type TXT                # SPF / DKIM / DMARC / verification
Resolve-DnsName _ldap._tcp.dc._msdcs.ad.contoso.com -Type SRV   # locate domain controllers
Resolve-DnsName 10.10.10.10 -Type PTR                # reverse lookup
Resolve-DnsName contoso.com -Server 8.8.8.8          # bypass internal DNS to compare answers
Resolve-DnsName contoso.com -DnsOnly -NoHostsFile    # ignore cache and hosts file

ipconfig /displaydns                                  # what the client currently believes
Clear-DnsClientCache                                  # flush client cache
Clear-DnsServerCache                                  # flush the SERVER cache (on the DNS server)
```

**✅ VERIFY a DNS problem is DNS:** resolve the name against an external resolver (`-Server 8.8.8.8`) and against the internal one. **Different answers = your DNS. Same answers = not DNS.** That single comparison ends most arguments.

**Anycast** also routes traffic to the nearest of many identical destinations based on location, congestion, or link health — the mechanism behind public resolvers and CDNs.

---

### `[NETF-11]` DHCP — automatic addressing

Every host on a TCP/IP network needs **four** things configured. DHCP exists to deliver all four automatically:

1. **IP address**
2. **Subnet mask**
3. **Default gateway**
4. **DNS server**

**⚠ TRAP:** a host can have a valid address and mask and still be useless. "It has an IP" is not "it is configured." Check all four, every time — see `[NET-TRIAGE]`.

#### DORA — the DHCP transaction

| Step | Message | Sender | Transport |
|---|---|---|---|
| **D** | **DISCOVER** | Client | Broadcast — it has no address and does not know the server |
| **O** | **OFFER** | Server | Offers an address and lease terms |
| **R** | **REQUEST** | Client | Broadcast — formally requests **that** offer, telling other servers no |
| **A** | **ACK** | Server | Confirms; the lease begins |

**WHY DISCOVER is a broadcast, and why that matters:** broadcasts do not cross routers. A DHCP server on another VLAN will never hear the client. The fix is a **DHCP relay / IP helper** — see `[NET-11]`.

**Lease renewal:** the client attempts renewal at **50% of lease time** (T1) directly with its server, and at **87.5%** (T2) broadcasts to any server. It keeps the address until the lease fully expires.

#### Allocation types

| Type | Behavior | Use |
|---|---|---|
| **Dynamic** | Address drawn from a pool, returned on expiry and reusable | Standard for clients |
| **Automatic** | Address drawn from a pool, then permanently assigned to that device | Rare |
| **Fixed / reservation** | Specific IP tied to a specific MAC | Printers, APs, cameras, anything referenced by IP |

**Prefer a DHCP reservation over a static IP on the client.** A reservation is centrally visible, centrally changeable, and inherits options 6 and 15 automatically. A static IP configured on the device is invisible, is forgotten, and is the single most common cause of a broken second DC — see `[AD-FAILOVER]` and `[NET-10]`.

```powershell
ipconfig /all                              # current lease, server, and expiry
ipconfig /release ; ipconfig /renew        # force a new DORA cycle
Get-DhcpServerv4Scope                      # on the Windows DHCP server
Get-DhcpServerv4Lease -ScopeId 10.10.10.0
Get-DhcpServerInDC                         # AUTHORISED DHCP servers — see the trap below
```

**⚠ TRAP — the rogue DHCP server.** A consumer router plugged into a LAN port hands out its own scope and gateway. Symptom: *some* clients break, seemingly at random, with a wrong gateway or wrong DNS. Compare `ipconfig /all`'s "DHCP Server" field against the address you expect. Windows Server DHCP requires AD authorization, which is precisely why you should serve DHCP from Windows where a server exists.

---

### `[NETF-12]` NAT, port forwarding, VPN, and proxies

#### NAT — Network Address Translation

A gateway rewrites the **source IP** of an outbound datagram to its own public address, remembering the original so replies can be rewritten back. This is how many private hosts share one public address.

- **Port preservation** — the gateway keeps the client's chosen source port where it can, and reassigns only on collision.
- **Port forwarding** — inbound traffic to a specific external port is always delivered to a nominated internal host and port. The mechanism behind exposing an internal service.

**🛑 NAT is not a firewall.** It obscures internal addressing as a side effect. It enforces no policy. Do not let "we're behind NAT" stand in for a security control.

**⚠ TRAP — CGNAT breaks inbound.** If your WAN address is in `100.64.0.0/10`, the ISP is NATing you as well, and **port forwarding cannot work** no matter how the router is configured. Confirm the WAN IP before spending an hour on firewall rules. Remedy: request a public IP from the ISP, or use an outbound-initiated tunnel.

#### VPN

Extends a private network to hosts that are not physically on it, by encrypting traffic across an untrusted network.

- **Split tunnel** — only traffic for corporate ranges enters the tunnel; everything else goes direct. Lower load, less visibility.
- **Full tunnel** — all traffic enters the tunnel. More control, more bandwidth, and it breaks local printing and geo-based services.

**⚠ TRAP — VPN + MTU.** Tunnel headers shrink the usable MTU. Symptom: small requests succeed, large transfers or specific websites hang. Test with `ping -f -l 1472 <host>` and reduce until it passes to find the real path MTU.

#### Proxies

| Type | Sits in front of | Purpose |
|---|---|---|
| **Forward proxy** | The **client** | Acts on behalf of internal users: content filtering, caching, egress logging |
| **Reverse proxy** | The **server** | Appears as one server externally while distributing to many behind it: TLS termination, load balancing, WAF |

---

### `[NETF-13]` Wireless

| Term | Meaning |
|---|---|
| **Frequency band** | A section of radio spectrum agreed for a class of communication — 2.4 GHz, 5 GHz, 6 GHz |
| **Channel** | A smaller subdivision of a band. Overlapping channels between nearby APs cause interference |
| **Wireless Access Point (AP)** | Bridges the wireless segment to the wired network. A **layer 2** device |

**Band trade-off, stated once:** **2.4 GHz** travels further and penetrates walls better, has only **three non-overlapping channels (1, 6, 11)**, and is congested by everything from microwaves to Bluetooth. **5 GHz** is faster with far more channels but shorter range. **6 GHz** (Wi-Fi 6E/7) is clean and fast with the shortest range and no legacy client support.

#### 802.11 standards *(current as of August 2026 — this table ages; protocol facts elsewhere in this manual do not)*

| IEEE standard | Marketing name | Band | Max theoretical rate |
|---|---|---|---|
| 802.11 (legacy, 1997) | — | 2.4 GHz | 2 Mbps |
| 802.11b (1999) | *(informally Wi-Fi 1)* | 2.4 GHz | 11 Mbps |
| 802.11a (1999) | *(informally Wi-Fi 2)* | 5 GHz | 54 Mbps |
| 802.11g (2003) | *(informally Wi-Fi 3)* | 2.4 GHz | 54 Mbps |
| **802.11n (2009)** | **Wi-Fi 4** | 2.4 & 5 GHz | 600 Mbps |
| **802.11ac (2013)** | **Wi-Fi 5** | 5 GHz | ~6.9 Gbps |
| **802.11ax (2021)** | **Wi-Fi 6** *(certification began 2019)* | 2.4 & 5 GHz | ~9.6 Gbps |
| **802.11ax + 6 GHz** | **Wi-Fi 6E** | 6 GHz | ~9.6 Gbps |
| **802.11be (2024)** | **Wi-Fi 7** | 2.4 / 5 / 6 GHz | ~46 Gbps |

**🔄 UPDATED — "Wi-Fi 0/1/2/3" are not real branding.** The Wi-Fi Alliance introduced generation numbers starting at **Wi-Fi 4**. Retroactive numbers for a/b/g are informal community usage and will not appear on any datasheet. Use the IEEE letter for anything older than 802.11n.

**All published rates are theoretical PHY maximums under ideal conditions.** Real throughput is typically 40–60% of the figure, and range claims are marketing. Never quote these numbers to a client as an expectation.

#### Wireless security

| Standard | Status | What to do |
|---|---|---|
| **WEP** | **Completely broken.** Crackable in minutes with commodity tools | **Replace immediately.** Treat any WEP network as an open network |
| **WPA (TKIP)** | Deprecated. Designed as a firmware-upgradable stopgap for WEP hardware | Replace |
| **WPA2 (AES-CCMP)** | Acceptable minimum. Vulnerable to KRACK if unpatched, and to offline dictionary attacks on weak PSKs | Acceptable with a strong passphrase |
| **WPA3 (SAE)** | **Current.** Resists offline dictionary attack; forward secrecy | **Target state** |
| **WPA2/WPA3 Enterprise (802.1X)** | Per-user credentials or certificates rather than a shared key | **Correct for business.** See `[SECF-11]` |

**🛑 MAC filtering is not a security control.** MAC addresses are transmitted **unencrypted in every frame**, including on WPA networks. An attacker sniffs an allowed MAC in seconds and spoofs it in one command. It is an inconvenience to honest users and no obstacle to anyone else. Its only legitimate use is inventory hygiene, never access control.

**Rogue AP** — an unauthorised access point attached to your network, usually by a well-meaning employee. Distinguish it from an **evil twin**, which impersonates your SSID *without* touching your network in order to harvest credentials. Different threats, different responses: the rogue AP is a network breach to be found and unplugged; the evil twin is an attack on your users that MAC filtering and WPA cannot address.

---

### `[NETF-14]` ICMP and error handling

Two capabilities that are often conflated:

- **Error detection** — a protocol can determine that something went wrong (the Ethernet FCS, the IP header checksum).
- **Error recovery** — a protocol can *fix* it (TCP retransmission). **Detection without recovery is the norm at lower layers.**

**ICMP** carries control and error messages back to a sender: destination unreachable, time exceeded, fragmentation needed. Its payload deliberately includes the header of the offending packet so the sender knows **which** transmission failed.

| ICMP message | Meaning in the field |
|---|---|
| **Echo Request / Reply** | `ping`. Type 8 / type 0 |
| **Time Exceeded** | TTL hit zero. **This is what makes traceroute work** |
| **Destination Unreachable — network** | No route exists |
| **Destination Unreachable — host** | Route exists, host does not answer ARP |
| **Destination Unreachable — port** | Host is up, **nothing listening on that UDP port** |
| **Fragmentation Needed (DF set)** | An MTU problem. Blocking this message causes **PMTUD black holes** — the classic "some sites load, some hang forever" |

**🛑 A failed ping does not mean a host is down.** ICMP is very commonly blocked by policy — on Windows Firewall by default, on most cloud VMs, and at most perimeter firewalls. `Test-NetConnection` reporting `PingSucceeded : False` and `TcpTestSucceeded : True` is a **healthy** result. See `[NET-01]`.

**🛑 Do not block all ICMP on a firewall.** Blocking Fragmentation Needed breaks Path MTU Discovery and produces intermittent, extremely hard-to-diagnose hangs.

---

### `[NETF-15]` Name resolution order on Windows, and the hosts file

Windows resolves a name in this order. **Knowing the order is how you explain "it works on my machine."**

1. **Check if the name is the local host** (loopback)
2. **DNS client cache** — including entries preloaded from the hosts file
3. **Hosts file** — `C:\Windows\System32\drivers\etc\hosts`
4. **DNS server query**
5. **LLMNR / mDNS** (link-local multicast — often disabled for security)
6. **NetBIOS / WINS** (legacy; should not be present in a modern environment)

**Hosts file** — a flat file mapping addresses to names, one per line, no extension. It **overrides DNS**.

```
10.10.10.50    fileserver    fileserver.ad.contoso.com
```

**⚠ TRAP — the hosts file entry nobody remembers.** A technician adds a hosts entry to test a migration and never removes it. Months later that one machine reaches the decommissioned server while everyone else is fine. **When one machine disagrees with every other machine about where a name points, check the hosts file before anything else.**

```powershell
Get-Content C:\Windows\System32\drivers\etc\hosts | Where-Object { $_ -notmatch '^\s*#' -and $_.Trim() }
Resolve-DnsName fileserver -NoHostsFile      # deliberately bypass it to compare
```

**Loopback** — `127.0.0.1` (and `::1` for IPv6) sends traffic to the host itself. Traffic never reaches the NIC. Useful for proving a service is listening *at all*, independent of any network problem:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 443
```

If loopback succeeds and the LAN address fails, the service is running and the problem is **binding or firewall**, not the application.

**Public DNS servers** — open resolvers anyone may use. Useful as a control in diagnosis (`[NETF-10]`), and as a **temporary** measure only. **Never configure a domain-joined client to use one** — it cannot resolve the SRV records that locate domain controllers, and everything Kerberos-dependent breaks. See `[NET-10]`.

| Provider | Addresses |
|---|---|
| Cloudflare | `1.1.1.1` / `1.0.0.1` |
| Google | `8.8.8.8` / `8.8.4.4` |
| Quad9 (filtered) | `9.9.9.9` |

---

### `[NETF-16]` IPv6 essentials

| Prefix | Type | Meaning |
|---|---|---|
| **`FE80::/10`** | **Link-local unicast** | Auto-configured from the interface, valid on that segment only. **Every IPv6 interface has one.** Non-routable |
| **`FF00::/8`** | **Multicast** | Addresses groups of hosts at once. IPv6 has no broadcast; multicast replaces it |
| `2000::/3` | Global unicast | Routable public addressing |
| `FC00::/7` | Unique local (ULA) | The IPv6 analogue of RFC 1918 |
| `::1` | Loopback | IPv6 equivalent of `127.0.0.1` |

**Tunnelling** — IPv6 datagrams encapsulated inside IPv4 datagrams to cross IPv4-only networks, de-encapsulated at the far end. A **tunnel broker** provides the endpoints so you need not deploy equipment.

**🛑 Do not disable IPv6 on Windows domain controllers.** Microsoft advises against it and components assume its presence. When a DC resolves to an unexpected public IPv6 address, the fix is to stop the router advertising, then clean the stale AAAA records — full procedure at `[BUILD-P2]`. This is correction #11 in `[APX-C]`.

```powershell
Get-NetIPAddress -AddressFamily IPv6 | Format-Table IPAddress, InterfaceAlias, PrefixOrigin, SuffixOrigin
Get-NetIPInterface -AddressFamily IPv6 | Format-Table InterfaceAlias, RouterDiscovery, Dhcp
```

---

### `[NETF-17]` HTTP, HTTPS, and status codes

**HTTP** is the request/response protocol of the web. **HTTPS** is HTTP inside a **TLS** session, providing encryption, integrity, and server authentication.

**🔄 UPDATED — SSL is dead; stop saying "SSL certificate."** SSL (Secure Sockets Layer) was superseded by **TLS**. SSL 2.0 and 3.0 are prohibited. **TLS 1.0 and 1.1 were formally deprecated in 2021 (RFC 8996).** Current usable versions are **TLS 1.2 and TLS 1.3**. If a source presents "SSL" and "TLS" as two interchangeable current protocols, it is describing history, not configuration. The certificate is an **X.509 certificate**; "SSL certificate" survives only as marketing vocabulary.

#### Status code classes

| Class | Meaning | Whose problem |
|---|---|---|
| **1xx** | Informational — request received, continuing | — |
| **2xx** | **Success** | Nobody's |
| **3xx** | **Redirection** — resource is elsewhere | Usually configuration |
| **4xx** | **Client error** | **The requester's** — request, credentials, or permissions |
| **5xx** | **Server error** | **The server's** — escalate to whoever owns it |

#### The ones you will actually meet

| Code | Meaning | First thing to check |
|---|---|---|
| **301 / 302** | Moved permanently / temporarily | Redirect loops, mixed HTTP/HTTPS |
| **400** | Bad request | Malformed request, oversized header |
| **401** | **Unauthorized** — *not authenticated* | Credentials missing, expired token, MFA |
| **403** | **Forbidden** — *authenticated but not permitted* | **Authorization**, not authentication. Different fix entirely |
| **404** | Not found | URL or the resource itself |
| **429** | Too many requests | **Rate limiting** — very common with Graph and other APIs. Back off and retry |
| **500** | Internal server error | Server-side application fault |
| **502** | Bad gateway | A **reverse proxy** got a bad answer from a backend |
| **503** | Service unavailable | Backend down or overloaded |
| **504** | Gateway timeout | Backend did not answer the proxy in time |

**401 vs 403 is the single most useful distinction here** — it is the HTTP expression of authentication versus authorization (`[SECF-08]`), and it tells you whether to reset a credential or edit a permission.

---

### `[NETF-18]` File sharing protocols

| Protocol | Native to | Port | Notes |
|---|---|---|---|
| **SMB** | Windows | **445** | Also carries **Group Policy delivery from SYSVOL** — see `[NET-08]`. Use SMB 3.x; **SMB1 must be disabled** |
| **NFS** | Unix/Linux | 2049 | Traditionally host-based rather than user-based trust |
| **Samba** | Cross-platform | 445 | An **implementation of SMB** for Linux/Unix. Integrates with printer services and can join a Windows domain |

**Clarify the vocabulary once:** SMB is the *protocol*. Samba is a *product* that speaks it. Saying "we use Samba" on a Windows-only network is a category error.

**🛑 SMB1 is deprecated and must be disabled.** It is the protocol exploited by WannaCry and NotPetya. It also disables SMB signing negotiation improvements.

```powershell
Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Get-SmbServerConfiguration | Select-Object EnableSMB1Protocol, EnableSMB2Protocol, RequireSecuritySignature
Get-SmbConnection            # what dialect am I actually negotiating right now?
```

---

### `[NETF-19]` Email protocols

| Protocol | Direction | Default / Secure port | Behavior |
|---|---|---|---|
| **SMTP** | **Sending** and server-to-server relay | 25 (relay), **587** (authenticated submission), 465 (implicit TLS) | The only one of the three that *sends* |
| **POP3** | Retrieval | 110 / **995** | Downloads to one device. **By default deletes the server copy** |
| **IMAP** | Retrieval | 143 / **993** | Leaves mail on the server; syncs state across many devices |

**The distinction that matters in a ticket:** if a user can receive but not send, look at **SMTP** (port 587, authentication, the outbound path). If they can send but not receive, look at **IMAP/POP3** or mail routing (**MX records**, `[NETF-10]`).

**⚠ TRAP — POP3 "deletes from the server" is a default, not a law.** Almost every client offers "leave a copy on server." The real hazard is the *combination*: POP3 configured on a second device downloads and deletes mail the primary device never saw. **If a user reports mail vanishing from one device, check for a forgotten POP3 client before assuming a mailbox problem.**

**🛑 Use the TLS ports only.** 110 and 143 transmit credentials and message content in cleartext. In a modern tenant, prefer modern authentication over IMAP/POP entirely — basic authentication for these protocols is disabled by default in Exchange Online.

---

## 23 — SECURITY FUNDAMENTALS `[SECF]`

Concepts and vocabulary. The operational security procedures live at `[SEC-IR]` (`[SOP-09]`), `[SEC-LAPS]` (`[AD-14]`), `[SEC-LP]` (`[APX-B]`), and `[SOP-10]`. This section is what those procedures assume you already understand.

---

### `[SECF-01]` Malware taxonomy — classify by propagation and purpose

| Type | Defining characteristic | Why the distinction matters |
|---|---|---|
| **Virus** | **Attaches to a host file** and requires that file to be executed to spread | Cleaning means repairing or removing infected files |
| **Worm** | **Self-propagating.** Needs no host file and no user action; spreads over the network on its own | **Network isolation is the immediate containment step.** This is why you pull the cable first |
| **Trojan** | Disguises itself as something legitimate | The user *chose* to run it. Delivery is social, so the control is user training plus application allow-listing |
| **Ransomware** | Encrypts data and extorts payment | **Backups are the only reliable control.** See `[DOCTRINE-07]` — an untested backup is a hypothesis |
| **Botnet** | A network of compromised machines under an attacker's **command and control**, used for distributed tasks (DDoS, spam, mining) | Your machine is the weapon, not the target. Detected by **outbound** traffic patterns |
| **Backdoor** | A deliberate alternative access path that bypasses normal authentication | Persistence. **Removing the malware does not remove the backdoor** |
| **Rootkit** | Tools granting **privileged access while actively concealing their own presence** — often at kernel or firmware level | It subverts the tools you would use to find it. **Detection generally requires booting from external media; remediation means rebuilding** |
| **Logic bomb** | Malicious code that **triggers on a condition** — a date, an event, a record disappearing from a payroll file | Often insider-planted. Dormant, so it survives scanning until the trigger fires |
| **Adware / Spyware** | Monetises or exfiltrates user activity | Frequently the visible symptom of a wider compromise |

**🔄 UPDATED — two definitions in common circulation are incomplete and worth correcting:**

- **"A rootkit is a collection of software or tools that an admin would use."** This describes the etymology and omits the point. The defining property is **concealment of privileged access**. A tool that grants root without hiding is an admin tool; one that hides is a rootkit.
- **"A logic bomb is malware that is intentionally installed."** Intentional installation is true of most malware and distinguishes nothing. The defining property is the **conditional trigger**.

**The containment order does not depend on the type.** Isolate the host from the network → preserve evidence → identify the account and blast radius → rebuild rather than clean if privilege was obtained. See `[SOP-09]`.

---

### `[SECF-02]` Attack types

| Attack | Mechanism | Defense |
|---|---|---|
| **DNS cache poisoning** | Tricks a resolver into caching a forged record, redirecting users to attacker infrastructure | DNSSEC; restrict recursion; patch resolvers; monitor for unexpected answers |
| **DoS (Denial of Service)** | Exhausts a resource so legitimate users cannot be served | Rate limiting, **flood guards**, upstream scrubbing |
| **DDoS (Distributed DoS)** | The same, from many hosts — usually a botnet | Cannot be absorbed at the edge; requires provider-level mitigation |
| **Injection (SQLi, command)** | Untrusted input is interpreted as code | Parameterised queries; input validation; least privilege on the service account |
| **Cross-Site Scripting (XSS)** | Injected script executes **in another user's browser** — the attack targets the *user* of the service, not the server | Output encoding, Content Security Policy |
| **Man-in-the-Middle** | Attacker relays and possibly alters traffic between two parties | TLS with **validated** certificates; 802.1X; avoid untrusted networks |
| **Rogue AP** | Unauthorised access point **attached to your network** | Wireless scanning, switch port security, 802.1X |
| **Evil twin** | AP **impersonating your SSID**, not attached to your network | Certificate-based Wi-Fi auth (EAP-TLS); user awareness |
| **Password spraying** | One common password tried against **many** accounts, staying under lockout thresholds | **Lockout policy alone does not stop this.** Requires MFA, banned-password lists, sign-in risk detection |
| **Credential stuffing** | Credentials breached elsewhere replayed against your services | MFA; leaked-credential detection |
| **Brute force** | Exhaustive guessing against one account | Lockout thresholds, MFA, rate limiting |

**⚠ TRAP — lockout policy and password spraying.** A tightened lockout threshold makes spraying *easier* to weaponise as a denial-of-service against your own users, while barely inconveniencing the attacker who is only trying one password per account per cycle. **MFA is the control; lockout is not.** Relevant when tuning `[GPO-04]` A and reading `[AD-LOCKOUT]`.

---

### `[SECF-03]` Social engineering

**Social engineering targets people rather than systems.** It is the delivery mechanism for most successful breaches, which means the strongest technical stack in the world is bypassed by one convincing phone call.

| Technique | Description |
|---|---|
| **Phishing** | Fraudulent message at scale, harvesting credentials or delivering payload |
| **Spear phishing** | Targeted at a specific individual using researched detail |
| **Whaling** | Aimed at executives — higher authority, higher payoff |
| **Vishing / Smishing** | Voice call / SMS as the channel |
| **Business Email Compromise (BEC)** | A real, compromised or spoofed internal account requests a payment or data change. Frequently no malware at all |
| **Pretexting** | An invented scenario establishing a reason to comply |
| **Baiting** | Physical or digital lure — the USB stick in the car park |
| **Tailgating** | Following an authorized person through a controlled door |
| **MFA fatigue / push bombing** | Repeated push prompts until the user approves one to make it stop |

**🛑 The highest-risk social engineering target in IT is the help desk itself.** A caller who cannot pass verification but is convincingly frustrated is attempting an attack until proven otherwise. **Verify identity out-of-band before resetting any credential — always, including for people you recognize by voice.** Voice is now cheaply cloned. This is the practical reason `[SOP-11]` exists.

Operational handling of a reported phishing message: `[SOP-10]`. Handling of a confirmed compromise: `[SOP-09]`.

---

### `[SECF-04]` Cryptography — the vocabulary, stated precisely

| Term | Definition |
|---|---|
| **Plaintext** | The original readable message |
| **Cipher** | The operation applied |
| **Ciphertext** | The unreadable output |
| **Encryption algorithm** | The underlying logic converting plaintext to ciphertext |
| **Key** | The secret parameter that makes the output unique to you |
| **Cryptosystem** | The full collection of algorithms for key generation, encryption, and decryption |
| **Seed value** | A secret initialising value for a generation process |

**Kerckhoffs's principle:** a cryptosystem must remain secure **even if everything about the system is known, except the key.** This is why proprietary "secret" algorithms are a red flag, and why open, peer-reviewed standards (AES, RSA, TLS) are trusted precisely *because* everyone can inspect them. If a vendor's security argument depends on their algorithm being undisclosed, that is security by obscurity and it is not a control.

#### Cipher construction

| Type | How it works | Examples |
|---|---|---|
| **Substitution cipher** | Replaces parts of plaintext with ciphertext | Caesar, ROT13 — historical only |
| **Stream cipher** | Encrypts one character or digit at a time as it arrives | ChaCha20, RC4 *(RC4 is broken)* |
| **Block cipher** | Buckets data into fixed-size blocks and encodes each block as a unit | **AES**, 3DES, DES |

#### Symmetric vs asymmetric

| | Symmetric | Asymmetric (public key) |
|---|---|---|
| Keys | **One shared secret** for both encryption and decryption | **Key pair** — public encrypts, private decrypts |
| Speed | **Fast.** Suited to bulk data | Slow. Suited to small payloads |
| Problem it has | **Key distribution** — how do both parties get the key securely? | Computationally expensive |
| Problem it solves | Bulk encryption | **Key exchange and digital signatures** |
| Examples | **AES**, ChaCha20 | RSA, ECC, Diffie-Hellman |

**How they combine, and why it matters:** TLS uses **asymmetric** cryptography to authenticate the server and negotiate a shared secret, then switches to **symmetric** encryption for the actual session. You get asymmetric's key-distribution solution and symmetric's speed. Understanding this is why "is HTTPS RSA or AES?" is a malformed question — it is both, at different stages.

**Algorithm status, stated plainly:**

| Algorithm | Status |
|---|---|
| **AES-128 / 192 / 256** | **Current standard.** Symmetric block cipher; replaced DES |
| DES | **Broken.** 56-bit key, brute-forceable |
| 3DES | **Deprecated** — disallowed by NIST after 2023 |
| RC4 | **Broken.** Remove from any TLS configuration |
| RSA 2048+ | Acceptable. RSA-1024 is not |
| ECC / ECDSA | Current; shorter keys for equivalent strength |

---

### `[SECF-05]` Hashing — and the claim you should stop repeating

A **hash function** takes arbitrary input and maps it to a **fixed-size** output (a hash or digest). It is **one-way**: you cannot reverse a digest to recover the input.

**🛑 CORRECTION — "two different inputs will never produce the same output" is false.**

This claim appears in a great deal of training material and it is mathematically impossible. Inputs are unbounded; outputs are a fixed size. By the pigeonhole principle, **collisions must exist.** The property that actually matters is:

| Property | Correct statement |
|---|---|
| **Deterministic** | The same input always yields the same digest |
| **Fixed output size** | Regardless of input size |
| **Pre-image resistance** | Given a digest, it is infeasible to find *an* input producing it |
| **Second pre-image resistance** | Given an input, it is infeasible to find a *different* input with the same digest |
| **Collision resistance** | It is infeasible to find **any** two inputs that collide |
| **Avalanche effect** | A one-bit input change produces a completely different digest |

**WHY the distinction is operational, not pedantic:** MD5 and SHA-1 are broken **precisely because collisions can now be found deliberately** — a demonstrated SHA-1 collision was published in 2017, and MD5 collisions were used to forge a certificate authority signature in 2008. If you believe collisions are impossible, you have no framework for understanding why an algorithm gets retired, and you will accept `md5sum` as an integrity control long after it stopped being one.

| Algorithm | Status | Use |
|---|---|---|
| MD5 | **Broken** | Non-security checksums only. Never for integrity or signatures |
| SHA-1 | **Broken** | Deprecated everywhere. Being removed from certificate trust |
| **SHA-256 / SHA-512** | **Current** | File integrity, signatures, certificates |
| SHA-3 | Current | Alternative construction |
| **bcrypt / scrypt / Argon2 / PBKDF2** | **Current for passwords** | **Deliberately slow** with a work factor |

**🛑 Never store passwords with a general-purpose hash.** SHA-256 is *fast*, which is exactly wrong for passwords — speed helps the attacker. Password hashing requires a **salt** (unique per password, defeating rainbow tables) and a **tunable work factor** (making each guess expensive). Use bcrypt, scrypt, Argon2, or PBKDF2.

```powershell
Get-FileHash .\installer.exe -Algorithm SHA256          # verify a download against the vendor's published digest
Get-FileHash .\a.txt, .\b.txt -Algorithm SHA256         # compare two files
```

**✅ VERIFY:** compare the digest **character by character against the vendor's own site over HTTPS**. A hash published on the same page as a compromised download proves nothing — the attacker who replaced the file also updated the digest. The value of a hash comes from the independence of the channel that delivered it.

---

### `[SECF-06]` PKI and certificates

**Public Key Infrastructure (PKI)** defines the creation, storage, and distribution of digital certificates. A **digital certificate** is a file proving that an entity owns a particular public key, vouched for by a signing authority.

**The trust chain, which is what actually breaks:**

```
Root CA  (self-signed, in the OS/browser trust store)
   └── Intermediate CA  (signed by the root)
          └── Leaf / end-entity certificate  (the server's own)
```

A client trusts the leaf only if it can build an **unbroken chain** to a root it already trusts, **and** every certificate in that chain is unexpired, unrevoked, and correctly named.

**The five reasons a certificate error appears, in the order to check them:**

| # | Cause | Symptom / check |
|---|---|---|
| 1 | **Expired** | Check `NotAfter`. The most common cause by a wide margin |
| 2 | **Name mismatch** | The name requested is not in the Subject or **Subject Alternative Name**. Modern clients ignore Common Name entirely — **SAN is what counts** |
| 3 | **Untrusted issuer** | Self-signed, or a private CA whose root is not deployed to clients |
| 4 | **Incomplete chain** | Server is not sending the intermediate. **Works in a browser that cached the intermediate, fails from a server or API client** — a classic "it works on my machine" |
| 5 | **Revoked, or CRL/OCSP unreachable** | Revocation check fails or times out, often due to egress filtering |

```powershell
# Inspect the local machine store
Get-ChildItem Cert:\LocalMachine\My |
    Select-Object Subject, NotAfter, Thumbprint, @{n='DaysLeft';e={($_.NotAfter - (Get-Date)).Days}} |
    Sort-Object DaysLeft

# Find anything expiring within 60 days — worth putting in a monthly check
Get-ChildItem Cert:\LocalMachine\My |
    Where-Object { $_.NotAfter -lt (Get-Date).AddDays(60) }

# What certificate is a remote endpoint actually presenting?
$t = [Net.Sockets.TcpClient]::new('contoso.com', 443)
$s = [Net.Security.SslStream]::new($t.GetStream(), $false, { $true })
$s.AuthenticateAsClient('contoso.com')
$s.RemoteCertificate | Format-List Subject, Issuer, NotBefore, NotAfter
$s.Dispose(); $t.Dispose()
```

**⚠ TRAP — certificate expiry is a scheduled outage you did not schedule.** Add certificate expiry to `[SOP-06]` monthly maintenance. Every organization eventually has an outage caused by a certificate nobody owned.

**PGP (Pretty Good Privacy)** — an application providing authentication and confidentiality for data (classically email and files) using asymmetric cryptography. Notable for using a **web of trust** rather than a hierarchical CA: peers sign each other's keys instead of deferring to a root authority.

---

### `[SECF-07]` Hardware-backed security

| Component | What it is | What it gives you |
|---|---|---|
| **TPM (Trusted Platform Module)** | A discrete or firmware chip with a **unique RSA key burned in at manufacture** | Secure key generation and storage · hardware random number generation · **remote attestation** (proving the machine's boot state to a remote party) · **data binding and sealing** (data decryptable only on this machine, in this state) |
| **Secure Element** | Tamper-resistant chip embedded in a mobile microprocessor or mainboard | Secure key storage and an isolated execution environment for sensitive apps |
| **Secure Boot** | UEFI feature using public key cryptography to verify boot component signatures | Blocks bootkits and unsigned boot code before the OS loads |
| **Platform Key (PK)** | The public key corresponding to the private key used to sign boot files | The root of Secure Boot trust |
| **Full Disk Encryption (FDE)** | Encrypts the whole volume at rest | Data unreadable without the key if the device is lost or the disk removed |

**🔄 Spelling correction worth flagging:** the term is **Full *Disk* Encryption**, not "full desk encryption." It appears misspelled in several study sources.

**Where this lands in practice:** BitLocker is FDE, and it **seals its key to the TPM**, which is why changing boot configuration, firmware, or Secure Boot state triggers recovery-key prompts. That behavior is the TPM working correctly, not a fault. Operational procedures and recovery-key retrieval: `[DISK-03]`.

**🛑 FDE protects data at rest only.** A running, logged-in machine has the volume unlocked. Full disk encryption is not a defense against malware, a live remote session, or someone sitting at an unlocked screen.

---

### `[SECF-08]` AAA — authentication, authorization, accounting

| Term | Question it answers | Standard abbreviation |
|---|---|---|
| **Authentication** | **Who are you?** | **authn** |
| **Authorization** | **What are you allowed to do?** | **authz** |
| **Accounting** | **What did you do?** | — |

**🛑 CORRECTION — the abbreviations are `authn` and `authz`.**

A number of study sources state `"authn" → Authentication` and `"authnz" → Authorization`. The second is wrong. **`authz` is authorization**; `authnz` is not a standard term (it appears occasionally as shorthand for the *pair*, "authn/authz"). The convention is simply the first and last letter of each word: **auth-n** for authenticatio**n**, **auth-z** for authori**z**ation.

**WHY this matters beyond trivia:** the distinction is the single most common source of misdiagnosis in identity work.

| Symptom | Layer | Wrong fix | Right fix |
|---|---|---|---|
| Cannot sign in at all | **authn** | Adding permissions | Password, MFA, account state, Conditional Access |
| Signs in, then "access denied" | **authz** | Resetting the password | Group membership, role assignment, ACL |
| HTTP **401** | **authn** | — | Credentials or token |
| HTTP **403** | **authz** | — | Permissions |

**Three factors of authentication** — real MFA requires **different categories**, not two items from the same one:

| Factor | Examples |
|---|---|
| **Something you know** | Password, PIN, security question |
| **Something you have** | Phone with authenticator, FIDO2 key, smart card, TPM-bound device |
| **Something you are** | Fingerprint, face, iris |

**⚠ Password + security question is not MFA.** Both are "something you know." Two knowledge factors are one factor twice.

---

### `[SECF-09]` RADIUS, TACACS+, and Kerberos — three protocols, three jobs

| | **RADIUS** | **TACACS+** | **Kerberos** |
|---|---|---|---|
| **Primary use** | **Network access** — 802.1X, Wi-Fi, VPN | **Device administration** — logging into routers, switches, firewalls | **Domain authentication** — Windows AD, Linux realms |
| Transport | **UDP** 1812/1813 (legacy 1645/1646) | **TCP** 49 | 88 (TCP/UDP) |
| Encryption | **Password field only** — the rest of the packet is cleartext | **Entire payload** | Full ticket encryption |
| AAA separation | Authentication and authorization **combined** | **Separated** — you can authenticate centrally and authorize per-command | Authentication with authorization data in the ticket |
| Origin | Open standard (IETF) | Cisco-developed, widely implemented |  MIT |

**The distinction to hold onto:** **RADIUS controls who gets onto the network. TACACS+ controls who gets into the network gear.** Kerberos controls who you are inside a domain. Different questions.

**WHY TACACS+ separates authorization:** it enables per-command authorization and logging on network devices — a junior engineer can authenticate successfully and still be permitted only `show` commands. RADIUS cannot express that granularity.

---

### `[SECF-10]` Kerberos — the ticket flow, and why AD depends on it

Kerberos authenticates identity over **untrusted** channels using time-limited **tickets** rather than transmitting passwords, and provides **mutual** authentication — the server proves itself to the client as well.

**The components:**

| Component | Role |
|---|---|
| **KDC (Key Distribution Center)** | The whole service. **On Windows, every domain controller is a KDC** |
| **AS (Authentication Service)** | Verifies identity and issues the TGT. Part of the KDC |
| **TGS (Ticket Granting Service)** | Issues service tickets. Part of the KDC |
| **TGT (Ticket Granting Ticket)** | Proof of identity, obtained once per logon session |
| **Service ticket** | Proof of the right to access **one specific service** |
| **SPN (Service Principal Name)** | The identifier of a service instance in AD. **Kerberos cannot issue a ticket for a service with no SPN, or with a duplicate SPN** |

**The exchange, in three phases:**

| Phase | Messages | Frequency |
|---|---|---|
| **1 — Get a TGT** | `KRB_AS_REQ` → `KRB_AS_REP` (TGT + session key) | **Once per logon session** |
| **2 — Get a service ticket** | `KRB_TGS_REQ` → `KRB_TGS_REP` (service ticket + session key) | **Once per service type** |
| **3 — Use the service** | `KRB_AP_REQ` → `KRB_AP_REP` (mutual authentication) | **Once per service session** |

Step by step:

1. User logs on. The client sends `KRB_AS_REQ` to the KDC, with a **timestamp encrypted using a key derived from the password**.
2. The KDC decrypts it. Success proves the user knows the password **without the password crossing the network**. It returns a **TGT** encrypted with the KDC's own key (the client cannot read it — it only presents it).
3. To reach a file server, the client presents the TGT in `KRB_TGS_REQ`, naming the target **SPN**.
4. The TGS returns a **service ticket** encrypted with the service account's key.
5. The client presents that ticket to the file server in `KRB_AP_REQ`. The server decrypts it with its own key — proving the KDC issued it — and replies, proving its own identity in turn.

#### 🛑 Why the 5-minute clock skew limit exists

Step 1 authenticates using **an encrypted timestamp**. If the client's clock differs from the KDC's by more than the allowed skew — **5 minutes by default** — the KDC rejects the timestamp as a possible replay attack and authentication fails.

**This is the single most important operational consequence in this section.** It is why:
- `[AD-TIME]` treats time as a foundation item rather than a nicety,
- `[WIN-PREJOIN]` checks clock skew **before** attempting a domain join,
- a domain join failure on a VM restored from a snapshot is usually a time problem, not a network problem.

**What Kerberos failure looks like, and what it actually means:**

| Symptom | Likely cause |
|---|---|
| Authentication fails **only for some services**, others fine | **Missing or duplicate SPN** on that service |
| Everything fails after a snapshot restore, reboot, or VM migration | **Clock skew** |
| Works by IP, fails by hostname | Falling back to NTLM by IP; **Kerberos requires the SPN**, which is name-based |
| "The security database on the server does not have a computer account for this workstation" | Broken machine account trust — see `[WIN-04]` |

```powershell
klist                          # tickets currently cached
klist purge                    # discard them and force re-acquisition
w32tm /query /status           # local time source and current offset
w32tm /monitor                 # skew across all domain controllers
setspn -L CONTOSO\svc_sql      # SPNs registered to an account
setspn -X                      # FIND DUPLICATE SPNs across the forest — run this before deep-diving
```

**`setspn -X` is the highest-value command here.** Duplicate SPNs cause intermittent, service-specific authentication failures that look like everything except what they are.

---

### `[SECF-11]` 802.1X and EAP — port-based network access control

**802.1X** is the IEEE standard for carrying **EAP (Extensible Authentication Protocol)** over 802 networks — also called **EAP over LAN (EAPoL)**. It authenticates a device or user **before** granting network access at all.

**Three roles:**

| Role | Who | Job |
|---|---|---|
| **Supplicant** | The client device | Presents credentials |
| **Authenticator** | The switch port or wireless AP | Blocks all traffic except EAP until authentication succeeds |
| **Authentication server** | Usually **RADIUS** (NPS on Windows) | Makes the decision |

**EAP methods worth distinguishing:**

| Method | Credential | Assessment |
|---|---|---|
| **EAP-TLS** | **Certificates on both sides** | **Strongest.** Mutual authentication; no password to phish or spray. Requires PKI |
| PEAP-MSCHAPv2 | Server certificate + user password | Common and workable, but the password is still a password |
| EAP-TTLS | Server certificate + inner method | Similar posture to PEAP |

**WHY 802.1X is the real answer to the wireless questions in `[NETF-13]`:** it replaces a shared passphrase everyone knows with **per-user or per-device credentials that can be revoked individually.** An employee leaving does not require rotating a key across the entire organization. It also enables dynamic VLAN assignment — the identity determines the network segment.

---

### `[SECF-12]` SSO, OAuth, OIDC, and SAML

**Single Sign-On (SSO)** lets a user authenticate once and reach many services without re-authenticating to each.

| Protocol | What it actually does | Correct use |
|---|---|---|
| **SAML 2.0** | XML-based **authentication** assertion between an identity provider and a service provider | Enterprise web app SSO. Common in Entra ID enterprise application integrations |
| **OAuth 2.0** | **Authorization** framework — delegates *access to resources* without sharing credentials | Granting an app permission to read your mail |
| **OpenID Connect (OIDC)** | An **authentication** layer **built on top of OAuth 2.0**, adding an identity token | "Sign in with…" — modern SSO |

**🛑 CORRECTION — OAuth is not an authentication protocol.**

Study sources routinely describe OAuth as a way to log in. **OAuth 2.0 is authorization (`authz`).** It answers "may this application access this resource on my behalf?" It does **not** answer "who is this user?" **OIDC** was created specifically because people kept misusing OAuth for authentication and building insecure logins.

**Why this matters in Entra ID work:** when you consent to an application, you are granting **OAuth scopes** — authorization. When you sign in, you are using **OIDC or SAML** — authentication. Illicit consent grant attacks exploit exactly this gap: the user authenticates correctly and then authorizes a malicious application. **MFA does not stop a consent attack**, because nothing about the authentication was wrong. The control is restricting user consent, which is why `[M365-06]` and consent policies matter.

---

### `[SECF-13]` Access control

**Access Control List (ACL)** — the structure defining which principals hold which permissions on an object. NTFS permissions are ACLs; Azure RBAC assignments and firewall rules are the same idea in different domains.

| Model | Principle |
|---|---|
| **DAC** — Discretionary | The **owner** decides who gets access. NTFS default behavior |
| **MAC** — Mandatory | The **system** enforces labels; users cannot override. Government and military |
| **RBAC** — Role-Based | Access derives from **role**, not identity. **This is the AGDLP model in `[AD-AGDLP]` and Azure RBAC in `[AZ-08]`** |
| **ABAC** — Attribute-Based | Policy evaluates attributes (department, device state, location, risk). Conditional Access is ABAC |

**Implicit deny** — anything not **explicitly permitted** is denied. **This is the correct default posture for firewalls, ACLs, and Conditional Access.** The alternative — permit by default and enumerate what to block — requires you to have predicted every threat in advance, which nobody has ever managed.

**Least privilege** — grant the minimum access needed for the task, for the shortest time. Operational rules at `[SEC-LP]`.

**Separation of duties** — no single person controls a whole sensitive process end to end. In small teams this is often unachievable; **compensating with logging and alerting is the honest fallback**, and saying so plainly to a client is better than pretending the control exists.

---

### `[SECF-14]` Network hardening

**Network hardening** reduces attack surface through configuration rather than added products. The following is a baseline that costs nothing but time.

1. **Disable unused physical switch ports.** An unplugged port is an available port.
2. **Change every default credential**, including on printers, cameras, APs, and IPMI/iDRAC/iLO. Defaults are published.
3. **Disable unused services and protocols** — SMB1, Telnet, LLMNR, NetBIOS over TCP/IP, WPAD, plaintext FTP.
4. **Segment with VLANs** — separate workstations, servers, voice, guest, and IoT. **Printers and cameras belong on their own segment**; they are rarely patched and frequently exposed.
5. **Implicit deny at every boundary**, then permit only what is required and documented.
6. **802.1X on wired and wireless** where feasible (`[SECF-11]`).
7. **Management interfaces off the user network** and never internet-exposed. **RDP 3389 must never face the internet** — see `[NET-08]`.
8. **Patch on a schedule**, network devices included. Firmware is the most-forgotten patch surface in every environment.
9. **Centralised logging** with retention that outlives detection time (`[SECF-17]`).
10. **Rate limiting and flood guards** on public-facing services.

**🛑 Two controls that feel like security and are not:**

- **MAC filtering.** MAC addresses cross the air unencrypted in every frame. Sniff, spoof, done. It only obstructs legitimate users. See `[NETF-04]`.
- **Hiding the SSID.** The network name still appears in probe requests and association frames. It is trivially discovered, and it makes *client* configuration worse.

**"The less complex something is, the less likely there will be undetected flaws."** Complexity is itself an attack surface. Every exception, workaround, and one-off rule is a place for a flaw to hide — which is exactly why `[DOCTRINE-05]` insists that workarounds be written down. An undocumented workaround is a permanent, invisible increase in attack surface.

---

### `[SECF-15]` Defense in depth, attack vectors, and attack surface

| Term | Definition |
|---|---|
| **Attack vector** | The **method or mechanism** by which an attacker or malware gains access — a phishing email, an exposed RDP port, a USB device, an unpatched service |
| **Attack surface** | The **sum of all attack vectors** in a system. Reduce it by removing vectors, not by adding products |
| **Defense in depth** | **Multiple overlapping layers** of defense, so no single failure is a breach |

**Defense in depth applied to a single credential theft:**

| Layer | Control | What it stops |
|---|---|---|
| Physical | Locked comms room, no unattended ports | Direct device access |
| Perimeter | Firewall, implicit deny, no exposed RDP | Remote exploitation |
| Network | VLAN segmentation, 802.1X | **Lateral movement after entry** |
| Endpoint | EDR, Secure Boot, FDE, patching | Payload execution |
| Identity | **MFA**, Conditional Access, LAPS, least privilege | Credential reuse |
| Application | Input validation, allow-listing | Injection and unwanted execution |
| Data | Encryption, ACLs, **tested backups** | Exfiltration and ransomware |
| Detection | Logging, correlation, IDS/IPS, alerting | **Reduces dwell time when the above fail** |

**The honest framing for a client:** every layer will eventually fail. The purpose of depth is that **no single failure is sufficient**, and that detection catches the failure before it becomes an incident. A stolen password with MFA and segmentation in place is a support ticket; the same password without them is a breach.

---

### `[SECF-16]` Traffic capture and intrusion detection

#### Capture modes — three different things with similar names

| Mode | Layer | What it captures |
|---|---|---|
| **Promiscuous mode** | Wired NIC | **All frames the NIC receives**, not only those addressed to it. On a switched network that is limited to broadcast, multicast, and its own traffic — **unless the port is mirrored** |
| **Port mirroring** (SPAN) | Switch | Copies traffic from a port, port range, or entire VLAN to a designated monitoring port. **This is what makes promiscuous mode useful on modern switches** |
| **Monitor mode** | Wireless NIC | Captures **all wireless traffic across channels**, including frames from APs and clients it is not associated with |

**WHY promiscuous mode alone disappoints people:** hubs flooded every frame to every port, so promiscuous mode saw everything. **Switches forward by MAC**, so a promiscuous NIC sees very little. Without port mirroring or a network TAP, the capture is nearly empty — and technicians conclude their tooling is broken when it is working correctly.

```powershell
# Windows built-in capture — no third-party tooling required
netsh trace start capture=yes tracefile=C:\Temp\net.etl maxsize=512
# ...reproduce the problem...
netsh trace stop
# Convert the .etl with Microsoft Network Monitor / Message Analyzer, or open in Wireshark

# Lightweight alternative when you only need to know WHO is talking
Get-NetTCPConnection -State Established |
    Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort,
                  @{n='Process';e={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName}}
```

**`tcpdump`** — the lightweight command-line capture and analysis utility on Linux, BSD, and most network appliances. The tool you will actually have available on a firewall or a NAS. **Wireshark** is the GUI analyser for the same captures.

#### IDS and IPS

| | **IDS** — Detection | **IPS** — Prevention |
|---|---|---|
| Placement | **Out of band** — receives a copy via port mirror | **Inline** — traffic passes through it |
| Action | **Alerts** | **Alerts and blocks** |
| Failure mode | Missed alert | **A false positive blocks legitimate traffic** |

**NIDS (Network IDS)** monitors a segment or subnet from a mirrored port. **HIDS (Host IDS)** runs on an individual host and sees what the network cannot — file integrity changes, local process behavior, and **anything inside an encrypted session**, which is increasingly most traffic.

**Signatures** are the unique characteristics of known malicious traffic: specific packet sequences, or particular values in specific header fields. **Signature-based detection only finds what is already known** — it cannot catch a novel attack, which is why behavioral and anomaly detection exist alongside it.

**⚠ TRAP — the IPS that becomes an outage.** An inline IPS in blocking mode with aggressive signatures will eventually block something legitimate, and the failure presents as an unexplained application problem rather than a security event. **Deploy in detection mode first, tune against real traffic, then enable blocking** — and record the change under `[DOCTRINE-05]`, because a tuned IPS rule is a modification to the environment that the environment will remember long after you forget.

---

### `[SECF-17]` Logging and correlation

**Correlation analysis** is taking log data from different systems and matching events across them. It is where detection actually happens — a single event is rarely conclusive, and the sequence is what tells the story.

**The classic correlated sequence:**

1. Failed sign-ins from an unfamiliar country *(identity logs)*
2. A successful sign-in from the same address *(identity logs)*
3. An inbox rule created that forwards externally *(Exchange audit)*
4. Mass file access in SharePoint *(unified audit log)*
5. Outbound traffic to an unknown host *(firewall logs)*

**Individually, each is noise. In sequence, it is a documented compromise** — and it is the evidence `[SOP-09]` asks you to gather.

**What to ensure is being logged, before you need it:**

| Source | Minimum |
|---|---|
| Domain controllers | Sign-in success/failure (**4624 / 4625 / 4771**), account lockout (**4740**), group membership changes (**4728 / 4732 / 4756**) |
| Entra ID | Sign-in logs, audit logs, risky sign-ins |
| Exchange Online | Mailbox audit, **inbox rule creation**, forwarding changes |
| Firewall | Denied connections, outbound to unusual destinations |
| Endpoints | EDR alerts, process creation (**4688**) where feasible |

**🛑 Retention is the control that fails silently.** Default log retention is frequently shorter than the time it takes to notice a breach. A perfectly configured audit trail that rolled over three weeks ago is not evidence. **Confirm retention length as part of `[ASSESS-01]`, and state it in the handover at `[DOC-05]`.**

**⚠ TRAP — clock skew destroys correlation.** Correlating events across systems requires their timestamps to agree. This is a second, independent reason `[AD-TIME]` matters, alongside Kerberos (`[SECF-10]`). **Log in UTC where you can choose**, and record the timezone where you cannot.

---

## 24 — SYSTEMS AND DIRECTORY FUNDAMENTALS `[SYSF]`

Operating system, filesystem, and directory service concepts that the operational sections assume. Short by design — this exists so the vocabulary used elsewhere in the manual is defined somewhere.

---

### `[SYSF-01]` Filesystem concepts

| Term | Definition | Practical consequence |
|---|---|---|
| **Root directory** | The parent of all other directories. `C:\` on Windows, `/` on Linux | On Windows each volume has its own root; on Linux there is exactly one, and volumes are **mounted into** it |
| **Absolute path** | Starts from the root — `C:\Users\jdoe\report.docx`, `/home/jdoe/report` | **Always use absolute paths in scripts and scheduled tasks.** A scheduled task's working directory is not what you assume |
| **Relative path** | Starts from the current directory — `.\report.docx`, `..\shared\` | Fine interactively, a source of intermittent script failure otherwise |
| **Mounting** | Making a filesystem or disk accessible to the OS | On Windows: a drive letter, or a **mount point** in an empty NTFS folder. On Linux: attaching to a directory in the single tree |
| **Virtual memory** | An abstraction giving each process its own address space, backed by physical RAM plus a **paging file** on disk | When RAM is exhausted, pages move to disk. Heavy paging means the machine is **thrashing** — the symptom is disk-bound sluggishness, and the fix is RAM, not a faster disk |

**🔄 Definition correction:** virtual memory is sometimes described as "how the OS provides physical memory to applications." That describes memory management generally. **Virtual memory specifically is the *abstraction* of a private, contiguous address space per process, decoupled from physical layout** — with paging to disk as the well-known side effect, not the definition.

```powershell
Get-PSDrive -PSProvider FileSystem                       # what is mounted and where
Get-Volume                                                # volumes, filesystems, free space
Get-CimInstance Win32_PageFileUsage                       # paging file location and usage
(Get-Counter '\Memory\Pages/sec').CounterSamples.CookedValue   # sustained high value = thrashing
```

---

### `[SYSF-02]` Partition tables — MBR and GPT

| | **MBR** | **GPT** |
|---|---|---|
| Era | Legacy | **Current standard** |
| Maximum volume size | **2 TB** | 9.4 ZB — effectively unlimited |
| Partitions | **4 primary** (a third-party extended partition scheme works around this) | **128 by default on Windows**, no practical limit |
| Firmware | BIOS / legacy boot | **UEFI boot** |
| Redundancy | **Single partition table.** Corruption is fatal | **Primary and backup tables** plus CRC protection |

**Use GPT for anything modern.** MBR only for legacy compatibility. This is required for disks over 2 TB and for UEFI boot, and it is a prerequisite for Secure Boot (`[SECF-07]`). Full partitioning and reformatting procedures, including recovery from a deleted BitLocker partition: `[DISK-02]`.

```powershell
Get-Disk | Format-Table Number, FriendlyName, PartitionStyle, Size, HealthStatus
```

**⚠ TRAP — converting between them.** `MBR2GPT.exe` converts in place without data loss, but **firmware must be switched to UEFI at the same time** or the machine will not boot. Confirm the current mode before touching anything:

```powershell
# 'UEFI' or 'Legacy'
$env:firmware_type
Confirm-SecureBootUEFI     # errors on legacy BIOS systems — that is itself the answer
```

---

### `[SYSF-03]` Software packaging and installation

| Term | Meaning |
|---|---|
| **`.msi`** | **Microsoft Installer package.** A structured database that guides Windows Installer through installation, maintenance, repair, and removal. **Supports silent install and clean uninstall**, which is why it is the preferred format for deployment |
| **`.exe` installer** | An arbitrary executable. May wrap an MSI, may not. **Silent-install switches are vendor-specific and undocumented as often as not** |
| **`.msix` / `.appx`** | Modern Windows packaging. Containerised, clean uninstall |
| **Side-loading** | Installing an application directly rather than through an app store |

**WHY packaging matters for deployment:** Intune and Group Policy software installation both need an **unattended, silent, non-interactive** install. An MSI provides that by design (`msiexec /i package.msi /qn`). An EXE requires you to discover the vendor's silent switch, and to verify it actually suppresses every prompt. Intune application deployment: `[MDM-02]`.

**🛑 Do not inventory software with `Win32_Product`.** Querying it triggers an **MSI reconfiguration of every installed product** — slow, and it fills the event log. Use the registry Uninstall keys instead: `[WIN-INV]`. This is correction #8 in `[APX-C]`.

---

### `[SYSF-04]` Directory services and LDAP

**Directory service** — a service that organises data about an organization's resources and makes it searchable: users, groups, computers, printers, policies.

**Replication** — directory data is copied and distributed across multiple physically separated servers while presenting as **one unified datastore** for querying and administration. This is what makes a second domain controller meaningful, and why replication health is checked after every change: `[AD-HEALTH]`.

**LDAP (Lightweight Directory Access Protocol)** — the protocol used to query and modify directory services over a network.

| Implementation | Notes |
|---|---|
| **Active Directory** | Microsoft's directory service. Uses LDAP **plus** Kerberos, DNS, and its own replication |
| **OpenLDAP** | Open-source LDAP directory |

**Do not conflate them.** LDAP is a *protocol*; Active Directory is a *product* that speaks it. AD depends on far more than LDAP — remove DNS or Kerberos and it stops working entirely, even though LDAP is unaffected.

#### The LDAP conversation

1. **Bind** — authenticate the client to the directory server
2. **Operation** — search, add, modify, delete
3. **Result** — one or more entries returned
4. **Unbind** — close the session

**Bind types, and the one that matters:**

| Type | Behavior |
|---|---|
| **Anonymous bind** | No credentials. Should be disabled or tightly restricted |
| **Simple bind** | Username and password — **transmitted in cleartext unless the session is protected** |
| **SASL bind** | Uses a mechanism such as Kerberos or NTLM. **Correct choice on Windows** |

**🛑 A simple bind over port 389 sends the password in the clear.** Use **LDAPS on 636**, or **StartTLS**, or a SASL bind. When configuring a third-party appliance (a NAS, a copier, a VPN, a monitoring tool) to authenticate against AD, this is the setting people get wrong, and a packet capture will show the service account password in plaintext.

**⚠ Related:** Microsoft has been progressively enforcing **LDAP channel binding and signing**. Appliances configured for simple bind on 389 will begin failing after enforcement is enabled. When a long-working device suddenly cannot authenticate to AD, check this before anything else.

Ports: **389 LDAP · 636 LDAPS · 3268/3269 Global Catalog** — `[NET-08]`.

---

### `[SYSF-05]` Windows credential stores

| Store | Contains | Location |
|---|---|---|
| **SAM (Security Account Manager)** | **Local** account credentials | `C:\Windows\System32\config\SAM` — locked while Windows runs |
| **NTDS.dit** | **Domain** account credentials | `C:\Windows\NTDS\ntds.dit` on every domain controller |
| **LSASS memory** | Credentials **in use** by the current session | Process memory — the target of credential-dumping tools |

**🛑 CORRECTION — the SAM stores password *hashes*, not passwords.**

Study material frequently describes the SAM as "a database in Windows that stores usernames and passwords." It stores **hashes**. The distinction is not pedantic:

- An attacker who obtains the SAM does **not** obtain passwords. They obtain hashes, which they must crack — or, worse, **use directly** in a pass-the-hash attack without ever cracking them.
- This is exactly why **local administrator password reuse across machines is catastrophic**: one compromised workstation yields a hash that authenticates to every other machine sharing that password. **This is the entire reason LAPS exists** — see `[SEC-LAPS]`.
- It is also why **domain credentials belong in NTDS.dit on a DC**, not in the local SAM, and why a domain controller is a Tier 0 asset (`[SEC-LP]`).

**Practical consequence for `[SOP-09]`:** if a machine was compromised while a privileged account was logged into it, **treat that account's credentials as stolen**, whether or not any cracking is evidenced. Reset it. LSASS held it in memory.

---

### `[SYSF-06]` Scaling and availability concepts

| Term | Definition | Where you meet it |
|---|---|---|
| **Load balancer** | Distributes incoming requests across multiple backends so no single one is overwhelmed | `[NETF-12]` reverse proxy; Azure Load Balancer / Application Gateway `[AZ-06]` |
| **Autoscaling** | Capacity increases or decreases automatically with demand; you pay only for what runs | `[AZ-05]` — a core cloud cost argument |
| **Replication** | Data copied across multiple servers, presented as one datastore | AD replication `[AD-HEALTH]`; Azure storage redundancy `[AZ-07]` |
| **High availability** | Redundancy such that a component failure does not cause an outage | Second DC `[AD-FAILOVER]`; DHCP failover `[BUILD-P13]` |
| **Failover** | Automatic transfer of service to a standby | **Must be tested to be claimed** — see below |

**🛑 Untested failover is not failover.** Powering off DC01 and logging in successfully proves **cached credentials work**, not that failover works. A real test requires DNS handing out both DCs and an account that has **never** signed into that machine. Full procedure: `[AD-FAILOVER]` §13.3. This is correction #12 in `[APX-C]`, and it is the same principle as `[DOCTRINE-07]` — an untested backup is a hypothesis, and so is untested redundancy.

**Scaling vocabulary:** **scale up / vertical** = a bigger machine. **Scale out / horizontal** = more machines. Horizontal scaling is what load balancing and autoscaling enable, and it is the cloud-native default.

---

## 25 — PERSONAL ADDITIONS

*(Empty. This is where new material goes as you learn it. Use the `[TAG-NN]` format from §00.3 so it stays searchable, then move entries up into the relevant section when you have a few in the same area.)*

---

## 26 — MICROSOFT PURVIEW AND DATA GOVERNANCE `[PURV]`

Principles and procedures for the Purview toolset. This is the data-governance layer that §11 `[M365]` administers around and §27 `[AI]` depends on.

**Everything in this section lives in the Microsoft Purview portal — `purview.microsoft.com`.** The classic Purview compliance portal has been retired; any runbook pointing at `compliance.microsoft.com` needs rewriting.

**The single most useful thing in this section is `[PURV-01]`.** Purview's tools sound alike and overlap in description. In practice each answers exactly one question, and picking the wrong tool wastes days.

---

### `[PURV-01]` The solution map — which tool answers which question

| Solution | One-sentence purpose | The phrase that means "this one" |
|---|---|---|
| **Information Protection** (sensitivity labels) | Classify, label, and encrypt content; protection travels **with the file** | "Encrypt," "watermark," "protection follows the document" |
| **Data Loss Prevention (DLP)** | Detect and block risky **movement** of sensitive content | "Block," "prevent sharing," "policy tip," "stop them emailing it out" |
| **Insider Risk Management (IRM)** | Detect risky **user behavior** from activity signals plus HR context | "Departing employee," "mass download," "exfiltration," "sequence of activities" |
| **Communication Compliance** | Monitor **messages** for policy violations | "Harassment," "inappropriate language," "insider trading," "conduct policy" |
| **DSPM for AI** | Discover and govern **AI usage and AI data exposure** | "Shadow AI," "what is Copilot touching," "someone pasted data into ChatGPT" |
| **Data Lifecycle Management** | Retain and delete content on schedule | "Keep for seven years," "delete after 90 days," "records" |
| **Compliance Manager** | Assess and improve **regulatory** posture | "GDPR," "HIPAA," "ISO 27001," "are we compliant" |
| **Data Explorer / Content explorer** | Show **where** sensitive and labeled content is | "Where does our sensitive data live?" |
| **Activity Explorer** | Show **what users did** with sensitive content | "What happened to this file, in what order?" |
| **eDiscovery** | Legally search, preserve, review, export | "Legal hold," "litigation," "export for counsel" |
| **Audit** | The unified record of who did what, when | "Prove it," "forensic timeline" |

**The four distinctions that cause the most wasted effort:**

| Confused pair | The actual difference |
|---|---|
| **DLP vs sensitivity labels** | A label **classifies and protects the content itself**. DLP **watches movement and intervenes**. Best practice is both — label the content, then write DLP rules keyed off the label |
| **DLP vs IRM** | DLP acts **inline on content** at the moment of an action and can block it. IRM scores **patterns of behavior over time** for human review; it does not sit inline blocking things |
| **DLP vs Communication Compliance** | DLP asks *is sensitive data leaving?* Communication Compliance asks *is this message itself inappropriate?* Harassment in a Teams chat contains no sensitive information type — **DLP would never fire** |
| **Data Explorer vs Activity Explorer** | *Data* Explorer = **where the content is** (a snapshot of state). *Activity* Explorer = **what happened to it** (a stream of events) |

---

### `[PURV-02]` Data classification — you cannot protect what you have not identified

Classification is the foundation everything else in Purview stands on. Four methods, and the choice is driven by whether the data has a **pattern**, a **template**, or a **known value list**.

| Method | How it works | Precision | Use it for |
|---|---|---|---|
| **Sensitive information type (SIT)** | Pattern matching — regex, checksums (Luhn for credit cards), supporting keyword evidence, confidence level | Good | Well-formed standard data: credit cards, SSNs, passport and routing numbers |
| **Trainable classifier** | ML model trained on example documents; recognizes a **category** of content, not a pattern | Good for concepts | Content with no fixed pattern: resumes, source code, contracts, NDAs |
| **Exact Data Match (EDM)** | Matches against a **hashed, uploaded list of your organization's actual values** | **Highest — near-zero false positives** | Your employee IDs, your customer account numbers, your patient IDs |
| **Fingerprinting** | Matches documents derived from a known template | High | Standard forms — a specific HR template, a specific application form |

**⚠ SIT vs EDM is the choice that determines whether your DLP deployment survives.** A regex SIT for a US SSN matches anything shaped like `123-45-6789`, including numbers that are not SSNs. That produces false positives, which produce alert fatigue, which produces a disabled policy. **"We need high accuracy" or "only *our* customers' account numbers" → EDM.** "Detect credit card numbers generally" → SIT.

**⚠ SIT vs trainable classifier.** If the content has a recognizable *format*, it is a SIT. If the content is recognizable only as a *kind of document* — "this is a resume" — it is a trainable classifier. **There is no regex for "resume."**

**Custom trainable classifier:** supply **at least 50 sample documents** (50–500 seed items recommended), then test and retrain. Built-in classifiers already cover resumes, source code, harassment, profanity, threat, and healthcare templates — check the built-in list before building your own.

**EDM workflow:** define a **schema** → create a **rule package** → **hash and upload** the sensitive source data → validate. The source values are hashed and salted; **the actual data is never stored in the service**, which is what makes EDM acceptable to a client legal team.

---

### `[PURV-03]` Sensitivity labels

A sensitivity label is metadata **written into the file itself**, so its protection travels with the content — out of SharePoint, onto a USB stick, into a personal email, onto a home PC.

| Capability | What a label can enforce |
|---|---|
| **Encryption** | Restrict who may open the file and what they may do — read, edit, print, copy, forward. Enforced by Azure Rights Management, and it **works offline** |
| **Content marking** | Headers, footers, watermarks |
| **Access and sharing controls** | Block external sharing, block unmanaged-device access |
| **Container labeling** | Apply a label to a **Team, Microsoft 365 group, or SharePoint site** to control privacy, guest access, unmanaged-device access, and default sharing link type |
| **Auto-labeling** | Apply automatically by content inspection — client-side in Office apps, or service-side in SharePoint, OneDrive, and Exchange |

**How labels get applied:** manually by the user · **recommended** via a policy tip the user may accept or dismiss · **automatically**. **Label policies** publish labels to users or groups and set behavior: which labels appear, whether labeling is **mandatory**, whether a **default label** applies, whether users may **downgrade**, and whether **justification** is required to do so.

**Label priority.** Labels are ordered, the one lowest in the list is the most restrictive, and **only one sensitivity label can be applied to an item at a time.**

**🛑 Sensitivity label ≠ retention label. They are independent and an item can carry one of each.** Sensitivity answers *who may access this and what may they do with it*. Retention answers *how long must this be kept and when is it deleted*. Anything describing both protection and a time period is describing two labels, not one.

**⚠ Deploy labels before you deploy anything that depends on labels.** DLP rules keyed off a label, auto-labeling policies, and Copilot label inheritance (`[AI-02]`) all assume a working label taxonomy. Build the taxonomy first, keep it to **four or five labels maximum**, and resist the client who wants fourteen. A taxonomy nobody can hold in their head is a taxonomy nobody applies correctly.

---

### `[PURV-04]` Data Loss Prevention

DLP inspects content **in motion** and acts when a policy matches.

| Element | Detail |
|---|---|
| **Locations** | Exchange Online · SharePoint · OneDrive · Teams chat and channels · **endpoint devices** (Windows/macOS, via Defender for Endpoint) · non-Microsoft cloud apps (via Defender for Cloud Apps) · on-premises repositories · **Copilot and AI apps** |
| **Conditions** | Sensitive information types, sensitivity labels, trainable classifiers, recipient domain, file type, sharing scope |
| **Actions** | Block · block with override · warn · **policy tip** · require business justification · encrypt · restrict access · notify admins · raise an alert |
| **Endpoint DLP activities** | Copy to USB · copy to network share · print · clipboard into an unallowed app · upload to an unallowed browser or cloud service |

**Policy tips** are the user-facing message explaining why an action was flagged. They are what makes DLP an **educational** control rather than a silent blocker, and they measurably reduce repeat violations.

#### DLP deployment procedure

**DO**

1. **Classify first.** Confirm the SITs, labels, or classifiers the policy will key off actually match your content — test them in Data Explorer (`[PURV-11]`) before writing a rule.
2. **Create the policy in simulation/test mode with policy tips OFF.**
3. **Let it run for a full business cycle** — a minimum of one to two weeks, longer if the client has monthly or quarterly processes.
4. **Review every match.** Sort by rule and by user. Look for one department generating 80% of the hits — that is a business process the rule does not understand, not a set of violations.
5. **Tune** — tighten conditions, add exceptions, raise the instance-count threshold, switch a SIT for EDM.
6. **Re-run in simulation with policy tips ON.** Users now see the tip; you see whether they change behavior.
7. **Enforce**, starting with warn-and-override before block.

**WHY the staged rollout:** a DLP policy switched straight to block will stop a legitimate business process on day one, and the resulting escalation gets the whole policy disabled — usually permanently, and usually by someone senior enough that you do not get a second attempt. **The staged rollout is not caution, it is the only version that survives contact with the business.**

**🛑 PITFALL — a high false-positive rate is a finding about the policy, not about the users.** If tuning does not fix it, the classification method is wrong. Go back to `[PURV-02]` and consider EDM.

**✅ VERIFY:** Purview → Data Loss Prevention → **Alerts**. Confirm alerts are firing, that they name the rule and the content, and that a deliberate test violation (a dummy file with test data you control) produces the expected action and the expected tip.

**DLP for Copilot exists and is one of the few controls that restricts Copilot beyond ordinary permissions** — see `[AI-02]`.

---

### `[PURV-05]` Insider Risk Management

IRM detects risky **behavior** by people who already have legitimate access, by combining activity signals with context.

| Element | Detail |
|---|---|
| **Signals** | File downloads and copies · exfiltration to USB or personal cloud · printing · emailing to personal accounts · renaming to obscure · deleting after downloading · security policy violations |
| **Context** | **HR connector** signals — resignation date, termination date, performance review, role change — plus working hours and location |
| **Policy templates** | Data theft by departing users · data leaks · data leaks by priority users · security policy violations · risky browser usage · **risky AI usage** |
| **Output** | Risk-scored **alerts** → triage → **cases** → act: notify the user, escalate to HR or Legal, escalate for investigation, hand to eDiscovery |
| **Privacy controls** | **Pseudonymized usernames by default**, role-based investigator access, enforced separation of duties between analysts and investigators |

**License: Microsoft 365 E5** or the compliance add-on.

**The signature scenario is the departing employee.** An HR connector supplies a resignation date; the *combination* of that signal with a spike in downloads of confidential files raises the risk score above what either signal produces alone. **HR context plus behavior = IRM, not DLP.**

**🛑 Do not deploy IRM without involving HR and Legal first.** IRM surveils employees. In many jurisdictions and under many works-council agreements, deploying it without documented consultation is itself a violation. The pseudonymization and separation-of-duties controls exist because regulators expect them — turning them off to make investigation easier is a decision that needs to be made by someone with the authority to make it, in writing.

---

### `[PURV-06]` Communication Compliance

Monitors **the content of messages** for policy violations across Exchange email, Teams chat and channels, **Viva Engage**, **Copilot prompts and responses**, and connected third-party sources.

| Element | Detail |
|---|---|
| **Detects** | Harassment and bullying · threats · profanity · adult content · **regulatory violations** (insider trading, MNPI, market manipulation) · sensitive-information sharing · conduct-policy breaches |
| **Techniques** | Keyword dictionaries and regex, plus **trainable classifiers** for context-sensitive detection |
| **Scope controls** | By user or group · channel · direction (inbound/outbound/internal) · language · **sampling percentage** |
| **Review workflow** | Flagged items land in a **reviewer dashboard** → resolve · tag as false positive · notify the user · escalate to HR/Legal · escalate for investigation (creates an eDiscovery case) |
| **Privacy** | Pseudonymized usernames, scoped reviewer permissions, required separation between policy authors and reviewers |

**License: Microsoft 365 E5** or the compliance add-on.

**⚠ The sampling percentage is the setting people miss.** Monitoring 100% of communications for a large tenant produces a review queue nobody can service. Start at a sample rate the reviewers can actually clear, and raise it only when the queue is being worked.

**🔄 Yammer is now Viva Engage.** Any policy scope or runbook still referencing Yammer is referencing a retired brand — see `[APX-C]` #33.

---

### `[PURV-07]` Retention, Data Lifecycle Management, and the four principles

Retention answers two questions: **how long must we keep this**, and **when must we get rid of it**. Both are legal exposures. Keeping too little breaks compliance; keeping too much creates discoverable liability — and, since Copilot, lets AI surface stale content as though it were current (`[AI-01]`).

| Mechanism | Scope | How applied | Use it when |
|---|---|---|---|
| **Retention policy** | **Location-based** — whole workloads: all mailboxes, all sites, all Teams chats | Assigned to locations by the admin; **no user action, invisible to users** | Baseline hygiene: "delete all Teams chat older than 90 days" |
| **Retention label** | **Item-based** — an individual document, email, or item | Applied manually, automatically by rule, or as a library default | Precise control: "this contract is retained 7 years from its expiry date" |
| **Auto-apply label policy** | Applies labels by condition | Admin | Conditions: keywords, SITs, trainable classifiers, cloud attachments |
| **Records management** | Declares an item a **record**, locking it against edit and deletion | A retention label configured as a record | Regulatory records with immutability requirements |

**Retention actions:** retain only · delete only · **retain then delete**. Periods calculate from when content was **created**, **last modified**, **labeled**, or from a defined **event** (contract expiry, employee departure).

#### 🛑 The four principles of retention — memorize these

When multiple retention settings apply to the same item, conflicts resolve in this order:

| # | Principle | Meaning |
|---|---|---|
| 1 | **Retention wins over deletion** | If one setting says retain and another says delete, the content is **retained**. Nothing is ever lost to a conflict |
| 2 | **The longest retention period wins** | Among conflicting retention periods, the longest applies |
| 3 | **Explicit inclusion wins over implicit** | A **label** (on the specific item) beats a **policy** (on a whole location). A policy scoped to specific users beats one applied to everyone |
| 4 | **The shortest deletion period wins** | Once retention obligations are satisfied, among conflicting deletion timers the shortest applies |

**The canonical question this answers:** *a 5-year deletion policy and a 7-year retention policy both apply — what happens?* **Retained for 7 years, then deleted.** Not deleted at 5. This is the single most useful fact in the whole retention area, and it is why a badly designed retention estate grows rather than shrinks.

**WHY it is built this way:** the failure mode Microsoft optimized against is *destroying evidence you were legally obliged to keep*, which is a far worse outcome than *keeping something a bit too long*. Every one of the four principles biases toward retention. **The practical consequence: retention conflicts silently increase storage and eDiscovery scope. They never silently delete.**

#### Holds are not retention

A **litigation hold** (per-mailbox, set in Exchange) or an **eDiscovery hold** (set on a case in Purview) preserves everything in scope **indefinitely, overriding retention and deletion**, until released.

**🛑 Releasing a hold can trigger immediate deletion** of everything the retention policy would otherwise have removed during the hold period. Before releasing, confirm with Legal in writing that the matter is closed, and understand what will evaporate the moment you click it.

**⚠ Four things, four jobs, and they get confused constantly:** *Retention policy* = broad, location-based, invisible. *Retention label* = precise, item-based, can declare a record. *Litigation hold* = preserve this mailbox until Legal says stop. *Sensitivity label* = access and encryption, not time.

---

### `[PURV-08]` eDiscovery — the unified experience

**🔄 UPDATED — classic eDiscovery no longer exists.** Microsoft retired **all** classic eDiscovery experiences on **31 August 2025**: classic Content Search, classic eDiscovery (Standard), and classic eDiscovery (Premium). Classic Content Search and Standard were pulled earlier, on **26 May 2025**. There is now **one unified eDiscovery experience in the Microsoft Purview portal, built around cases**.

**Content Search is now delivered inside a system-generated eDiscovery case**, available by default to members of the **eDiscovery Manager** and **eDiscovery Administrator** role groups. Premium *capabilities* — review sets, advanced analytics, near-duplicate detection, email threading, redaction — still exist and are still gated by E5-class licensing, but they are **features of one product, not a separate product with its own UI**.

**Any documentation, runbook, or reference describing "eDiscovery Standard and Premium" as two editions is describing a structure that no longer exists** — see `[APX-C]` #28.

| Step | What you do |
|---|---|
| **Create or open a case** | The container for everything on one matter |
| **Add data sources** | Custodians (people) and non-custodial locations — mailboxes, OneDrive, SharePoint sites, Teams |
| **Place holds** | Preserve content in scope. **Holds override retention and deletion policies** |
| **Build searches** | **KQL (Keyword Query Language)**, plus conditions: date range, sender/recipient, subject, file type, sensitivity label, compliance label |
| **Review** | Statistics first, then review sets for near-duplicate detection, threading, themes, tagging, and **redaction** |
| **Export** | Deliver to counsel |

**Search scope:** Exchange Online mailboxes · SharePoint sites · OneDrive accounts · Teams chats and channels · Microsoft 365 Groups · **Viva Engage** · **Copilot interactions**.

**Roles:** **eDiscovery Manager** works their own cases. **eDiscovery Administrator** can access **all** cases in the organization.

**🛑 Place the hold before you run the search.** Content can be deleted between the moment a matter arises and the moment you preserve it, and the deletion is not your client's problem — it becomes yours. Hold first, search second, always.

---

### `[PURV-09]` Audit

The unified audit log is covered in full at `[M365-18]` because that is where you go looking for it during an incident. The Purview-side facts that matter here:

- It is searched in the **Purview portal → Audit → Search**, not in the Microsoft 365 admin center and not in Entra.
- **Audit (Standard) retains 180 days. Audit (Premium) retains 1 year, extendable to 10 with an add-on.**
- **Copilot prompts and responses are captured in the audit log and are discoverable through eDiscovery.** If anyone asks whether AI interactions are auditable, the answer is yes — see `[AI-01]`.

---

### `[PURV-10]` Compliance Manager

Assesses posture against **regulations and standards** — GDPR, HIPAA, ISO 27001, NIST, SOC 2, and hundreds more.

| Concept | Detail |
|---|---|
| **Assessment** | A regulation or standard scoped to your environment |
| **Controls** | Split into **Microsoft-managed** (Microsoft implements and evidences these for you), **your-organization-managed** (you must implement and evidence), and **shared** |
| **Improvement actions** | Concrete steps that raise the score; each can be **assigned to an owner**, tracked, and evidenced with uploaded documentation |
| **Compliance Score** | **Points-based and risk-weighted** — points for completed improvement actions, weighted by how much risk each mitigates |

**🛑 Compliance Score is NOT "the percentage of controls satisfied."** It is points-based and risk-weighted. Reference material describing it as a simple percentage is wrong — `[APX-C]` #34. The practical consequence: two organizations at "62%" can be in completely different risk positions, and reporting the raw number to a client without the improvement-action detail is misleading.

**⚠ The Microsoft-managed controls inflate the starting score.** A tenant on day one shows a non-trivial score because Microsoft's own controls are already satisfied. **Report the delta on your-organization-managed controls**, which is the part the client can actually influence and the part an auditor will examine.

---

### `[PURV-11]` Data Explorer vs Activity Explorer

| | **Data Explorer / Content explorer** | **Activity Explorer** |
|---|---|---|
| Answers | **Where does our sensitive and labeled content live?** | **What did users actually do with it?** |
| Shape of the data | A **snapshot of state** | A **stream of events** |
| Scans | SharePoint, OneDrive, Exchange, Teams | The same, plus endpoint activity |
| Filter by | SIT, sensitivity label, retention label, trainable classifier, location, content type | User, activity type, date, location, label, SIT, policy |
| Shows | Actual items, locations, owners, sharing status — drill to individual files | Label applied · label changed · **label downgraded, with the justification the user typed** · file read · copied · shared externally · DLP rule matched · endpoint activity |
| Access | Restricted to **Content Explorer List Viewer** and **Content Explorer Content Viewer** roles | Purview role groups |

*"Find all documents containing SSNs"* → **Data Explorer.** *"Show me who downloaded and then externally shared this file"* → **Activity Explorer.**

**⚠ Activity Explorer shows activity even when no policy fired**, which is what makes it proactive rather than purely alert-driven. It is the right tool for "we think something happened but no alert was raised."

**Run Data Explorer before any AI rollout** so you know what sensitive content exists and where it is over-exposed — `[AI-07]` step 1.

---

### `[PURV-12]` DSPM for AI

**Data Security Posture Management for AI** is Purview's surface for the AI era, and it is the newest thing in the portal.

| Capability | What it does |
|---|---|
| **Discover AI activity** | Which AI applications are in use — **Microsoft 365 Copilot and agents**, plus **non-Microsoft generative AI** reached from managed devices and browsers |
| **Detect shadow AI** | Unsanctioned AI tool usage IT has not approved — the AI equivalent of shadow IT |
| **Assess sensitive-data exposure** | Sensitive information flowing into AI prompts and appearing in AI responses |
| **Oversharing assessments** | Where sensitive data is over-exposed such that Copilot could surface it to the wrong people |
| **One-click policy recommendations** | Suggests and deploys ready-made policies — DLP for AI apps, IRM risky-AI-usage, auto-labeling — from its own recommendations |
| **Reporting** | Activity Explorer views of AI prompts and responses with label and policy context; audit records; data risk assessment reports |

**The operating loop:** **Discover** (turn on the reports, see what is actually in use) → **Assess** (sensitive data in prompts and responses; the oversharing assessment) → **Protect** (deploy the recommended DLP, labeling, IRM, and SharePoint controls) → **Monitor** (Activity Explorer AI views and the audit log).

**⚠ DSPM for AI is discovery and posture, not enforcement.** It tells you what to enforce and can deploy the policies for you, but the enforcement itself still happens through DLP, sensitivity labels, IRM, and the SharePoint controls in `[AI-06]`. Treating it as a control rather than a lens is a common and expensive misreading.

**"Employees are pasting company data into a public AI chatbot"** is the scenario DSPM for AI exists for. It is also, increasingly, the first question a client asks — have an answer ready before they ask it.

---

### `[PURV-13]` Purview deployment order

Purview rewards being built in the right order and punishes being built in the wrong one. Every step below depends on the one above it.

**DO**

1. **Discover.** Run Data Explorer and the DSPM for AI oversharing assessment. Find out what sensitive content exists and where. Change nothing yet.
2. **Design the label taxonomy.** Four or five labels. Agree them with the business, not with IT alone.
3. **Publish labels** to a pilot group. Manual application only. Watch what people actually label.
4. **Add auto-labeling** for the highest-confidence classifications — start service-side, where it is reversible and invisible.
5. **Build DLP in simulation**, keyed off labels wherever possible rather than raw SITs. Follow `[PURV-04]`.
6. **Add retention.** Baseline location policies first, item-level labels only where a specific legal obligation exists.
7. **Then, and only then, add IRM and Communication Compliance** — these need HR and Legal sign-off (`[PURV-05]`) and they need the classification work underneath them to be meaningful.

**WHY this order:** DLP rules keyed off labels are stable; DLP rules keyed off raw pattern matching are noisy and get disabled. Retention applied before classification retains everything indiscriminately. IRM deployed before there is any notion of what "sensitive" means produces alerts nobody can adjudicate.

**🛑 PITFALL — the most common Purview failure is starting at step 5.** A client asks for DLP, DLP gets built against out-of-the-box SITs, the false positives are unmanageable, and the entire Purview investment is written off as "it doesn't work." It works. It was built upside down.

**✅ VERIFY at each step** before proceeding: labels appear for pilot users · auto-labeling matches what you expected in Data Explorer · DLP simulation matches are reviewed and the false-positive rate is acceptable · a test item ages out under retention as designed.

---

### `[PURV-14]` Licensing boundary — what Business Premium actually gets

`[M365-13]` covers the tiers. **This is the Purview-specific boundary**, which is where SMB projects go wrong, because Business Premium gets more than people assume in one direction and less in another.

**Included in Microsoft 365 Business Premium** (which carries Azure Information Protection P1):

- Creating and publishing sensitivity labels
- **Manual** labeling by users in Office apps
- **Encryption / RMS on labels, plus visual markings** — headers, footers, watermarks
- Scoping a label so only a specific group can apply it
- DLP for Exchange Online, SharePoint, and OneDrive

**Requires E5, or an E5 Compliance / AIP P2 add-on:**

| Capability | Notes |
|---|---|
| **Automatic and recommended labeling** | Both client-side (in Office apps) and service-side (SharePoint / OneDrive / Exchange). **Recommended labeling — the prompt suggesting a label — is also P2**, not just fully automatic application |
| **Sensitivity labels as a DLP condition** | Microsoft classifies this under **advanced DLP conditions**, which are E5-tier. Field-tested on Business Premium: **the policy saves without complaint and silently never matches** |
| **Endpoint DLP** | Requires devices onboarded to Defender for Endpoint |
| **Insider Risk Management** | `[PURV-05]` |
| **Communication Compliance** | `[PURV-06]` |
| **Custom trainable classifiers, Exact Data Match** | `[PURV-02]` |

**🛑 CORRECTION — Business Premium sensitivity labels *can* encrypt.** A widespread belief holds that encryption requires E3 or E5. It does not; Business Premium includes AIP P1, which covers RMS encryption and content marking. **Recommending an upgrade the client does not need is a credibility problem, not just a technical error** — and it is the same failure mode as `[APX-C]` #30.

**Design consequence for a Business Premium client:** build labels for **manual** application, and build DLP policies on **sensitive information types**, not on labels. That inverts the recommendation in `[PURV-13]` step 5 — which is correct for E5 and unavailable below it. **Check the SKU before designing the policy, not after building it.**

**⚠ Verify the current licensing guidance before quoting any of this to a client.** Microsoft revises the security and compliance licensing matrix regularly, and the label-as-DLP-condition boundary in particular is documented as a capability tier rather than a flat "requires E5" statement.

---

### `[PURV-15]` Creating a label is not publishing it

**⚠ TRAP — two separate operations, in two separate places.**

1. **Create:** Purview portal → Information Protection → **Sensitivity labels**
2. **Publish:** Information Protection → **Label policies** — a distinct step, with its own scope

**A label that exists but is not published appears nowhere.** This is the single most common *"I created a label and nobody can see it"* ticket, and it is the first thing to check before investigating clients, caching, or licensing.

**Propagation:** Microsoft documents up to **24 hours** for label policy changes to reach client apps. In practice usually faster. **Outlook on the web typically picks up changes well before Outlook desktop**, which caches more aggressively — **check OWA first** to separate "the policy has not propagated" from "the policy is wrong."

**✅ VERIFY:** the label appears in the Sensitivity dropdown in Word or Outlook **for a scoped test user** — not for you, unless you are in scope. If it does not after 24 hours, check that **the label policy's scope includes that user** before anything else.

---

### `[PURV-16]` DLP policy construction — the confidence dial

The deployment procedure is `[PURV-04]`. **This is the setting inside it that people do not touch and should.**

Minimum viable test policy:

| Field | Value |
|---|---|
| Location | Exchange email |
| Condition | Content contains sensitive info type → **Credit Card Number** |
| Action | Encrypt, or block, on send to external recipients |
| Mode | **Simulation first** |

**Confidence level is the noise dial.** The Credit Card Number classifier looks for a number passing the **Luhn checksum** *plus corroborative evidence nearby* — an expiration date, a security code, **or a keyword such as "credit card."** Any one of those is sufficient.

| Confidence | Behavior |
|---|---|
| **Low** | Catches more. Generates false positives. |
| **High** | Demands corroboration. **Misses isolated numbers with no surrounding context.** |

**When a client says "DLP isn't catching things," confidence threshold is the first setting to look at — and it is the same setting when they say "DLP blocks everything."** One dial, two opposite complaints. Check it before you rewrite the policy.

**⚠ Two documented constraints on sensitivity-label conditions worth knowing before you design around them:** the condition is **unavailable if Teams chat and channel messages is selected as a location**, and **policy tips for label conditions are not supported on endpoint devices**.

---

### `[PURV-17]` Simulation mode produces the full appearance of enforcement

**🛑 DANGER — this is the most dangerous behavior in the entire Purview surface.**

A DLP policy in simulation mode:

- Fires **policy tips** in the client
- Logs **DLP rule** events in **message trace** (`[EXO-03]`)
- Sends the **user notification** — *"You shared content that contains..."*
- **And lets the data leave the tenant unprotected.**

**Observed directly.** Same policy, same test message, thirty-three minutes apart:

| | Simulation | Enforcement |
|---|---|---|
| Message trace events | Receive → Submit → DLP rule ×3 → Send external | Receive → Submit → DLP rule ×3 → Send external |
| Policy tip in client | Yes | Yes |
| **What the recipient received** | **Plaintext card number** | Encrypted `.rpmsg` wrapper |

**The message trace is effectively identical in both modes. Neither the trace nor the policy tip can distinguish a simulated match from an enforced one.**

> **The only reliable verification that DLP is enforcing is confirming the action actually occurred at the far end** — the message was blocked, the message was encrypted, or the recipient received something different from what was sent. **Never accept a policy tip as evidence of enforcement.**

An admin who deployed this policy and walked away would believe the tenant was protected. **It is not.** This is `[DOCTRINE-11]` at its most expensive: the override did not just change behavior, it changed what every available test reported.

**Note the interaction with `[PURV-04]`.** That procedure correctly runs the first simulation pass with **policy tips off** — which is exactly what keeps this trap shut. The danger appears in step 6, when tips are turned on while still in simulation: from that moment the environment is visually indistinguishable from enforcement. **Put the enforcement switch-over on a calendar with a named owner, and verify it at the recipient.**

---

### `[PURV-18]` Encrypt is not Block

**Different actions, different failure modes, and clients confuse them constantly.**

With **Encrypt**, the message trace still ends in **Send external** — the message is wrapped and delivered, and the recipient authenticates to open it. **The data still leaves.** It is protected in transit and at rest; it is not withheld.

If the requirement is *"this must not leave,"* the action is **Block**, not Encrypt.

**The distinction matters in a compliance conversation**, because the two actions answer different regulatory questions. Encrypt answers "was it protected?" Block answers "did it go?" Agreeing to Encrypt when the client asked for Block is a real gap that will only surface during an incident or an audit. **Confirm which one they mean, in writing.**

---

### `[PURV-19]` Reporting lag, notification paths, and what is already running

**DLP alerts, reports, and Activity Explorer are batched, not real-time** — lag can run to hours. Policy tips and message trace events are near-instant because they are generated **inline by transport**. **An empty report five minutes after a test proves nothing.** Do not conclude a policy is broken on that basis, and do not let a client conclude it either.

Check the right surface for the mode you are in:

| Mode | Where results appear |
|---|---|
| **Simulation** | The **policy's own simulation results** view — open the policy itself |
| **Enforcement** | Purview → DLP → **Alerts**, and **Activity Explorer** (`[PURV-11]`) |

**Two separate notification paths, two audiences, two configuration points:**

| Notification | Audience | Wording tell |
|---|---|---|
| User notification / policy tip | **The sender** | *"**You** shared content that contains..."* |
| `Send alerts to Administrator` rule action | **The admin** | Runs on the delayed reporting pipeline |

**Receiving one does not mean the other fired.** Test both explicitly; each has its own toggle inside the rule.

**⚠ In an inherited tenant, a message trace can show more DLP rule evaluations than you have policies.** Several Microsoft-provisioned default DLP policies ship enabled in newer tenants, and they will appear in traces as rules you did not write.

***"What is already running here that I did not put there?"* is the first question to ask in any environment you inherit** — Purview → Data Loss Prevention → Policies, and read the whole list, including the ones that look like defaults. Record the answer in `[ASSESS-02]`. This is the Purview instance of the override inventory required by `[DOCTRINE-11]`.

---

## 27 — COPILOT AND AGENT ADMINISTRATION `[AI]`

Operational reference for deploying and governing Microsoft 365 Copilot and agents. Depends on §26 `[PURV]` for the data-governance layer and §11 `[M365]` for the identity and licensing layer.

**🔄 This is the fastest-moving product area Microsoft ships.** Portal paths, feature names, and license bundling here change on a scale of months, not years. Every click-path in this section is dated. Treat anything undated as a principle and anything dated as a fact with a shelf life — `[DOCTRINE]` rule: date what Microsoft can change.

**The one thing to take from this section if you read nothing else:** *Copilot does not create oversharing. It surfaces oversharing that already existed.* Every Copilot readiness engagement is, in practice, a permissions-remediation engagement wearing a different hat. Price it accordingly.

---

### `[AI-01]` How Copilot accesses data

> **Copilot can only access data the signed-in user can already access.**

Copilot introduces **no new data access mechanism**. It queries **Microsoft Graph** using the signed-in user's identity and OAuth token, so every existing permission check applies unchanged: SharePoint and OneDrive permissions, Exchange mailbox permissions, Teams membership, sensitivity label encryption, and Conditional Access.

| Boundary | What it means |
|---|---|
| **Tenant boundary** | Prompts, responses, and Graph-retrieved data stay inside the tenant and its compliance boundary |
| **Not used for training** | Your data is **not** used to train the foundation models |
| **Per-user permission enforcement** | If the user cannot open a file manually, Copilot cannot summarize, cite, or reason over it |
| **Auditable** | Copilot interactions are recorded in the unified audit log and are **discoverable via eDiscovery** — `[M365-18]`, `[PURV-08]` |
| **Encrypted in transit** | Data moving between services is encrypted |

**⚠ Both halves of the privacy statement matter.** "Copilot doesn't store or use data for training" is correct but incomplete. The full and more useful statement: prompts, responses, and Graph-accessed data are **not used to train the foundation models**, data stays within the **tenant boundary**, and interactions **are** logged for audit and eDiscovery. Clients ask about the first half; their legal team asks about the second.

**The canonical behavior, worth being able to state cold:** a Marketing employee asks Copilot to summarize last quarter's finance report, which lives in a SharePoint site restricted to Finance. **Copilot cannot find or use it and responds as though it does not exist.** Copilot never bypasses, elevates, or leaks across a permission boundary. Any claim otherwise is wrong.

#### Microsoft Graph, the semantic index, and Work IQ

**Microsoft Graph** is the unified, permission-aware data and API layer across Microsoft 365. For Copilot it is the **only** route to organizational data.

| Function | What it does | Why it matters |
|---|---|---|
| **Data aggregation** | Exposes Exchange, SharePoint, OneDrive, and Teams through one permission-aware layer | Copilot can answer questions spanning services |
| **Relationship mapping** | Models connections between people, content, and activity — who co-authored what, who reports to whom | Resolves "my team," "the project," "last week's meeting" |
| **Semantic index** | Converts content into **vector embeddings** representing meaning, not keywords | "Q2 financial progress" retrieves a document titled "Quarterly Revenue Analysis" |

**Work IQ** is the layer above Graph: it learns how work actually happens in the organization — workflows, collaboration patterns, active projects — and feeds that organizational awareness into the grounding step.

**The prompt lifecycle — four stages:**

1. **User prompt** — the user types a request in an app.
2. **Grounding** — the orchestrator enriches the prompt with **permission-filtered** content from Graph and the semantic index, plus Work IQ context.
3. **Response generation** — the grounded prompt goes to the model.
4. **Post-processing** — the orchestrator formats output and applies **compliance checks, sensitivity label inheritance, and content filtering** before display, with **citations** back to source.

**🛑 Data quality determines Copilot quality, and it is the honest answer to "why is Copilot giving bad answers."** Poorly organized SharePoint, stale content, missing metadata, and permissive sharing degrade output — irrelevant answers, or worse, confidently surfacing a superseded document as current. "Fix your data estate" is a legitimate technical answer, not a deflection. Ranking signals Graph applies include **recency of file activity, direct sharing with the user, breadth of sharing within the team, titles and metadata, and people relationships** — every one of which a neglected tenant gets wrong.

---

### `[AI-02]` The control stack that constrains Copilot

Learn this as layers. Each one is a different product with a different owner, and a control gap at any layer is a control gap overall.

| Layer | Control | Effect on Copilot |
|---|---|---|
| **Microsoft 365** | SharePoint, OneDrive, Exchange, Teams permissions | **The primary boundary** — Copilot sees only what the user sees |
| **Microsoft 365** | **Restricted Content Discovery** (SAM) | Site content excluded from Copilot and org-wide search **without changing permissions** |
| **Microsoft 365** | **Restricted Access Control** (SAM) | Only the designated control group reaches the site at all |
| **Microsoft 365** | **Restricted SharePoint Search** | Copilot and org-wide search limited to a curated allowed list |
| **Purview** | **Sensitivity labels with encryption** | If the label denies the user EXTRACT/copy rights, Copilot will not use the content **even though the user can open it** |
| **Purview** | **Label inheritance** | **Copilot output inherits the most restrictive label of the source content it used** |
| **Purview** | **DLP for Copilot / AI apps** | Content with specified labels excluded from Copilot processing entirely |
| **Purview** | **Retention and DLM** | Deleting stale content removes it from Copilot's reach |
| **Purview** | **Audit + eDiscovery** | Prompts and responses logged and legally discoverable |
| **Purview** | **Communication Compliance** | Prompts and responses monitored for policy violations |
| **Purview** | **DSPM for AI** | Discovers and reports AI activity and sensitive-data exposure |
| **Purview** | **Insider Risk Management** | Risky-AI-usage policies score suspicious Copilot behavior |
| **Entra** | **Conditional Access** | If CA blocks the user's access to SharePoint from that device, Copilot cannot use SharePoint content there either |
| **Defender** | **Defender for Cloud Apps** | Session controls and shadow-AI discovery and blocking |

**🛑 Copilot-generated content inherits the MOST RESTRICTIVE sensitivity label from the files it was grounded in.** Draft a document from one Public source and one Confidential source and the output is labeled **Confidential**. This is correct behavior and it surprises users constantly — put it in the user-facing rollout comms, or the helpdesk will field it as a bug for a month.

**⚠ "How do we stop Copilot seeing this site?" has three answers and they are not interchangeable:**

1. **Fix the permissions** — correct, permanent, slow.
2. **Restricted Content Discovery** — hides from Copilot and search, permissions untouched. **The tactical fix while you remediate.**
3. **Restricted Access Control** — removes access entirely for anyone outside a control group. **The hard fix for genuinely sensitive sites.**

Read the requirement for whether permissions must stay unchanged. That one clause decides it. Full comparison at `[AI-06]`.

---

### `[AI-03]` Oversharing — what it is and why AI changed the stakes

Oversharing is granting broader access to content than intended. The usual forms:

- Sharing with **"Anyone with the link"** (anonymous) or **"People in your organization"** when a specific-people link was appropriate
- Granting **Edit** where **View** was sufficient
- Adding external guests at **site** level when they needed one document
- **Broken permission inheritance** creating unique permissions nobody tracks — `[M365-11]`
- **"Everyone"** and **"Everyone except external users" (EEEU)** on site permissions
- **Orphaned sites** with no active owner and no access review

**WHY it suddenly matters.** Overshared content used to be theoretically accessible but practically undiscoverable — buried in a site nobody navigated to, with a filename nobody would guess. **Copilot removes the obscurity that was doing the security work.** The risk was always there. The mitigation was accident, and the accident has been removed.

**🛑 This is the finding to lead with in any Copilot readiness assessment**, and it is uncomfortable because it reframes an AI project as a permissions cleanup project. State it early. A client who discovers it in month three, after buying seats, will be considerably less receptive.

**The highest-risk site is where multiple risk signals overlap:** sensitive content **and** broad sharing **and** no active owner. A site with sensitive content but tight, reviewed permissions is not the priority. Prioritize by overlap, not by volume.

---

### `[AI-04]` Data Access Governance reports

**Where:** SharePoint admin center → **Reports → Data access governance**. *(Path verified August 2026.)*

DAG reports identify the highest-risk sites so you can prioritize remediation rather than boiling the ocean.

| Report | What it surfaces |
|---|---|
| **Sharing links** | Sites with the most **"Anyone" links**, **org-wide links**, and specific-people links |
| **Sensitivity labels applied to files** | Sites holding the most files carrying a given label |
| **Content shared with Everyone except external users (EEEU)** | Sites exposed to the entire organization |
| **Sharing links with RAC / RCD applied** | Which sites already carry those controls |
| **Permissioned users** | How many users can reach a site, **including via group membership** |
| **Oversharing baseline report** | Tenant-wide view of the sites most likely to expose content to Copilot |

**DO**

1. Run the report and let it generate — large tenants take time.
2. Download or review results.
3. **Prioritize sites combining sensitive content with broad sharing.**
4. Remediate: revoke anonymous links · apply sensitivity labels · apply **RCD** or **RAC** · run **site access reviews** · assign owners to orphaned sites.
5. Re-run and compare. **The report is a baseline, and a baseline is only useful if you take a second reading.**

**⚠ "Permissioned users" counts group membership.** A site showing 4,000 permissioned users usually has one nested group with the whole company in it, not 4,000 individual grants. Fix the group, not the site.

---

### `[AI-05]` SharePoint Advanced Management

**🔄 UPDATED — SAM is included with Microsoft 365 Copilot licenses.** A tenant with **at least one assigned Copilot license** gets the SAM capability set. SAM was previously a per-user standalone add-on, and a great deal of reference material still describes it that way — see `[APX-C]` #30. *(Verified August 2026. Prices are deliberately not recorded in this manual; they rot faster than anything else Microsoft publishes.)*

**A small number of features still require the standalone SharePoint Advanced Management Plan 1 add-on**, notably **restricted site creation by apps**. Check the current Microsoft list before quoting a client either way.

| SAM capability | What it does |
|---|---|
| **Restricted Access Control (RAC)** | Limit a site to members of a designated group |
| **Restricted Content Discovery (RCD)** | Hide a site's content from Copilot, agents, and org-wide search |
| **Data access governance reports** | The risk reports in `[AI-04]` |
| **Site lifecycle management** | Detect and act on **inactive sites** — notify owners, archive, delete |
| **Site access reviews** | Push a review to the **site owner** |
| **Block download policy** | Browser-only access, no local download, per site or per OneDrive |
| **Change history reports** | Audit what changed in sharing and permissions over time |
| **SharePoint Admin Agent** | An AI agent in the SharePoint admin center that answers governance questions and recommends actions |

**🛑 The "we need to buy something to control oversharing" answer is usually wrong.** With Copilot licensed, SAM is already there. Recommending a purchase the client already owns damages credibility more than any technical error.

**⚠ Site access reviews delegate to the site owner, not the tenant admin — and that is the entire point.** The tenant admin cannot possibly know whether a given user should have access to a given project site. The owner can. When the requirement is "IT doesn't know who should have access," the answer is a site access review, not an IT-led audit.

---

### `[AI-06]` RAC vs RCD vs Restricted SharePoint Search

The three most confusable controls in the Copilot toolkit. Getting them wrong either breaks the business or fails to protect anything.

| | **Restricted Access Control (RAC)** | **Restricted Content Discovery (RCD)** | **Restricted SharePoint Search (RSS)** |
|---|---|---|---|
| **What it is** | A **hard permission gate** | A **visibility filter** | A **tenant-wide temporary allowed list** |
| **Scope** | Per site | Per site | **Tenant-wide** |
| **Changes permissions?** | **Yes** — anyone outside the designated group loses access | **No** — permissions untouched | **No** |
| **Effect** | Only members of the control group can access the site at all, regardless of prior permissions or sharing links | Site content does not surface in **Copilot, agentic experiences, or org-wide search** | Copilot and org-wide search limited to a curated allowed list of **up to 100 sites** |
| **Can users still open files?** | Only if in the control group | **Yes** — anyone with permission opens content directly as before | Yes |
| **Known limitation** | Applies to sites and (separately) OneDrive | Users can still find content they **own or recently opened**; searches run **from within the site** are unaffected; **cannot be applied to OneDrive** | Content a user has already accessed still surfaces. Everything off the list is invisible to Copilot |
| **Use it for** | Genuinely sensitive sites: board materials, M&A, legal matters, executive team sites | High-risk sites you must remediate but cannot lock down yet — **buys time** | An enterprise-wide "pause" while you get permissions under control at the start of a rollout |

**🛑 RCD controls whether content can be FOUND. RAC controls whether content can be REACHED.** One is a visibility filter; the other is a permission gate. "Without changing permissions" → RCD. "No one outside this group should have access at all" → RAC.

#### Configuring RCD

**Portal:** SharePoint admin center → **Active sites** → select the site → **Settings** tab → toggle **Restrict content from Microsoft 365 Copilot** → Save. *(Path verified August 2026.)*

**PowerShell** — requires a current `Microsoft.Online.SharePoint.PowerShell` module and a SharePoint Administrator connection (`[M365-03]`):

```powershell
Connect-SPOService -Url https://contoso-admin.sharepoint.com

# Enable RCD on a site
Set-SPOSite -Identity https://contoso.sharepoint.com/sites/Finance -RestrictContentOrgWideSearch $true

# Check the current state — do this before AND after
Get-SPOSite -Identity https://contoso.sharepoint.com/sites/Finance | Select-Object Url, RestrictContentOrgWideSearch

# Remove RCD
Set-SPOSite -Identity https://contoso.sharepoint.com/sites/Finance -RestrictContentOrgWideSearch $false

# Tenant-wide insights: which sites currently have RCD enabled
Start-SPORestrictedContentDiscoverabilityReport            # queues the job
Get-SPORestrictedContentDiscoverabilityReport              # returns report GUIDs and status
Get-SPORestrictedContentDiscoverabilityReport -Action Download -ReportId <guid>
```

**🛑 DANGER — RCD is not instant, in either direction.** The change requires reindexing. Typical sites take **up to 24 hours**; very large sites (500,000+ items) can take **a week or more**. **Do not enable RCD the morning of a demo or an audit and assume it has taken effect — verify.** Removing RCD requires the same reindexing before content returns to Copilot, which surprises people who toggle it off expecting immediate restoration.

**⚠ RCD is deliberately *partial* suppression.** A user who owns a file or recently opened it can still find it, and Microsoft designed it that way so day-to-day work is not broken. **Treat RCD as a way to buy time while you remediate, not as a security boundary.** If the requirement is "this must not be reachable," that is RAC or a permission fix, not RCD.

**⚠ RCD also disables agent features on the site.** Flagging a site with RCD removes the **Agent** icon from the site's global header: users cannot use the ready-made agent, create new agents there, or add that site's content to any other agent. That is usually what you want, and it is occasionally an unwelcome surprise for a site that had a working agent.

Since Ignite 2025, both RCD and RAC can be **delegated to site administrators** rather than routing every site through the tenant admin. Enable delegation at SharePoint admin center → Policies → Access control.

#### Restricted SharePoint Search

Off by default; the allowed list starts empty. **Up to 100 sites.** Hub sites count toward the 100; **their associated sites are included but do not count toward the limit** — which is the trick for covering more ground than the number suggests.

**🛑 RSS is a stalling tactic, not a security control, and it has a real cost.** It does not change a single permission. It limits Copilot's grounding to 100 sites, which makes Copilot noticeably less useful across the whole tenant — you have paid for seats and then blindfolded the product. It also does not stop Copilot surfacing content the user has already accessed. **Turn it on to buy time, set a date to turn it off, and put that date in the project plan.** An RSS that is still on a year later is a permissions project that was never finished.

---

### `[AI-07]` Copilot readiness runbook

The transferable procedure. Run this before a single seat is assigned.

**DO**

1. **Discover the data estate.** Purview **Data Explorer** (`[PURV-11]`) — what sensitive content exists and where. SharePoint admin center **DAG reports** (`[AI-04]`) — which sites are overshared. **DSPM for AI** oversharing assessment (`[PURV-12]`) if licensed.
2. **Triage sites by risk overlap** — sensitive content **and** broad sharing **and** no owner. Produce a ranked list. Do not attempt the whole tenant.
3. **Apply immediate containment to the top tier.** RCD on high-risk sites that must stay accessible. RAC on genuinely sensitive sites. RSS only if the estate is so bad that a tenant-wide pause is warranted — and with an end date.
4. **Assign owners to orphaned sites** and launch **site access reviews** so the people who understand the content decide who keeps access.
5. **Remediate permissions for real.** Revoke anonymous links. Remove EEEU from site permissions. Repair broken inheritance. **This is the long pole and it is where the actual project time goes.**
6. **Deploy the sensitivity label taxonomy** (`[PURV-03]`) and auto-labeling for high-confidence classifications.
7. **Deploy DLP, including DLP for Copilot / AI apps**, in simulation first (`[PURV-04]`).
8. **Confirm auditing is on and retention is understood** — `[M365-18]`, `[PURV-07]`.
9. **Pilot Copilot with a small licensed group** via group-based licensing (`[AI-09]`), drawn from a department whose data estate you have actually remediated.
10. **Measure, train, expand** — `[AI-11]`.

**WHY in this order:** every step after 5 assumes the permissions underneath are approximately correct. Licensing users into an unremediated estate produces exactly one outcome — a senior person asks Copilot a question, gets an answer citing a document they should never have seen, and the project stops. **You get one chance at that moment.**

**🛑 PITFALL — the containment controls in step 3 are not a substitute for step 5.** RCD, RAC, and RSS buy time. If the project ends at step 3 because Copilot now "works," the client is paying for a permanent workaround and has learned nothing about their own estate.

**✅ VERIFY before expanding the pilot:** pick three documents the pilot users should **not** be able to see and confirm Copilot cannot surface them — by asking Copilot for them in natural language, not by checking a permission blade. Then pick three they **should** see and confirm it can. **Test both directions.** A control that blocks everything looks identical to a working control until someone needs to do their job.

---

### `[AI-08]` Licensing — monthly seat vs pay-as-you-go

**🛑 CORRECTION worth stating up front: the Microsoft 365 Copilot seat license is not metered and never has been.** A licensed user's Copilot Chat, in-app Copilot in Word/Excel/PowerPoint/Outlook/Teams, and the Microsoft-built agents are covered by the per-user subscription with no incremental consumption charge. **Pay-as-you-go meters agent consumption, not Copilot prompts.** Any source describing PAYG as "Copilot licensing by the prompt" is wrong — `[APX-C]` #31.

| | **Monthly per-user license (seat)** | **Pay-as-you-go (consumption)** |
|---|---|---|
| **What you buy** | A Copilot license assigned to a named user | Metered consumption in **Copilot Credits**, billed to a linked **Azure subscription** |
| **What it covers** | Copilot in Word/Excel/PowerPoint/Outlook/Teams · Copilot Chat grounded in work data · Microsoft-built agents · Copilot Studio for internal agents · **SharePoint Advanced Management** | Agent consumption — SharePoint agents, agents in Copilot Chat, Copilot Studio agents — for users **with or without** a seat |
| **Cost behavior** | **Fixed and predictable** — same cost at 500 prompts or zero | **Variable** — tracks actual usage, can spike |
| **Per-user license needed?** | Yes, per user | **No** for the agents covered by a billing policy |
| **Admin overhead** | Low — assign and audit | Higher — billing policies, budgets, alerts, ongoing monitoring |
| **Best for** | Knowledge workers with consistent daily use; stable populations; budget certainty | Pilots · seasonal or project work · occasional users · **unlicensed users querying SharePoint agents** · proving demand before buying seats |
| **Main risk** | **Over-licensing** — paying for inactive users | **Budget volatility** — consumption is user-initiated and effectively unbounded without guardrails |

**The SharePoint angle is the clearest real-world PAYG case.** A site's ready-made agent and custom site agents can be used by people who hold **no** Copilot seat. Create a billing policy, connect it to the **SharePoint agents** PAYG service, and an entire frontline population can query the HR site without buying anyone a seat.

**Mapping requirements to models:**

- *"Everyone in Legal uses Copilot daily in Word and Outlook"* → **seats**
- *"The whole company should be able to ask questions of the HR SharePoint site, but only 12 people need Copilot in the apps"* → **12 seats plus PAYG for SharePoint agents**
- *"We're piloting and don't know demand"* → **PAYG, convert to seats once usage stabilizes**
- *"Finance needs a hard cost ceiling"* → **seats**, or PAYG **with a budget and alerts**

**Base-plan eligibility:** Business Basic/Standard/Premium are eligible and **capped at 300 seats**. E3, E5, and F-plans are eligible with no cap; **E5 brings the Purview governance that makes Copilot safe at scale**. **Apps-only plans are not sufficient** — Copilot needs the Graph services (Exchange Online, SharePoint Online) that Apps-only plans do not include. **Consumer plans never connect to work-tenant data**, whatever they are currently branded.

**⚠ Copilot Chat vs Microsoft 365 Copilot — the distinction clients get wrong when budgeting.** **Copilot Chat** is included at no extra per-user cost for eligible subscribers: the chat itself is **web-grounded**, carries enterprise data protection, and **agents surfaced in it can be grounded in work data on a PAYG basis**. **Microsoft 365 Copilot** is the paid seat that unlocks **work-grounded Copilot inside the apps**. Saying flatly "Copilot Chat can't use organizational data" is half true and will mislead a licensing conversation.

---

### `[AI-09]` Assign Copilot licenses

**Individual assignment** — pilots, executives, precise control:

1. **Microsoft 365 admin center** (`admin.microsoft.com`) → **Users → Active users**.
2. Select the user → **Licenses and apps**.
3. Tick **Microsoft 365 Copilot** → **Save changes**.

**Group-based assignment** — the recommended approach at any scale:

1. Microsoft 365 admin center → **Groups → Active groups**.
2. Select the group → **Licenses** tab.
3. **Assign licenses** → **Microsoft 365 Copilot** → Save.

Every member inherits the license; new joiners are licensed the moment they are added, and removal reclaims it. This is the same pattern as `[HYB-LIC]` and it is the only one that survives staff turnover.

**Prerequisites and gotchas — all of these are `[M365-13]` restated because they all bite here:**

- The user must hold a **qualifying base plan**.
- The user must have a **usage location** set.
- **Nested groups are not supported** — only first-level members get licensed.
- Maximum **20 groups at a time** in a single assignment operation.
- **Group hygiene is the ongoing cost.** A departed employee left in the group keeps consuming a seat, and Copilot seats are not cheap. Reconcile the group against HR monthly, not annually.

**✅ VERIFY:** admin center → **Licenses → Errors & Issues** for failures, then confirm with the user that Copilot actually appears in their apps. **A license that assigned successfully and a feature that appears are two different facts** — if the license is present and Copilot is not, check the **service plans** inside the license (`[M365-13]`) before anything else.

---

### `[AI-10]` Pay-as-you-go billing policies — the two-step

**🛑 This is a two-step process and step 1 alone does nothing.** Creating the billing policy defines the billing arrangement and user scope. **Pay-as-you-go stays disabled until the policy is connected to a service.** "I created a billing policy but users still can't use SharePoint agents" is always this.

**Prerequisites:**

- Role: **Global Administrator**, **Billing Administrator**, or **AI Administrator**.
- An **Azure subscription**, with **Owner or Contributor** on a resource group.

**Where:** Microsoft 365 admin center → **Copilot → Billing & usage**. *(Path verified August 2026.)*

**Step 1 — Create the billing policy** (Billing policies tab)

1. **Copilot → Billing & usage → Billing policies** tab.
2. **+ Add a billing policy**.
3. Name it. Under **Subscription details** choose the **Azure subscription**, **resource group**, and **region**.
4. Accept **Terms of service** → **Next**.
5. Set **User scope**: **All users**, or a **specific security group** → **Next**.
6. **Set a budget for this policy** — budget limit, reset cadence (**first day of month / quarter / year**), alert recipients, and alert **thresholds** (80%, 100%).
7. Review → **Create**.

**Up to 10 billing policies per tenant** — typically one per department or cost center.

**Step 2 — Connect the policy to a service** (Pay-as-you-go services tab)

1. Same page → **Pay-as-you-go services** tab.
2. Select the service — for example **Microsoft 365 Copilot Chat** or **SharePoint agents**.
3. Assign the billing policy. Multiple policies can attach to one service.
4. **Save**. Status should show active.

**🛑 DANGER — set the budget in step 1, not "later."** PAYG consumption is user-initiated and effectively unbounded. A single enthusiastic department discovering agents in week one can produce a bill nobody approved. **A billing policy without a budget and alert thresholds is an open tab on a client's Azure subscription with your name on it.**

**Ongoing management:** disconnect a policy to disable PAYG for that service · connect additional policies as groups onboard · monitor spend on the **Billing & usage** dashboard · use **Azure Cost Management** budgets, alerts, and resource tags for real cost attribution back to a cost center.

**✅ VERIFY:** have an **unlicensed** test user query a SharePoint site agent in scope of the policy. Then check that consumption appears against the expected Azure resource group. **Both halves matter** — the feature working proves step 2; the charge landing in the right place proves step 1.

---

### `[AI-11]` Monitoring usage and adoption

Two tiers of tooling, for two different audiences and two different questions.

#### Tier 1 — Microsoft 365 admin center (operational)

**Reports → Usage → Microsoft 365 Copilot**, with an **Agents** tab for per-agent detail.

| Metric | Why it matters |
|---|---|
| **Enabled users** | How many hold a license |
| **Active users** | How many actually used Copilot in the window |
| **The ratio between them** | **The single most important adoption number.** A low active rate against a high enabled count is a rollout, training, discoverability, or fit problem — or wasted licenses |
| **Per-user last activity date** | Who to target, and whose license to reclaim |
| **App breakdown** | Outlook vs Teams vs Word vs Excel vs PowerPoint — where value is actually landing |
| **Trend over time** | One-off burst vs sustained use |

**Export to CSV** for per-user rows, then join to HR or org data.

**Who can read the reports:** Global Administrator · **Reports Reader** · **Usage Summary Reports Reader** · Global Reader · Exchange/SharePoint/Teams administrators · User Experience Success Manager. **Several of these see the data without user-level detail** — which is a feature, not a bug, and the right answer when a manager asks for per-person usage they have no business seeing.

**⚠ Two data caveats that will make you look wrong if you miss them:** reports carry a **24–48 hour ingestion delay**, and Microsoft **anonymizes or suppresses small groups** to protect privacy. Set a weekly or fortnightly review cadence rather than chasing daily noise, and never present yesterday's number as today's.

#### Tier 2 — Copilot Analytics (impact and business value)

Goes past counts to feature-level and impact signals — how many meeting recaps were generated, how often threads were summarized, where interaction concentrates, and correlation with business outcomes. Delivered through the **Viva Insights Copilot Dashboard** and prebuilt **Power BI templates**.

**🛑 Configure privacy first.** Minimum group size, exclusion lists, and the **Insights Administrator** and **Insights Analyst** roles must be set **before** publishing any dashboard. Publishing first and configuring privacy afterwards means the unprotected version has already been seen.

**⚠ Do not confuse the two tiers.** *Admin center* = operational counts, for license reclamation and rollout triage. *Copilot Analytics / Viva Insights* = impact and behavior analysis for leaders. "Who hasn't used it" is the admin center. "Show leadership the business impact" is Copilot Analytics.

**The adoption playbook:** measure the enabled-to-active ratio → identify low-adoption departments → run **targeted, role-specific** training (generic Copilot training does not move the number) → build a champions network of early adopters → re-measure → reclaim licenses from persistent non-users after a **defined and communicated** grace period.

---

### `[AI-12]` Prompt management and governance

The lifecycle is four verbs: **save, share, schedule, delete.**

| Action | What it is | Why it matters |
|---|---|---|
| **Save** | Capture a prompt that produced a good result so it can be reused | Consistency — the same task produces the same shape of output. Use a naming convention: `Finance – Month-End Summary` |
| **Share** | Make a saved prompt available to a team or group | Scales one person's good prompt to a department and standardizes output |
| **Schedule** | Run a prompt automatically on a recurring cadence | Recurring deliverables — a Monday KPI summary — without anyone remembering |
| **Delete** | Remove obsolete prompts | Stops users relying on outdated instructions. Review quarterly |

**🛑 Never embed sensitive data in a prompt.** A prompt should **point at** a secured location so Microsoft 365 permissions do the work — not carry the sensitive content in its text. **A saved and shared prompt containing real employee or customer data is a data leak that has been deliberately made reusable**, and it is discoverable in the audit log with your fingerprints on it.

**Governance:**

- **Control who may share broadly.** Unreviewed prompts circulating tenant-wide produce inconsistent and sometimes wrong output that users will treat as authoritative.
- **Standardize naming and require descriptions** so two similar prompts are distinguishable.
- **Audit prompt usage.** Heavily used prompts are business-critical and deserve review; never-used ones are deletion candidates.
- **🛑 Scheduled prompts deserve extra scrutiny** — they run unattended and can quietly generate and distribute content on a schedule nobody is watching. Every scheduled prompt needs a named owner.

**⚠ Prompts and responses are captured in the audit log, discoverable through eDiscovery, and monitorable by Communication Compliance and DSPM for AI.** If anyone asks whether prompt content is private, the answer is no — it is tenant data with full audit coverage. Say so plainly before someone types something they assumed was ephemeral.

---

### `[AI-13]` Copilot vs agents, and the agent taxonomy

| | **Microsoft 365 Copilot** | **Agents** |
|---|---|---|
| What it is | A general-purpose AI assistant embedded across the apps | A **task-specific** assistant with defined knowledge, instructions, and sometimes actions |
| Knowledge scope | Everything the **user** can access via Graph | A **curated, scoped** set — specified sites, files, websites, connected systems |
| Expertise | Broad and general | **Narrow and deep** |
| Who creates it | Microsoft | Microsoft, your organization, an ISV, or an everyday business user |
| Reusable and shareable? | Personal experience | **Yes** — built once, shared with a team or tenant |

**The discriminator:** *Copilot assists **you** across **everything you can see**. An agent is configured to be **expert in one thing** and can be **shared**.*

**When to build an agent instead of just using Copilot:** **repeatability and scoping** — the same specialized question is asked repeatedly, by multiple people, against a defined body of knowledge, and consistent answers matter. **A one-off ad-hoc request does not justify an agent.** Building one is over-engineering and creates a governance object somebody now has to own.

| Agent type | Who builds it | Notes |
|---|---|---|
| **Microsoft-managed agents** | Microsoft | Pre-installed for eligible users and **cannot be removed through availability settings**. Includes **Researcher, Analyst, Facilitator, Planner, and the Microsoft 365 Admin agent** |
| **Prebuilt agents** | Microsoft or approved vendors | Ready to use, added from the **Agent Store**. Vendor agents pass a Microsoft review |
| **Ready-made SharePoint site agents** | Auto-created when a site is created | Scoped to that site's content; becomes the site's **default agent**. A site owner can replace it with a custom agent |
| **Agents for everyday business users** | Non-technical users, in **Copilot Chat (Copilot Studio lite)** or the **SharePoint agent tool** | Declarative: instructions plus knowledge sources. **No custom code, no custom connectors** |
| **Advanced / custom agents** | Developers, in full Copilot Studio or VS Code | Custom connectors, generative actions, external channels, autonomous behavior |
| **External / third-party agents** | ISVs and partners | Carry a certification status: **Publisher attested** or **Microsoft 365 Certified** |

**The two Microsoft agents worth being able to distinguish:**

| Agent | What it is | Points to it |
|---|---|---|
| **Researcher** | Runs **multi-step research** across work data **and the web**, producing structured, **cited** reports | Competitive analysis · client or account briefs from scattered sources · background research · sourced executive summaries |
| **Analyst** | A virtual data scientist using advanced reasoning and **Python** to turn raw data into insight and visualizations | Messy datasets · trends, anomalies, correlations · forecasting · turning a spreadsheet into charts and a written summary |

**Dataset, spreadsheet, numbers, trends, forecasting → Analyst. Gathering, synthesizing, sourcing across many sources → Researcher.**

**Custom agent patterns that actually work:** an HR onboarding agent over the policy library · an IT helpdesk agent over the knowledge base · a sales agent over the product catalog and pricing · a compliance agent over the approved policy library. The shape is always the same — **a recurring question, a defined body of knowledge, multiple people who need the same consistent answer.**

---

### `[AI-14]` Configuring user access to agents

**Three different questions, answered in three different places.** Conflating them is the source of most agent access confusion.

| Question | Answered by | Where |
|---|---|---|
| Can this person **use** an agent someone shared with them? | Access to the published endpoint (Teams, SharePoint, Copilot Chat) + the agent's availability setting | **Microsoft 365 admin center** (Copilot Control System) |
| Can this person **build and publish** agents? | A Copilot Studio license **plus** a Power Platform **environment role** | Admin center (license) + **Power Platform admin center** (role) |
| Is this agent **allowed to exist** in our tenant at all? | Agent availability and the approval process | **Microsoft 365 admin center → Copilot → Agents** |

**Two-step configuration for agent makers:**

**Step 1 — License** (Microsoft 365 admin center): Users → Active users → select user → **Licenses and apps** → tick the Copilot product license that includes agent access → Save.

**Step 2 — Environment role** (Power Platform admin center, `admin.powerplatform.microsoft.com`): **Environments** → select the environment where the agent lives → **Settings → Users + permissions → Users** → locate the user → assign the **environment role**.

**Power Platform environments** are containers for apps, flows, data, and agents, and they provide isolation — an HR environment, a Finance environment, a Dev environment. **Users in one environment cannot see or edit agents in another** unless explicitly granted.

| Environment role | Permits |
|---|---|
| **Environment Admin** | Full control of the environment, its resources, and its users |
| **Environment Maker** | **Create and edit** apps and agents in that environment |
| **Basic User** | **Use** agents shared with them; cannot create or modify |

**Assign environment roles to a security group**, not to individuals. Same reasoning as `[AD-AGDLP]` and `[HYB-LIC]`: individual assignment does not scale and drifts silently.

**🛑 License and environment role are both required to build, and neither implies the other.** A user with a Copilot Studio license but no Environment Maker role **cannot create agents in that environment**. A user with Environment Maker but no license cannot open Copilot Studio. **License = the right to use the product tenant-wide. Environment role = what you may do inside a specific environment.**

**⚠ The most commonly missed fact: people who merely USE a published agent need neither a Copilot Studio license nor an environment role.** They need access to the published endpoint and the agent must be available to them. This is what makes agents scalable to a broad population — and it is why the PAYG model in `[AI-08]` works.

**Agent availability** — for each agent in the inventory, exactly three settings:

- **No users** in the organization can install and use this app
- **All users** in the organization can install and use this app
- **Only selected users** in the organization can install and use this app

**Microsoft-managed agents are pre-installed for eligible users and cannot be controlled through availability settings.** If the requirement is "turn off Researcher for this group," availability settings are not the mechanism.

---

### `[AI-15]` Creating an agent

Two tools, both aimed at users with no coding background. They capture broadly the same information.

| | **Copilot Studio (lite)** | **The agent tool in SharePoint** |
|---|---|---|
| Produces | An agent for **Microsoft 365 Copilot Chat** | An agent scoped to a **SharePoint site, pages, or selected files** |
| Started from | Copilot Chat → Create an agent, or Copilot Studio | A SharePoint site → the **Agent** icon in the global header, or from a file/library |
| Knowledge sources | **SharePoint content**, **web content**, **Copilot connectors** to external systems | The site, specified libraries, folders, or a set number of specific files |
| Who can create | Users permitted by tenant settings | Anyone with **Edit permissions or higher** on the site |

**The creation flow — four ideas, both tools:**

1. **Describe / Name.** Name, description, icon. In Copilot Studio the **Describe** tab lets you write in natural language what the agent should do and configures itself from that.
2. **Instructions.** How it should behave — tone, scope, what it should refuse, how to format answers. **This is the highest-leverage field. A vague agent gives vague answers**, and most disappointing agents are an instructions problem, not a model problem.
3. **Knowledge sources.** The content it may use.
4. **Starter prompts.** Suggested questions so users know what it is for. Skipping these is the most common cause of an agent nobody uses.

Then **Test** in the built-in pane, **Edit** based on results, and **Publish / Share**.

**🛑 An agent never expands access.** It respects Microsoft 365 permissions: a user asking a site agent a question gets answers only from content **they** can already access. **Two people asking the same agent the same question can get different answers, because their permissions differ.** This is correct behavior and it confuses users badly — cover it in rollout comms.

**⚠ A site's ready-made agent is scoped to that site only.** When the answer needs content from **multiple** sites, the fix is to **create a custom agent with all the required sources** — not to keep re-prompting the default agent and concluding the technology does not work.

---

### `[AI-16]` The agent approval process

**Where:** Microsoft 365 admin center → **Copilot → Agents**, within the **Copilot Control System** — the surface formerly called **Integrated apps**. *(Verified August 2026.)*

**Roles that can manage agents here:**

- **AI Administrator** — the purpose-built role. **This is the correct least-privilege answer.**
- **Global Reader** — view only.
- **Global Administrator** — capable, but Microsoft explicitly advises limiting this role to emergencies. Using Global Admin for routine agent approval violates `[APX-B]`.

**Three stages:**

| Stage | What happens |
|---|---|
| **Submission** | A user or developer requests approval, describing purpose, intended audience, and required permissions and data connections |
| **Review** | Admins — plus business owners, security, and compliance where warranted — assess on technical and organizational grounds |
| **Decision** | Approve for deployment · reject · return for revision |

**To review pending requests:** Microsoft 365 admin center → **Copilot → Agents** → **Requested agents** tab.

**Stakeholders and why each is there:** the **administrator** verifies permissions, data connections, and compliance alignment · the **business owner** supplies the context for *why* the access is needed · **security and compliance** challenge requests for broad access to sensitive data without justification. **An approval process with only IT in it approves everything, because IT has no basis to say no.**

**Agent inventory** shows each agent's description, deployment status, **version history**, availability, publisher, agent type, capabilities, knowledge sources, actions, and certification status (**Publisher attested** or **Microsoft 365 Certified**).

**🛑 Updates must be re-reviewed.** An agent that previously read only customer contact data and now requests full CRM access is **materially a different agent**. Approving the update is a fresh decision, and you should maintain a **rollback path** to the previous version. Version history exists for exactly this.

---

### `[AI-17]` Monitoring agents and the lifecycle

**Microsoft 365 admin center:** Reports → Usage → Microsoft 365 Copilot → **Agents** tab → select an agent. Filter by date, department, or group; export to CSV.

| What to watch | Why |
|---|---|
| **Adoption** — active users per agent | Low adoption after deployment means poor communication, poor usability, or a design that does not fit the workflow |
| **Usage volume and trend** | Steady growth, seasonal peaks, or an unexplained drop |
| **Error frequency** | Failed requests point to misconfiguration or a broken backend connection |
| **Response performance** | An agent taking 30 seconds disrupts the workflow it was meant to improve |
| **Permission usage** | An agent granted read/write that only ever reads should be **scaled back to read-only** — least privilege applied to agents |
| **Cross-service dependencies** | Which backends it relies on, so you know what breaks it |

**Power Platform admin center** covers environment-level health, capacity and **Copilot Credit** consumption, connector usage, and **DLP policies applied to connectors**.

**Lifecycle: Creation → Approval → Deployment → Maintenance → Retirement**

| Stage | Admin responsibility |
|---|---|
| **Creation** | Set guardrails — which environments, which data sources, who may build |
| **Approval** | Review purpose, audience, permissions, data connections |
| **Deployment** | **Communicate.** Users who do not know an agent exists will not use it |
| **Maintenance** | Re-review updates; monitor errors and permission drift |
| **Retirement** | **Block** or **Remove** |

**Two forms of retirement — know the difference:**

| | **Block** | **Remove** |
|---|---|---|
| Effect | Prevents all users (or specified users/groups) from accessing the agent | Deletes the agent from the **agent inventory** |
| Reversible? | **Yes** — unblock it | First-party and external agents can be re-acquired from the store |
| Use when | Temporary suspension, a security concern under investigation, a phased sunset | Permanently obsolete, cluttering the inventory |

**To block or remove:** Microsoft 365 admin center → **Copilot → Agents** → select the agent → detail pane → **Block** or **Remove** → choose everyone or specific users/groups → confirm and **Save**.

**⚠ Communicate retirement at least 30 days in advance and provide training on the replacement.** An agent that quietly disappears takes a business process with it, and the ticket arrives as "SharePoint is broken."

---

### `[AI-18]` Agent 365 and Entra Agent ID

**🔄 Microsoft Agent 365 reached general availability on 1 May 2026.** Approximately **USD 15 per user per month**, and included in **Microsoft 365 E7**. At GA it became the unified registry and control plane for agents; the Agent registry and Agent collections blades in the Entra admin center were retired the same day, with agent inventory now surfaced in the Microsoft 365 admin center. **Any material describing Agent 365 as a preview feature is out of date** — `[APX-C]` #27. *(Verified August 2026.)*

As an organization moves from a handful of agents to hundreds, the governance problem becomes an **identity** problem.

| Capability | What it does |
|---|---|
| **Agent identity** | Every agent gets a first-class **Microsoft Entra Agent ID** and can be governed like a user — owned, sponsored, permissioned, reviewed, retired |
| **Unified inventory** | A single catalog of every agent in the tenant, including agents built outside Copilot Studio. **Ends shadow agents** |
| **Access control** | Least-privilege permissions per agent; **Conditional Access for agents** and **ID Protection for agents** |
| **Visibility and audit** | What each agent can do, what data it reaches, its run history, and a full audit trail of tools called and data touched |
| **Integration** | Works with **Entra, Defender, Purview, and Intune**; surfaced in the Microsoft 365 admin center |

Licensing note: **each license covers an individual who manages or sponsors agents, or uses agents to work on their behalf** — agents acting on behalf of a licensed user are covered by that user's license.

**⚠ Agent 365 and the Copilot Control System overlap and are converging, but the framing differs.** **Agent 365** answers *how do we govern agents at scale, as identities, across the whole tenant* — including agents from other vendors and agents running locally. **Copilot Control System** answers *how do we approve, block, and monitor Copilot agents day to day*. If the question is identity and lifecycle at scale, it is Agent 365. If it is routine Copilot agent administration, it is CCS.

**WHY this is the direction of travel:** the industry problem in 2026 is not building agents, it is governing them. An agent that authenticates with a human's credentials is an audit failure waiting to happen — you cannot answer "who did this" if the answer is "an agent, using Karen's token." **Give agents their own identities and the existing governance machinery — access reviews, Conditional Access, least privilege, audit — applies unchanged.** That is the whole argument, and it is the same argument as service accounts, thirty years later.

---

### `[AI-19]` Which Copilot features can be enabled or disabled

Copilot is not a single switch. Control operates at several levels.

| Control | Level | Effect |
|---|---|---|
| **License assignment** | Per user or group | The primary on/off switch. No license, no Copilot in the apps |
| **Service plans within the license** | Per user | Individual Copilot service plans can be disabled |
| **Copilot Control System settings** | Tenant / group | Central Copilot and agent configuration |
| **Web search / web grounding** | Tenant, and user-toggleable | Whether Copilot may ground responses in **web content**. Frequently disabled in regulated environments |
| **Agent availability (Agent Store)** | Tenant, per agent | Block · allow for everyone · allow only specified users and groups |
| **Who may create agents** | Tenant / group | Whether everyday users may build agents in Copilot Chat and SharePoint |
| **Copilot / Graph connectors** | Tenant | Which external data sources Copilot may reach |
| **Meeting transcription policy (Teams)** | Per user or group | **Copilot meeting recap depends on transcription** — `[M365-12]` |
| **Restricted Content Discovery** | Per SharePoint site | Removes a site's content from Copilot entirely — `[AI-06]` |
| **Restricted SharePoint Search** | Tenant | Limits Copilot's SharePoint grounding to an allowed list |
| **DLP policies for Copilot / AI apps** | Tenant, by label | Prevents labeled content from being processed by Copilot |
| **Pay-as-you-go billing policy** | Group scope | Whether users may consume PAYG agent services at all |

**Staged rollout in practice:** tenant-wide disable while governance is reviewed → **group-based licensing** for a pilot → staged expansion by department → full rollout, with site-level and label-level controls remaining in place permanently.

**🛑 PITFALL — there is no per-verb toggle.** There is **no** clean switch for "Copilot summarization in Outlook but not drafting." Feature-level restriction is achieved through **licensing scope, group targeting, dependent service settings (like transcription), data-side controls (RCD, labels, DLP), and policy plus training** — not a granular per-feature switch. When a client asks for one, tell them plainly it does not exist rather than going looking for it.

---

### `[AI-20]` Copilot and agent troubleshooting — symptom → cause → fix

| Symptom | Actual cause | Fix |
|---|---|---|
| User has a Copilot license but Copilot does not appear in the apps | A **service plan** inside the license is disabled, or the Office client is too old / not on a current channel | Check Licenses and apps → service plans `[M365-13]`. Confirm the app build |
| License assignment fails | **Usage location unset**, or no seats available | Set usage location; check `Licenses → Errors & Issues` `[M365-13]` |
| Group-based Copilot licensing licenses nobody | **Nested groups** — only first-level members are licensed | License the leaf groups, not the umbrella group `[M365-13]` |
| Copilot cannot produce a meeting recap | **Teams meeting transcription is disabled by policy** | Teams admin center → meeting policy → enable transcription `[M365-12]` |
| Copilot surfaces a document the user should not have seen | **Pre-existing oversharing.** Copilot did not bypass anything | Permissions remediation `[AI-07]`; RCD as immediate containment `[AI-06]` |
| Copilot cannot use a file the user *can* open | **Sensitivity label encryption denies EXTRACT/copy rights**, or DLP for Copilot excludes that label | Check the label's usage rights and any AI-scoped DLP policy `[AI-02]` |
| RCD enabled but content still appears in Copilot | **Reindexing has not completed** (up to 24h, longer on very large sites), **or** the user owns or recently opened the file | Wait and re-verify; confirm with `Get-SPOSite ... RestrictContentOrgWideSearch` `[AI-06]` |
| Copilot answers are vague, stale, or cite superseded documents | **Data estate quality** — stale content, no metadata, duplicate documents | Retention cleanup `[PURV-07]`; content lifecycle; this is not a Copilot fault `[AI-01]` |
| Created a PAYG billing policy but users still cannot use agents | **Step 2 missing** — the policy was never connected to a service | Copilot → Billing & usage → **Pay-as-you-go services** tab `[AI-10]` |
| User cannot create an agent in Copilot Studio | Has the license but **no Environment Maker role** — or the reverse | Both are required `[AI-14]` |
| Two users get different answers from the same agent | **Correct behavior** — agents respect per-user permissions | Explain it; do not "fix" it `[AI-15]` |
| A site's Agent icon has disappeared | **RCD is enabled on that site** — it disables agent features there | Expected. Remove RCD if the agent is required `[AI-06]` |
| Agent worked, then stopped after an update | Permission or knowledge-source change in a new version | Check version history in the agent inventory; roll back `[AI-16]` |
| Cannot turn off Researcher or Analyst for a group | **Microsoft-managed agents cannot be controlled via availability settings** | Availability settings are not the mechanism `[AI-14]` |
| Usage report shows nothing for yesterday | **24–48 hour ingestion delay**, or small-group suppression | Not a fault. Adjust the review cadence `[AI-11]` |

---

### `[AI-21]` Responsible AI — the principles and what they mean operationally

Microsoft's Responsible AI framework rests on six principles: **Fairness · Reliability and safety · Privacy and security · Inclusiveness · Transparency · Accountability.**

How they show up in the product, and what you tell users:

- **Data minimization** — Copilot retrieves only what is needed for the request rather than crawling everything.
- **Transparency through citations** — every grounded response links back to the source files and messages. **Teach users that the citations are the trust mechanism.** An answer with no citation is not grounded in their data.
- **Content filtering** — harmful or policy-violating content is filtered from responses.
- **Grounded, not invented** — if no accessible source contains the answer, Copilot should say so. **It is not immune to error**, which is why the next point exists.
- **Human in the loop** — output is a **draft requiring review**. **Accountability stays with the person**, not the tool, and that is not a disclaimer — it is the operating model.
- **Full auditability** — every interaction is logged (`[M365-18]`).

**🛑 The single most important thing to put in user training: review and verify before using Copilot output.** Not because Copilot is unreliable, but because accountability does not transfer to a tool. A user who sends a Copilot-drafted client email without reading it has made a decision about their own professional standards, and the organization will be held to it, not to Microsoft's.

**⚠ Do not oversell.** Clients who are told Copilot is accurate will treat its output as verified. Clients who are told it is a fast first draft that requires a human check will get value out of it and will not be blindsided. **The second framing is both more honest and the one that produces successful deployments.**

---

## 28 — PUBLIC DNS FOR MAIL `[DNS-MAIL]`

Everything in §04 `[NET]` and §22 `[NETF-10]` is about DNS as a *resolution* service. This section is about DNS as a *published contract* — the records the rest of the internet reads to decide whether to accept your client's mail. Different failure modes, different tools, different blast radius. A mistake here is visible to everyone who tries to email the client.

---

### `[DNS-MAIL-PRE]` Pre-flight — before you touch a public zone

Public DNS changes are production changes with an external blast radius and a propagation delay you cannot cancel. Treat them like a change window, not like editing a config file.

- [ ] **Export the current zone** — screenshot or copy every record before the first edit. Most registrar editors have no undo and no history.
- [ ] **Record the current TTLs.** A record with an 86400-second TTL takes up to 24 hours to fully replace. **Lower TTLs to 300 the day before a planned cutover**, then raise them again after it is verified.
- [ ] **Confirm who is authoritative** — `[DNS-MAIL-01]` step 1. Editing records in a zone that nothing is delegated to is the single most common wasted hour in this work.
- [ ] **Check for DNSSEC** — `[DNS-MAIL-04]`. This determines whether you *can* change DNS hosting at all, and it must be answered before you plan the change, not during it.
- [ ] **Check for a wildcard record** — `[DNS-MAIL-02]`. If one exists, every verification you run afterward is unreliable until it is gone.
- [ ] **Inventory every system that sends as the domain** — `[DNS-MAIL-06]`. This is the step that gets skipped and the one that breaks the copier.
- [ ] **Agree a window with the client and tell them what to expect.** Mail is the most visible service a business has. "Email might be delayed for an hour this evening" costs one sentence; an unannounced outage costs the relationship.

**WHY the export matters more than it sounds:** you are frequently working in a registrar portal you have never seen before, owned by a client who has lost the login twice, and the record you are about to overwrite may be the only copy of a value nobody documented — a third-party verification token, a marketing platform's DKIM key, a legacy SPF include. Losing it is silent. **Nothing errors; a service simply stops working next week.**

---

### `[DNS-MAIL-00]` The record set, and what each one actually does

A domain that is *verified* in Microsoft 365 is not *configured* for mail. Verification proves ownership and nothing else. **This is the single most common half-finished state in an SMB tenant** — and the one an inherited environment will hand you.

| Record | Host | Value | What it does |
|---|---|---|---|
| **TXT** | `@` | `MS=msXXXXXXXX` | Proves domain ownership to Microsoft. **Does nothing for mail.** |
| **MX** | `@` | `<domain-dashed>.mail.protection.outlook.com`, priority `0` | Tells sending servers which host accepts mail for the domain. **Lower priority number wins.** |
| **CNAME** | `autodiscover` | `autodiscover.outlook.com` | How Outlook desktop and mobile find mailbox settings from an email address alone. |
| **TXT (SPF)** | `@` | `v=spf1 include:spf.protection.outlook.com -all` | Lists servers authorized to send as the domain. Checked against the **envelope sender** (`MAIL FROM` / Return-Path), **not** the visible `From:`. |
| **CNAME ×2** | `selector1._domainkey`, `selector2._domainkey` | **Tenant-specific — read from the portal.** See `[DNS-MAIL-05]` | Publishes DKIM public keys so receivers can verify the signature. Two selectors exist so keys can rotate with no downtime. |
| **TXT (DMARC)** | `_dmarc` | `v=DMARC1; p=none; rua=mailto:...` | Policy layer. Sets what receivers do on failure and enforces **alignment**. |
| **CNAME** | `enterpriseregistration` | `enterpriseregistration.windows.net` | Device registration / workplace join discovery. |
| **CNAME** | `enterpriseenrollment` | `enterpriseenrollment-s.manage.microsoft.com` | Intune enrollment discovery when a user types a work email into **Settings → Accounts → Access work or school**. |

**WHY the three authentication records are not interchangeable — the explanation to give a client:**

- **SPF** authenticates the **envelope sender** (`MAIL FROM`).
- **DKIM** authenticates the **message** cryptographically, via a signature over selected headers and the body.
- **Neither says anything about the `From:` address the user actually sees** — which is exactly what a phisher forges.
- **DMARC** binds authentication back to the visible `From:` domain (**alignment**) and sets policy on failure.

If you can explain that distinction out loud without notes, you understand email authentication better than most people who configure it. It is also the answer to *"we have SPF, why are we still being spoofed?"*

**⚠ TRAP — `SIP:` and `smtp:<tenant>.onmicrosoft.com` are generated cloud-side.** When you later take over `proxyAddresses` from on-premises AD, confirm both survived. See `[EXO-PROXY]`.

---

### `[DNS-MAIL-01]` DNS record inventory script

Run this before touching anything. Read-only, no privilege required, safe on any network.

```powershell
# Step 1 — who is authoritative? Confirms the registrar delegation.
Resolve-DnsName -Name contoso.com -Type NS -Server 1.1.1.1

# Step 2 — the mail record set
Resolve-DnsName -Name contoso.com               -Type MX    -Server 1.1.1.1
Resolve-DnsName -Name autodiscover.contoso.com  -Type CNAME -Server 1.1.1.1
Resolve-DnsName -Name contoso.com               -Type TXT   -Server 1.1.1.1 | Select-Object -ExpandProperty Strings
Resolve-DnsName -Name _dmarc.contoso.com        -Type TXT   -Server 1.1.1.1 | Select-Object -ExpandProperty Strings
Resolve-DnsName -Name selector1._domainkey.contoso.com -Type CNAME -Server 1.1.1.1
Resolve-DnsName -Name selector2._domainkey.contoso.com -Type CNAME -Server 1.1.1.1

# Step 3 — compare against the local resolution path a real workstation uses
Resolve-DnsName -Name contoso.com -Type MX      # no -Server: uses configured DNS
```

| Component | Purpose |
|---|---|
| `Resolve-DnsName` | PowerShell DNS client cmdlet. Same job as `nslookup` / `dig`, but returns **objects** rather than text you have to parse by eye. |
| `-Type` | Record type to request. |
| `-Server 1.1.1.1` | Sends the query to a public resolver instead of the locally configured one. **Takes your own DC, forwarders, Pi-hole, and caches out of the equation.** |
| `\| Select-Object -ExpandProperty Strings` | Pulls the text payload out of a TXT record object. Without it, long SPF records display truncated and get misread. |

**WHY step 3 exists.** Steps 1 and 2 tell you what the internet sees. Step 3 tells you what the client's own machines see. When those two disagree, you are looking at split-brain DNS, a conditional forwarder, or an internal zone shadowing the public one — a completely different problem from a missing public record, and one you will chase in the wrong direction if you only ever query `1.1.1.1`.

**✅ VERIFY:** the NS query must return real nameserver hostnames. If it errors or returns something implausible, **outbound DNS is being intercepted** — some firewalls and guest networks redirect port 53 — and every result below it is suspect. Move to a different network before continuing.

---

### `[DNS-MAIL-02]` Reading the results — NXDOMAIN vs NODATA vs wildcard

| Result | Meaning |
|---|---|
| **NXDOMAIN** (`DNS name does not exist`) | The name does not exist at all. |
| **NODATA** — answer contains the zone **SOA in the Authority section**, nothing in the Answer section | **The name exists but has no record of the requested type.** This is a different fact and often the more useful one. |
| A plausible answer that is actually a **wildcard match** | The record you asked for does not exist. Something else answered for it. |

**🛑 DANGER — the wildcard trap.** A `*` CNAME (or `*` A record) in the zone answers for every subdomain that has no explicit record. Consequences:

- Every "does this record exist?" test returns a **false positive**.
- A typo (`autodiscovr`) resolves successfully to a parking page instead of failing loudly.
- `enterpriseregistration` and `enterpriseenrollment` silently resolve to the wrong place, and device enrollment fails with an error that points nowhere near DNS.
- A TXT query that hits a wildcard **CNAME** throws `Property "Strings" cannot be found` — because `Resolve-DnsName` returned a `DnsRecord_PTR` object (the type used for CNAME/PTR/NS), which has `NameHost`, not `Strings`. **That error is a finding, not a syntax mistake.**

Wildcards never match the zone apex, which is why an apex MX query still returns honest NODATA while every subdomain lies. **That asymmetry is the tell:** apex answers look sane, subdomain answers look too good.

**✅ VERIFY wildcard removal:**
```powershell
Resolve-DnsName -Name doesnotexist.contoso.com -Server 1.1.1.1
```
You want a hard NXDOMAIN. Anything else means the wildcard is still live, or still cached.

**⚠ Wildcards are not always a mistake.** Some hosting platforms require one. Do not delete it reflexively — confirm what depends on it first, then decide. What you must not do is *trust a DNS verification while one is in place.* This is `[DOCTRINE-11]` in its purest form.

---

### `[DNS-MAIL-03]` Registrar delegation vs NS records in the zone

**These look identical in a UI and are completely different mechanisms.** This distinction costs people entire afternoons.

| | Where it lives | How you change it |
|---|---|---|
| **Delegation** | The **parent zone** at the registry (`.com`, `.org`, `.beer`) | The registrar's **nameserver** field, pushed to the registry via EPP |
| **NS records in the zone** | Your own zone, served by your authoritative servers | The DNS record editor |

NS records in the zone are supposed to *mirror* the delegation. Adding NS records pointing at a new provider while the registry still points at the old one **does not redirect anything** — it creates a **lame delegation**, and some resolvers will cache the child NS records in preference to the parent's and begin querying servers that hold no zone data.

**Symptom:** you "changed the nameservers," waited an hour, and nothing happened. The new provider's validation page reports it still sees the old nameservers — *and names them*, which is the confirmation most people scroll past.

**Fix:** change the nameserver field on the **domain's registrar page**, not in the DNS record editor. Delete the misplaced NS records from the zone.

**⚠ Registrar and DNS host are not necessarily the same company.** A domain registered at one provider may have its zone hosted at another. "Where do I change DNS?" has two possible answers and you need to establish which applies before you start clicking. Ask, or read the NS query output — it names the answer.

---

### `[DNS-MAIL-04]` DNSSEC — the DS/signing mismatch

DNSSEC is a chain of trust. The **DS (Delegation Signer)** record in the parent zone is a hash of your zone's signing key and constitutes a public promise: *this zone is signed; reject unsigned answers as forged.*

**🛑 DANGER — order of operations.** If the DS record is present at the registry but the zone has stopped signing, every validating resolver returns **SERVFAIL** and the domain goes dark for a large share of the internet. Correct removal order:

1. **Remove the DS record from the registry.**
2. **Wait out its TTL** — genuinely wait; do not assume.
3. **Stop signing the zone.**

Reversing steps 1 and 3 is a self-inflicted outage with a multi-hour tail you cannot shorten.

**🔄 Microsoft 365 DNS hosting does not support DNSSEC** (verified Aug 2026). If you delegate a zone to Microsoft's nameservers (`ns1-4.bdm.microsoftonline.com`), you must disable DNSSEC and remove the DS records first. The domain wizard raises a banner saying so, and Microsoft's own note states changes can take **up to 48 hours** to reflect. **Check for DNSSEC before choosing a DNS hosting model**, not after starting the migration.

**⚠ Do not generalize this to all of Microsoft.** **Azure Public DNS does support DNSSEC** — it signs with ECDSAP256SHA256 and rolls the ZSK automatically. *Microsoft 365 DNS hosting* and *Azure DNS* are different services with different capabilities, and conflating them produces a wrong recommendation in both directions. If a client needs both Microsoft-hosted DNS and DNSSEC, Azure Public DNS is the answer; M365 DNS hosting is not.

**Diagnostic signature:** SERVFAIL from one public resolver and a clean answer from another is **almost always DNSSEC validation**, not an outage. A genuinely down nameserver fails everywhere. Two resolvers disagreeing means one is validating against something the other is not — usually a stale cached DS.

```powershell
Resolve-DnsName -Name contoso.com -Type SOA -Server 1.1.1.1   # Cloudflare — validates
Resolve-DnsName -Name contoso.com -Type SOA -Server 8.8.8.8   # Google — validates
Resolve-DnsName -Name contoso.com -Type SOA -Server 9.9.9.9   # Quad9 — validates
Resolve-DnsName -Name contoso.com -Type DS  -Server 1.1.1.1   # parent zone's DS record
```

A DS query returning the **parent zone's SOA in the Authority section** means no DS exists — the zone is correctly insecure and should resolve everywhere once caches expire. For the full chain visualized, use **dnsviz.net** or the Verisign DNSSEC debugger.

If a stale entry persists inside your own infrastructure:
```powershell
Clear-DnsServerCache -Force     # on the DC — flushes forwarder-learned answers only,
                                # does NOT touch authoritative zone data. Safe on a production DC.
Clear-DnsClientCache            # on the workstation — same as ipconfig /flushdns
```

**✅ VERIFY:** all three public resolvers return the same SOA, and a DS query returns nothing. Then wait out the longest TTL you saw before declaring it fixed — **you cannot flush someone else's resolver.**

---

### `[DNS-MAIL-05]` DKIM — do not hand-build the CNAME values

**🔄 UPDATED — the target format changed in May 2025** (verified Aug 2026). Custom domains added after that change receive a CNAME target of the form:

```
selector1-contoso-com._domainkey.<tenantprefix>.<X>-v1.dkim.mail.microsoft.com
selector2-contoso-com._domainkey.<tenantprefix>.<X>-v1.dkim.mail.microsoft.com
```

`<X>` is a **dynamic partition character** assigned by Microsoft — observed values include `k` and `r` — and it is **neither configurable nor predictable**. Domains configured before the change still use the older format ending in `<tenant>.onmicrosoft.com`, and both formats remain valid for the domains that were issued them. **The old and new formats cannot coexist for the same selector.**

**⚠ Note the trailing `.com`.** The target ends `dkim.mail.microsoft.com`, not `dkim.mail.microsoft`. Truncated examples circulate widely — including in Microsoft's own support-assistant output, which has been publicly corrected — and a target missing the TLD leaves the status stuck on `CnameMissing` with no other symptom.

**Rule: read the selector values from the portal or from `Get-DkimSigningConfig`. Never construct them from a pattern, a blog post, or an old screenshot.**

```powershell
Get-DkimSigningConfig -Identity contoso.com |
  Format-List Name,Enabled,Status,Selector1CNAME,Selector2CNAME
```

**Publish both selectors and leave both published.** Only one signs at a time; the other exists so Microsoft can rotate keys without an outage. Removing the "unused" one breaks the next rotation. A rotation takes about **96 hours** to complete, and another cannot start while one is in progress — so judge a new selector after the full window, not after an hour.

**⚠ TRAP — publishing the CNAMEs is not the same as enabling signing.** Whether signing auto-enables on CNAME detection depends on the path used to obtain the values. **Never assume the toggle state.**

- **Check:** Defender portal → **Email & collaboration → Policies & rules → Threat policies → Email authentication settings → DKIM** (`https://security.microsoft.com/authentication`). Status should read **Valid** and the toggle **Enabled**.
- **Prove:** send to an external mailbox and read `Authentication-Results`. You want `dkim=pass header.i=@contoso.com`. **If it reads `@<tenant>.onmicrosoft.com`, the custom domain is not signing** — the tenant's initial domain is, and every message will fail DMARC alignment even though DKIM "passes."

That last point is the one that traps people: `dkim=pass` on the wrong domain looks like success in every summary view and fails alignment in every DMARC evaluation.

---

### `[DNS-MAIL-06]` SPF — the rules that actually bite

```
v=spf1 include:spf.protection.outlook.com -all
```

| Token | Meaning |
|---|---|
| `v=spf1` | Version. Mandatory, must be first. |
| `include:` | Treat everything the included record authorizes as authorized here. **Costs a DNS lookup.** |
| `-all` | **Hard fail** — reject anything not listed. |
| `~all` | **Soft fail** — accept but mark. Use while inventorying senders. |
| `ip4:` / `ip6:` | Authorize a literal address or range. Free — costs no lookup. |
| `a` / `mx` | Authorize the domain's own A or MX hosts. Each costs a lookup. |

**The five rules that cause real outages:**

1. **Exactly one record beginning `v=spf1` per domain.** Two is a **permanent error**, not a warning — receivers treat the whole evaluation as `permerror` and the domain effectively has no SPF. Multiple TXT records at the apex are fine as long as only one of them is an SPF record. **Merge, never append a second.**
2. **Ten DNS lookup limit** across the whole record, including everything reached through nested includes. Exceeding it invalidates the record — again `permerror`, again silent.
3. **Never hardcode `ip4:` entries for Microsoft.** Outbound source IPs rotate constantly; two test messages sixteen minutes apart in field testing came from different addresses. `include:` inherits Microsoft's maintained list. Pinned IPs guarantee a future silent outage on a date nobody will connect to your change.
4. **Before setting `-all`, inventory every sender.** Copiers that scan-to-email, accounting packages, marketing platforms, website contact forms, CRMs, ticketing systems, and monitoring alerts all break silently — and they break for the *recipients*, so the client learns about it from a customer, not from a bounce.
5. **SPF does not survive forwarding.** When a recipient auto-forwards, the forwarding server becomes the envelope sender and SPF fails at the final destination. This is not a misconfiguration; it is how SPF works, and it is the reason DKIM alignment matters before you enforce DMARC (`[DNS-MAIL-07]`).

**Inventory method that works:** publish `~all` with a DMARC `rua` address first, then read two to four weeks of aggregate reports. The reports name every source sending as the domain, including the ones nobody remembered. **Do not do this by asking the client — they will not know.**

---

### `[DNS-MAIL-07]` DMARC — deployment template and client tuning

**Starting record — use this for every new domain:**

```
Host:  _dmarc
Type:  TXT
Value: v=DMARC1; p=none; rua=mailto:dmarc@contoso.com
TTL:   600
```

| Tag | Purpose | Notes |
|---|---|---|
| `v=DMARC1` | Version | Mandatory, first. |
| `p=` | Policy: `none` / `quarantine` / `reject` | `none` is **monitoring only — it protects nothing.** |
| `rua=` | Aggregate report destination | **The entire practical value of `p=none`.** A `p=none` record with no `rua` accomplishes literally nothing. |
| `sp=` | Subdomain policy | Absent = subdomains inherit `p`. |
| `pct=` | Percentage of failing mail the policy applies to | Defaults to 100. The ramp control. |
| `adkim=` / `aspf=` | Alignment strictness — relaxed (default) or strict | Relaxed lets a subdomain satisfy alignment for the parent. |
| `ruf=` | Per-message forensic reports | Google and Microsoft largely do not send these. Usually not worth adding. |

**Rollout ladder — do not skip steps:**

| Stage | Record | Duration | Exit criteria |
|---|---|---|---|
| **1. Monitor** | `p=none; rua=...` | 2–4 weeks | Every legitimate sender identified in the reports |
| **2. Authorize** | unchanged | as needed | Each sender fixed in SPF or DKIM |
| **3. Partial** | `p=quarantine; pct=10` → `25` → `50` | 1–2 weeks per step | No legitimate mail quarantined |
| **4. Enforce** | `p=quarantine; pct=100`, then `p=reject` | — | — |

**🛑 DANGER — never publish `p=reject` before DKIM is verified and aligned.** If SPF alone carries alignment, **every forwarded message is rejected outright** — forwarding breaks SPF (`[DNS-MAIL-06]` rule 5). Mailing lists, alumni forwarders, and "send a copy to my personal address" rules all stop working, and the bounces go to the sender, not to you.

**🛑 The most common real-world failure is not a bad rollout — it is `p=none` forever.** A monitoring record left in place for three years protects nothing while giving the client and their auditor the impression that DMARC is "done." **If you deploy stage 1, put stage 3 on a calendar with a name against it.** An unfinished DMARC rollout is worse than none, because it stops anyone from revisiting it.

**Client tuning heuristics:**

| Client shape | Recommendation |
|---|---|
| Exchange Online only, no third-party senders | The ladder can be compressed to days. Low risk. |
| Any marketing platform, CRM, or scan-to-email | Full 2–4 week monitor stage. **These are where the surprises are.** |
| Multiple domains, or one that never sends mail | Publish `v=DMARC1; p=reject;` on the non-sending domain **immediately** — nothing legitimate can break, and parked domains are a favorite spoofing target |
| Reports going to a mailbox in a **different** domain | See the trap below |

**⚠ TRAP — external `rua` destinations need authorization.** If reports go to an address outside the domain being monitored, **the destination domain must publish**:

```
Host: contoso.com._report._dmarc
Type: TXT
Value: v=DMARC1
```

Without it, conforming reporters silently drop the reports. **Nothing errors; reports simply never arrive.** This bites constantly, because every MSP wants client reports centralized in one place.

**⚠ Do not forget the tenant's `onmicrosoft.com` domain.** It is a real domain that can send real mail, and it needs a deliberate DMARC decision like any other. Most tenants have never made one.

---

### `[DNS-MAIL-08]` Bounce codes and the implicit MX fallback

| Code class | Meaning | Behavior |
|---|---|---|
| `4.x.x` | **Transient** | Sender queues and retries — typically ~48 hours before giving up. **Fix inside the window and the mail still arrives.** |
| `5.x.x` | **Permanent** | Gone. No retry. An NDR has already been generated. |

**That distinction changes what you tell the client.** A `4.x.x` on inbound mail means "fix this today and nothing is lost." A `5.x.x` means "those messages are gone; ask the senders to resend."

**Worked example — "I can send but I can't receive":**

```
<user@contoso.com>: connect to contoso.com[203.0.113.10]:25: Connection timed out
Status: 4.4.1
```

What actually happened: **no MX record existed**, so under RFC 5321 the sending server fell back to the domain's **address record** — the implicit MX rule. The apex A/ALIAS pointed at the registrar's parking web server, which is not listening on port 25. The connection hung until timeout.

**Signature: outbound works, inbound fails = verified-but-unconfigured domain.** Outbound from Exchange Online needs none of your public DNS records. Inbound needs all of them. Any time those two directions disagree, check the record set before you check anything else.

**🔄 Build order revision — see `[BUILD-P0]` §0.7 and `[BUILD-P9]`.** Verifying a domain (the `MS=` TXT record) is enough to set a UPN suffix and run Entra Connect, so it is tempting to stop there and continue with identity work. **That defers work that must be done anyway and does it later under worse conditions** — with users already synced, licensed, and expecting a working mailbox. Complete the full record set at the same sitting as domain verification.

---
---

## 29 — EXCHANGE ONLINE ADMINISTRATION `[EXO]`

§11 `[M365-02]` covers the Exchange Online cmdlets you reach for daily, and `[M365-09]` covers which recipient object to create. **This section is the operational depth underneath both**: how to read a message trace, how quarantine actually decides what a user may do, what delegation does and does not prove, and what breaks when a mailbox object is synced from on-premises AD.

---

### `[EXO-00]` Connecting to Exchange Online PowerShell — the parts that go wrong

The connect/disconnect pattern is in `[M365-02]`. Three things that are not:

**Disconnect. Every time.**
```powershell
Disconnect-ExchangeOnline -Confirm:$false
```
Sessions consume a per-tenant connection limit. Leaked sessions accumulate across a working day and eventually throw errors that look like a service outage — throttling, timeouts, "connection could not be established" — on a tenant that is perfectly healthy. **If a tenant starts refusing connections mid-afternoon, count how many consoles you left open first.**

**If `Install-Module` fails on TLS under Windows PowerShell 5.1:**
```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```
Forces TLS 1.2 for the current session only. The PowerShell Gallery refuses older protocols and the resulting error mentions neither TLS nor the Gallery. Not needed in PowerShell 7.

**Permissions.** Exchange work needs the **Exchange Administrator** Entra role, or **Organization Management** within Exchange. Global Administrator covers it and should not be used routinely — `[APX-B]`.

---

### `[EXO-01]` Message trace — what it is, and its hard boundary

**Portal:** `https://admin.exchange.microsoft.com` → **Mail flow → Message trace**. The Defender portal entry is a pass-through to the same data.

Message trace shows what Exchange Online Protection and Exchange Online did with a message **while it was inside the service**.

**🛑 It stops at the mailbox door.** It cannot see:

- **Anything after delivery** — inbox rules, Sweep rules, Focused vs Other, retention policies moving items, the user dragging it somewhere, or a client-side rule running in Outlook desktop.
- **What an external receiving server did** after accepting the handoff. Once the trace says the message was handed off, your visibility ends at that server's front door.

**The most common misread in the field:** the ticket says "the message never arrived," the trace says **Delivered**. The trace is not lying. **The message is in the mailbox and something after delivery moved it** — usually an inbox rule the user forgot they created, or a client-side rule that only runs when Outlook is open. **Pivot to the mailbox, not to mail flow.**

```powershell
# Start here when a trace says Delivered and the user says otherwise
Get-InboxRule -Mailbox user@contoso.com |
  Select-Object Name,Enabled,Priority,MoveToFolder,DeleteMessage,ForwardTo,RedirectTo
```

**🔄 Retention and report types — corrected Aug 2026.** Older references say the interactive boundary is 7 days. **In the current Exchange admin center it is 10.**

| Report type | Time range | Delivery | Result cap |
|---|---|---|---|
| **Summary report** | **Up to 10 days** | Interactive, near-instant. No other filtering required | ~20,000 results |
| **Enhanced summary report** | Up to **90 days**, queried **10 days at a time** | Downloadable CSV, generated in the background | ~100,000 results |
| **Extended report** | Up to **90 days** | Downloadable CSV, most detail | ~100,000 results |

- **Original client IP address is available only for 10 days**, and only in the Enhanced summary or Extended report — never in the interactive view. **If an investigation needs the source IP, pull it inside ten days or it is gone.**
- Background report generation can take **anything from ten minutes to several hours** depending on service load. Start it early; do not sit and wait on it.
- A historical search covers a maximum of **100 email addresses** per job.
- **Beyond 90 days the data does not exist.** Not archived, not recoverable, not retrievable by support. **Plan client evidence requirements around this ceiling** — and note it is a *different and much shorter* ceiling than the unified audit log (`[M365-18]`). Two logs, two retention periods, and the shorter one is the one people assume is longer.

---

### `[EXO-02]` Message trace — status values

| Status | Meaning |
|---|---|
| **Delivered** | Handed to the mailbox, or accepted by the next hop. **Not "read," and not "the recipient's server kept it."** |
| **Failed** | Permanent failure. An NDR was generated. |
| **Pending** | Still queued and retrying. Where a `4.x.x` bounce lives before it gives up — `[DNS-MAIL-08]`. |
| **Quarantined** | Held by policy. **Never reached the mailbox.** |
| **FilteredAsSpam** | Filtering acted on it — **it reached the mailbox and went to Junk.** |
| **Expanded** | Addressed to a distribution group and expanded into individual recipients. |

**FilteredAsSpam vs Quarantined is the distinction that changes the phone call.** Junk is inside the mailbox and the user can retrieve it themselves in ten seconds. Quarantine is held by the service and may require an admin — see `[EXO-06]`, because *whether* it requires an admin is a separate setting.

---

### `[EXO-03]` Message trace — event types and what they prove

| Event | Meaning |
|---|---|
| **Receive** | Message entered the service. |
| **Submit** | Handed into transport **by a mailbox inside the organization**. |
| **TRANSFER** | Moved between internal routing components, or bifurcated into multiple copies. |
| **Expand DL** | Group address resolved into individual member recipients. |
| **Deliver** | Landed in a mailbox **inside the tenant**. |
| **Send external** | Handed off over SMTP to a server outside the tenant. **Visibility ends here.** |
| **Spam** | Filtering verdict applied. |
| **Drop** | A recipient entry was retired. **Read the reason before assuming failure.** |
| **DLP rule** | A DLP rule was evaluated. **Evaluation, not necessarily enforcement** — see `[PURV-17]`. |

**Three heuristics worth memorizing:**

1. **Submit present = originated inside the tenant. Submit absent = arrived from the internet.** A message claiming to be from an internal sender with **no Submit event did not originate from an internal mailbox.** This is the fastest answer to *"is this spoofed, or did our CEO really send it?"* — and it takes about thirty seconds.
2. **Deliver with no Receive = arrived via group expansion**, not addressed directly. If a user insists a sender emailed them personally and the trace shows Deliver-only, they were on a list.
3. **A benign `Drop` reads `LED=250 2.1.5 RESOLVER.GRP.Expanded; distribution list expanded`.** `250` is an **SMTP success code** — the parent group recipient was retired after fan-out, by design. **Expand the row and read the full reason** before treating a Drop as a failure. This is `[DOCTRINE-12]`.

**Released-from-quarantine messages show a second Receive.** Releasing **re-injects** the message into the transport pipeline rather than moving it out of a holding area, so the trace records both passes against one message. That is expected, not a duplicate delivery.

**⚠ Tracing a distribution group takes two searches.** Search the group address to find the `Expand DL` event; search the individual member's address to find their copy. **One search will not show you both**, and the gap is where "the group didn't get it" tickets die.

---

### `[EXO-04]` Message trace — Message-ID vs MessageTrace ID

| Field | Assigned by | Use |
|---|---|---|
| **Message-ID** | The **originating** mail system. Never changes. Follows the message across every system it touches. | **The highest-precision search key you have.** Have the user open the original and copy the `Message-ID:` header rather than guessing at timestamps and subject lines. |
| **MessageTrace ID** | A GUID internal to Exchange Online's trace database. Meaningless outside Microsoft. | Hand to Microsoft Support when escalating. |

A message that originated **outside** your tenant keeps its foreign Message-ID (`...@sender-domain.com`). A message that originated **in** Exchange Online carries the Microsoft format (`...@<server>.<region>.PROD.OUTLOOK.COM`). **That alone tells you which direction the message came from**, before you look at a single event.

---

### `[EXO-05]` Message trace — time zone rendering trap

**⚠ TRAP.** The event list header labels the time zone by its **standard** offset while rendering times in **daylight** time. A header reading `Date (UTC-07:00)` next to a delivery time of `01:50 UTC` will display **`7:50 PM`, not `6:50 PM`**, because Mountain Daylight is UTC-6.

**Rule: correlate in UTC.** The Delivery time field gives it to you directly. This matters the moment you compare a message trace against a firewall log against a user's Outlook clock — three sources, three time bases, and an hour of apparent contradiction.

*(Same class of failure as Kerberos rejecting a domain join over clock skew — `[AD-TIME]`. Time handling reliably produces failures that present as something else entirely.)*

---

### `[EXO-06]` Anti-spam and quarantine — two policy objects, not one

**This is the distinction juniors collapse, and it is the one that determines what you tell the user.**

| Object | Answers |
|---|---|
| **Anti-spam policy** | *Should this message be quarantined?* |
| **Quarantine policy** | *Once quarantined, what may the end user do about it?* |

Every quarantining action gets its own quarantine policy assignment. The built-ins:

| Quarantine policy | User can |
|---|---|
| `AdminOnlyAccessPolicy` | **Nothing.** The message does not appear in the user's quarantine view at all. Only an admin can release it. Default for high-confidence phishing and malware — **deliberately**, so users cannot self-release the thing that encrypts the file server. |
| `DefaultFullAccessPolicy` | View and release their own quarantined mail. |
| `DefaultFullAccessWithNotificationPolicy` | Same, plus periodic digest notifications. |

**The correct answer to "can I get it back myself?" is: "Let me check — it depends how it was classified."** Then look at the quarantine policy attached to the action that caught it. Sending a user to a page that will show them nothing is a wasted callback and a small credibility loss.

**Default action mapping — the default anti-spam policy** (verify per tenant; all of this is configurable):

| Verdict | Default action |
|---|---|
| Spam | Move to Junk Email |
| High confidence spam | Move to Junk Email |
| Phishing | Move to Junk Email *in the default policy*; **Quarantine in new policies created in the Defender portal** |
| **High confidence phishing** | **Quarantine**, with `AdminOnlyAccessPolicy` |
| Bulk | Move to Junk Email |

**🛑 High confidence phishing is always quarantined and users can never self-release it.** The "Move to Junk Email" action is effectively deprecated for that verdict — you may be able to select it, and it will still quarantine. **Users cannot release their own high-confidence phishing regardless of any quarantine policy an admin configures.** Do not promise a user you can make it self-service; you cannot.

**⚠ Malware detections are also always quarantined.** Quarantine cannot be turned off tenant-wide. What an admin can do is change *other* verdicts from Quarantine to Junk — not remove quarantine as a mechanism.

**🔄 Retention — corrected Aug 2026.** `Retain spam in quarantine for this many days` (`QuarantineRetentionPeriod`):

| Where the policy was created | Default |
|---|---|
| The **default** anti-spam policy, and policies created in the **Defender portal** | **30 days** |
| Policies created in **PowerShell** | **15 days** |

Valid range is **1–30 days**. **Read the value off the policy rather than quoting a number at a client** — a tenant can legitimately show either. Once purged, quarantined mail is permanently deleted and is not recoverable. Preset Standard and Strict policies do not allow the value to be changed at all.

---

### `[EXO-07]` Testing spam filtering, and the allow-list anti-pattern

**Do not use GTUBE.** It is not documented as supported by Exchange Online Protection and does not reliably trip it. You will send it, watch it land in the inbox, and lose twenty minutes concluding the filter is broken when nothing is.

**Deterministic methods:**

| Method | Notes |
|---|---|
| Blocked sender entry in the anti-spam policy | Fast, and mirrors a real weekly ticket. Requires blocking a real address. |
| Mail flow rule stamping `SCL 9` on a subject keyword | More surgical, no real address blocked. **The better production technique** — reversible in one click and scoped to a string only you will use. |

**🛑 DANGER — allowed-sender lists are a security anti-pattern.** Microsoft's own documentation states plainly that unnecessary allow entries expose the organization to mail the system would otherwise filter.

- The entry keys on the **sender address**, which is a header field and trivially forgeable. **You have not allowed *that person* — you have allowed anyone claiming to be them.**
- Allow entries created in the **Tenant Allow/Block List (TABL)** override filtering verdicts up to regular-confidence phishing.
- **TABL allow entries expire by design** — by default 45 days after the filtering system determines the entity is clean, or up to 30 days if you set a fixed date. **Microsoft built expiry in because permanent allows are considered dangerous.** (Spoof allow entries are the exception: those never expire.)
- **Anti-spam policy allowed-sender lists never expire.** These are the worst of the three places to put an allow, and the ones Microsoft's guidance singles out.

**The correct tool for "legitimate mail got quarantined" is: release and report as a false positive.** That creates a temporary, scoped allow **and** trains the filter, so the override stops being necessary. It is self-healing. A manual allow entry is permanent human error waiting to be forgotten by someone who has left the company.

**An inherited tenant with a long list of never-expiring allow entries is a finding you write up** — record it in `[ASSESS-02]` alongside the other override inventory required by `[DOCTRINE-11]`.

**⚠ Lab / production divergence.** The Default anti-spam policy is always **lowest priority** and applies to everyone not covered by another policy. **Do not edit it to test things.** Create a scoped policy at higher priority targeting a single test user, and delete it when you are done. Editing the default policy for a test is how a tenant-wide setting change survives the ticket that caused it.

---

### `[EXO-08]` Shared mailboxes

**What it is:** a real mailbox with a real Entra user object behind it, and **that account is blocked from sign-in**. Not a distribution group, not an alias. It has storage, folders, a calendar, and its own address.

**Licensing:** no license required **under 50 GB**. Above 50 GB, or if it needs an online archive or litigation hold, it needs an Exchange Online license — `[M365-09]`. `info@`, `support@`, `billing@` cost nothing, which is one of the most useful cost facts in SMB work and one clients are routinely paying for unnecessarily.

**🛑 SECURITY — the hidden account is a standing target.** The sign-in block **is** the control. Attackers specifically hunt for shared mailbox accounts where someone enabled sign-in "to make it easier" — a mailbox nobody watches, receiving mail from customers, with a password nobody rotates.

```powershell
# Every shared mailbox, and whether its account can sign in.
# Run this on every tenant you inherit.
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited |
  ForEach-Object {
      $u = Get-MgUser -UserId $_.ExternalDirectoryObjectId -Property DisplayName,AccountEnabled -ErrorAction SilentlyContinue
      [pscustomobject]@{
          Mailbox        = $_.PrimarySmtpAddress
          SignInEnabled  = $u.AccountEnabled     # $true here is a finding
      }
  } | Format-Table -AutoSize
```
Requires an active `Connect-MgGraph` session as well as Exchange Online — `[M365-01]`.

**Three permission types:**

| Permission | Effect |
|---|---|
| **Full Access** | Open, read, organize, delete. **Grants no right to send.** |
| **Send As** | Mail appears to come from the shared mailbox, full stop. The delegate is invisible in the message. |
| **Send on Behalf** | Recipient *may* see `Delegate on behalf of Mailbox` — subject to client rendering. See `[EXO-09]`. |

Full Access and Send As are **independent**. Granting Full Access alone produces the ticket *"I can read it but I can't reply from it"* — reliably, on the first day, in every deployment.

**⚠ If an account holds both Send As and Send on Behalf, Send As wins.** Exchange prefers it and Send on Behalf never fires. If you configured Send on Behalf for attribution reasons and it is not appearing, check whether Send As is also granted.

**Automapping:** Full Access granted **directly to a user** triggers automapping — Autodiscover tells Outlook desktop to mount the mailbox automatically. It does **not** fire for permissions granted through a group. Once mapped it is stubborn to remove; control it at grant time:

```powershell
Add-MailboxPermission -Identity shared@contoso.com -User jsmith@contoso.com `
  -AccessRights FullAccess -InheritanceType All -AutoMapping:$false
```

Outlook on the web does not auto-mount regardless; the user adds the mailbox manually.

**⚠ The group-vs-direct distinction is a design decision, not a detail.** Granting through a group scales and survives staff turnover, but loses automapping — so every user must add the mailbox by hand once. Granting directly automaps but does not scale and drifts. **Pick deliberately and write down which you chose**, because the next technician will assume the other one.

**Sent Items — fix this on day one:**

```powershell
Set-Mailbox -Identity shared@contoso.com `
  -MessageCopyForSentAsEnabled $true `
  -MessageCopyForSendOnBehalfEnabled $true
```

Without it, a delegate's sent copy lands only in **their** Sent Items and nobody else on the team can see it. This produces the classic ticket: *"We can't tell who already replied to the customer, so we keep double-answering."* **Two separate switches — setting one does nothing for the other. Not retroactive**; messages already sent stay where they landed.

**✅ VERIFY:**
```powershell
Get-Mailbox -Identity shared@contoso.com |
  Format-List Name,MessageCopyForSentAsEnabled,MessageCopyForSendOnBehalfEnabled
```
Then have a delegate actually send one, and confirm the copy appears in **the shared mailbox's** Sent Items — not just that the setting reads `True`.

*(Legacy guidance about a `DelegateSentItemsStyle` registry key on the client is obsolete. The server-side parameters are correct and work regardless of client.)*

---

### `[EXO-09]` Delegation and attribution — what message trace can and cannot tell you

**Send As erases the submitter.** It does not add a sender, it *replaces* one. **If three people hold Send As on `sales@` and one of them emails a client something they should not have, message trace cannot tell you which human it was.** Plan for that before you grant it, not during the incident.

**Send on Behalf preserves the submitter.** Per RFC 5322, two address headers are produced:

| Header | Value | Meaning |
|---|---|---|
| `From:` | the mailbox | The **author** |
| `Sender:` | the delegate | The **submitter** — added only when it differs from the author |

**⚠ TRAP — the attribution guarantee does not hold at the recipient.** Whether the recipient *sees* "on behalf of" depends entirely on their mail client:

- **Outlook desktop** parses `Sender:` and renders `Delegate on behalf of Mailbox`.
- **Gmail's "Show original" summary table does not list `Sender:`** — it is present only in the raw headers below.

**Same message, same headers, two clients, two different displays.**

> **Send on Behalf preserves attribution in the message. It does not guarantee the recipient will ever see it.** Where accountability actually matters — compliance, legal, regulated communications — the enforceable record is the **mailbox audit log**, not the recipient's rendering and not message trace.

To recover attribution under Send As, use mailbox auditing: Exchange logs a `SendAs` audit record naming the delegate, searchable through the **unified audit log** in Purview (`[M365-18]`). **Message trace and audit logs answer different questions, and the audit log is the one that survives long enough to matter** — 180 days minimum against message trace's 90.

**DMARC is unaffected by Send on Behalf** — DMARC aligns on the `From:` domain only. `Sender:` plays no part in the evaluation.

---

### `[EXO-10]` Mail-enabled groups — the operational consequences

The group-type decision table is `[M365-10]`; the Exchange recipient table is `[M365-09]`. **Do not re-derive them here.** What follows is what those tables do not tell you.

**⚠ Terminology trap.** In Active Directory, "distribution group" means any group with no security context. **In Exchange, every mail-enabled group is called a distribution group**, security context or not — so `Get-DistributionGroup` returns mail-enabled security groups too. This inconsistency has existed for twenty years and is not going to be fixed.

```powershell
Get-DistributionGroup | Format-List Name,RecipientTypeDetails,PrimarySmtpAddress,IsDirSynced
```
`RecipientTypeDetails` is the field that separates them: `MailUniversalDistributionGroup` vs `MailUniversalSecurityGroup`.

**✅ The demonstration that settles the argument:** try to grant each group a mailbox permission. The mail-enabled security group is selectable; the distribution group is not, **because it is not a security principal.**

**Design rule — default to separate objects.**

Coupled objects fuse two concerns that change on different schedules. The failure mode is the **Mover** in the Joiner–Mover–Leaver lifecycle:

| Stage | Coupled group behavior |
|---|---|
| **Joiner** | Fine, arguably convenient — one add, both effects. |
| **Mover** | **The failure.** User transfers departments. Someone adds them to the new list so they receive mail. **Nobody removes the old membership, because that would cut off mail during handover.** They now hold file access to both departments indefinitely — **entitlement creep**, which audits find constantly. |
| **Leaver** | Fine. One removal kills both. |

**Coupled objects do not fail at grant time. They fail at *change* time, months later, silently.** That is why they survive review: at the moment anyone looks at them, they look correct.

**Mail-enable when the coupling is the point** — group-based licensing requires a security principal, and a distribution group cannot do it (`[M365-13]`, `[HYB-LIC]`).

**Two defaults to check on every new mail-enabled group:**

| Setting | Risk if wrong |
|---|---|
| *Allow external senders* | Correct for a public `info@`. **Wrong for an internal all-staff list** — it becomes a one-address broadcast channel into the entire company for anyone on the internet. **A real, actively exploited phishing vector.** |
| *Joining the group: Open* | Low stakes on a distribution list. **On a mail-enabled security group this is self-service privilege escalation** — any user can add themselves to a group carrying resource permissions. **Set to Closed.** |

Both belong in `[ASSESS-02]` when you inherit a tenant.

---

### `[EXO-11]` Universal scope requirement — and what it means for AGDLP

**Only universal groups can be mail-enabled.** Domain-local and global groups cannot be; converting requires `Set-Group` in the Exchange shell.

**Consequence for a standard AGDLP model (`[AD-AGDLP]`):** `GG-Department` is global, `DL-Department-Modify` is domain-local. **Neither can be mail-enabled as-is.**

That is not a flaw in AGDLP. It means **"just mail-enable the department group" is not available** without changing group scope — which carries its own replication implications in a multi-domain forest, because universal group membership replicates to every Global Catalog in the forest rather than staying within the domain.

**The clean answer in most SMBs:** create a separate universal mail-enabled group for the mailing list and leave the AGDLP structure alone. **You wanted separate objects anyway** — `[EXO-10]`.

---

### `[EXO-12]` Synced objects are read-only in the cloud `[EXO-PROXY]`

**Anything sourced from on-premises AD must be managed in on-premises AD.** Entra Connect writes AD → cloud; for these attributes there is no write-back.

**Symptom set, worst to best:**

1. **A change that appears to save and silently reverts on the next sync cycle.** Looks like it worked. Gone in half an hour. **This is the worst one, because you have already closed the ticket.**
2. A vague error about write scope.
3. A grayed-out field with an explicit banner: *"This user is synchronized with your local Active Directory. Some details can be edited only through your local Active Directory."*

**Check this before hunting for a permissions problem:**
```powershell
Get-Mailbox -Identity user@contoso.com |
  Format-List Name,IsDirSynced,UserPrincipalName,PrimarySmtpAddress,EmailAddresses
```

`IsDirSynced : True` answers the question in one line and saves you from granting yourself roles you did not need.

---

### `[EXO-13]` proxyAddresses — aliases and changing the primary SMTP

Every mail-enabled object carries the multi-valued **`proxyAddresses`** attribute. **The prefix determines the role, and case is significant:**

```
SMTP:jsmith@contoso.com                      ← UPPERCASE = PRIMARY (reply address)
smtp:john.smith@contoso.com                  ← lowercase = alias, receives only
smtp:jsmith@contoso.onmicrosoft.com          ← tenant routing address — DO NOT REMOVE
SIP:jsmith@contoso.com                       ← Teams presence / calling identity
```

**Uppercase vs lowercase is the entire mechanism.** Exactly one `SMTP:` entry per object. "Changing someone's email address" means **promoting one entry and demoting another** — the old address stays as an alias so existing mail keeps arriving.

**Procedure (hybrid — make the change in AD):**

```powershell
# 1 — add the alias on-premises
Set-ADUser -Identity jsmith -Add @{proxyAddresses="smtp:john.smith@contoso.com"}

# 2 — force a delta sync on the Entra Connect server
Start-ADSyncSyncCycle -PolicyType Delta

# 3 — verify in the cloud
Get-Mailbox -Identity jsmith@contoso.com | Select-Object -ExpandProperty EmailAddresses
```

| Component | Purpose |
|---|---|
| `-Add` | Appends to a multi-valued attribute. **🛑 Never use `-Replace`** — it overwrites the entire array and wipes the `onmicrosoft.com` and `SIP:` entries in one command, with no warning and no confirmation prompt. |
| `@{...}` | PowerShell hashtable — the syntax `Set-ADUser` requires for raw attribute edits. |
| `-PolicyType Delta` | Processes only changed objects. Correct for an attribute edit. `Initial` is a full resync, needed when a **rule or filter** changed — not for this. |

**To promote an alias to primary:** in AD, change the alias prefix to uppercase `SMTP:` and demote the old primary to lowercase.

**Also update the on-premises `mail` attribute.** It is a **separate, single-valued attribute**, and plenty of line-of-business applications read `mail` instead of `proxyAddresses`. Leaving it stale is the classic cause of *"the new address works everywhere except the ticketing system."*

```powershell
Get-ADUser -Identity jsmith -Properties mail,proxyAddresses |
  Format-List Name,mail,proxyAddresses
```

**`-Properties` is required.** `Get-ADUser` returns a minimal default set, and `mail` and `proxyAddresses` are not in it. **Forgetting `-Properties` and concluding an attribute is empty is a common early mistake** that sends people down a rebuild path for a value that was there all along.

**✅ VERIFY after taking over the attribute from AD:** confirm `smtp:<user>@<tenant>.onmicrosoft.com` and `SIP:` survived. Both are generated cloud-side, and AD is now authoritative for the whole array — anything AD does not contain, the cloud object loses.

---

### `[EXO-14]` UPN is not primary SMTP

| Attribute | What it is |
|---|---|
| `userPrincipalName` | The **sign-in identifier** |
| Primary SMTP (`SMTP:` in `proxyAddresses`) | The **reply address** |

**Separate attributes. Entra Connect syncs both. Editing one never touches the other.**

Changing a primary SMTP therefore produces a user who **emails as one string and signs in as another** — and the ticket *"I changed my email but it says my password is wrong,"* because they are typing the new address at the sign-in prompt and it is not their UPN.

**Production rule:** when you change an address for a name change or a rebrand, **change both and tell the user their sign-in is changing.** A permanent UPN/SMTP mismatch is a low-grade support tax forever, paid one confused ticket at a time.

**⚠ Do not change a UPN casually in a hybrid environment with Entra-joined devices.** It forces re-authentication across every cached credential and token on the device, and hybrid join state is fiddly to recover (`[HYB-JOIN]`). UPN changes in hybrid have also historically had sync quirks for already-licensed synced users. **If a UPN change does not appear in Entra after a sync cycle, that is a known class of problem, not something you misconfigured** — verify current behavior against Microsoft's documentation at the time rather than assuming you broke it.

**Sign-in with a non-UPN address — resolved.** Field observation in one project appeared to show a user signing in with both the old UPN and the new primary SMTP. **That is not the documented default behavior**, and the explanation is now clear:

- Microsoft's **"Email as an alternate login ID"** feature does enable sign-in with `proxyAddresses` in addition to UPN, but it is **public preview**, must be explicitly enabled via **Home Realm Discovery policy** (tenant-wide) or **staged rollout** (per group), and **explicitly does not support Microsoft Entra hybrid joined or Entra joined devices**, ROPC, or some third-party applications. It also requires cloud authentication — PHS or PTA.
- Microsoft documents that even when the feature *is* on, **users may still see their UPN after signing in with a non-UPN email** — and that entering a wrong password on the non-UPN prompt causes the page to switch to displaying the UPN.
- **The most likely explanation for an apparent success without the feature enabled is a cached browser session, plus OWA displaying the primary SMTP address in the account panel rather than the sign-in identifier.**

**Test properly before relying on it:** fully sign out, clear the session or use a private window, and enter the non-UPN address at a cold credential prompt. **Do not tell a client this works based on a warm session.**

**⚠ If you do enable the feature, know the collision rule:** within a tenant, a **cloud-only** user's UPN can be the same string as another user's synced proxy address. With alternate login ID enabled, **the cloud-only user can no longer sign in with their own UPN.** That is a real outage created by a feature toggle, and it will not be obvious.

---
---

## 30 — SHAREPOINT ONLINE AND ONEDRIVE — SHARING AND GUEST ACCESS `[SPO]`

`[M365-03]` covers the SharePoint Online PowerShell module and the OneDrive sync checklist. `[M365-11]` covers site objects, permission levels, and the content hierarchy. **This section covers external sharing and guest access** — the surface where SMB tenants leak data, and the surface Copilot makes visible (`[AI-03]`).

---

### `[SPO-01]` External sharing — three layers, most restrictive wins

| Layer | Where | Scope |
|---|---|---|
| **Tenant** | SharePoint admin center → Policies → **Sharing** | Ceiling for everything |
| **Site** | SharePoint admin center → Active sites → *site* → External sharing | **Cannot exceed tenant** |
| **Item** | The Share dialog on a file or folder | **Cannot exceed site** |

**Diagnose top down.** The user sees a grayed-out option at the item level; the cause is usually two layers up. A restrictive tenant setting makes the other two irrelevant, so checking the item first wastes the trip.

**The four levels, most to least permissive:**

| Level | Behavior |
|---|---|
| **Anyone** | Anonymous links. **No sign-in, no identity, no audit trail tied to a person.** The link works for whoever it is forwarded to, including whoever finds it in a forwarded email three years from now. |
| **New and existing guests** | Recipient must sign in or provide an emailed verification code. **Creates a guest object.** |
| **Existing guests** | Only guests already in the directory. |
| **Only people in your organization** | No external sharing. |

**⚠ TRAP — SharePoint and OneDrive are set independently.** OneDrive more permissive than SharePoint is a common misconfiguration and is easy to miss because the two sliders sit side by side on the same page and look like one control. **Read both.**

**⚠ TRAP — the slider is not the only control.** Which link types actually appear in the Share dialog is governed by a separate **File and folder links** section further down the same page — default link type, link expiration, and whether Anyone links may grant edit. **A tenant set to Anyone can still fail to offer an Anyone link** if the default-link setting or a site-level setting constrains it.

**Symptom: "I set the tenant to Anyone and the option still doesn't appear."** Check all three, in order: **tenant slider → File and folder links → site-level setting.**

**Baseline recommendation for SMB: New and existing guests.** Reserve **Anyone** for specific sites that genuinely need it, set **at the site level**, with link expiration configured. **WHY:** an Anyone link is the only sharing mechanism with no identity attached, which means it is the only one you cannot answer questions about afterward. "Who accessed this?" has no answer. For most SMBs the business need behind "we need Anyone links" turns out to be "we need to send a file to a customer without them creating an account," and a verification-code guest share does that.

---

### `[SPO-02]` Anyone link vs specific-person share — different mechanisms

**These are frequently conflated. They behave differently and require different settings.**

| Mechanism | Minimum tenant setting | Creates guest object? | Recipient verification |
|---|---|---|---|
| Anonymous "Anyone" link | **Anyone** | **No** | None |
| Share with a specific external person | **New and existing guests** | **Yes** | Email code or sign-in |
| Existing guest only | **Existing guests** | No — already exists | Sign-in |

**Diagnostic value:** if a guest object was created and the recipient had to enter a PIN, **that was a specific-person share operating under *New and existing guests*** — regardless of whether the tenant ceiling happens to be set to Anyone. **Ceiling and mechanism are different questions,** and the evidence tells you which mechanism ran.

**Client-facing consequence — the question you will be asked:** *"Can we still share with clients if we turn off Anyone links?"* **Yes.** Named-recipient sharing is unaffected. This is the answer that unblocks the hardening change, and most clients accept it immediately once it is stated plainly.

---

### `[SPO-03]` Guest objects — recognizing and auditing them

Guest UPN format:

```
jsmith_partnerdomain.com#EXT#@contoso.onmicrosoft.com
```

Original address with `@` replaced by `_`, then the `#EXT#` marker, then **your tenant's** initial domain. **Guests live in your namespace, not theirs.**

| Consequence | Detail |
|---|---|
| **Directory presence** | Guests appear in your user list and count toward directory objects. `Creation type: Invitation`. |
| **Oversharing vector** | **Guests are searchable in people pickers**, which is how external access spreads beyond the original file to things nobody intended to share. |
| **Audit key** | **`#EXT#` is the string you filter on** when answering *"who outside the company has access to our files?"* |

```powershell
# Every guest in the tenant, with when they were invited and whether they ever signed in
Get-MgUser -All -Filter "userType eq 'Guest'" `
    -Property DisplayName,UserPrincipalName,Mail,CreatedDateTime,SignInActivity |
  Select-Object DisplayName,Mail,CreatedDateTime,
                @{n='LastSignIn';e={$_.SignInActivity.LastSignInDateTime}} |
  Sort-Object CreatedDateTime
```
`SignInActivity` requires the `AuditLog.Read.All` scope and **Entra ID P1 or higher**. **Guests with no sign-in activity and an old creation date are the cleanup list** — start there in every inherited tenant.

**⚠ Guest creation and invitation delivery are separate steps.** The guest object can exist with access granted **while the notification silently fails**. The person has access and does not know it — and **it will not appear in a message trace** (`[SPO-05]`). This is the state where an external party holds standing access to client data with nobody aware of it on either side.

**Production item:** the B2B consent screen shown to guests displays *"[Organization] has not provided links to their terms for you to review"* unless a privacy statement URL is configured. Entra → **External Identities** → user settings. **For any client with a compliance posture, this is a finding** — it is a visible, external-facing statement that the organization has no published terms, seen by every partner they invite.

---

### `[SPO-04]` Permission inheritance — the part people miss

The inheritance model is in `[M365-11]`. **The operational detail that is not there:**

**⚠ Breaking inheritance restricts nothing by itself.** Immediately after the break, the permission list is an **exact copy** of what was inherited, so nothing appears to change. People miss this and assume the break failed, then break it again somewhere else.

**Breaking inheritance is step one of two.** Step two is removing the principals that should not be there. **A break with no follow-up removal is pure downside** — you have kept the same access and lost the ability to manage it from the parent.

**🛑 Every broken-inheritance object is a permission set nobody will ever review again.** It does not surface when you audit the site, it silently diverges from the parent forever, and it does not resume on its own. In a Copilot tenant this is precisely where the surprises live — **Copilot surfaces anything a user technically has access to**, so permissions people forgot about become search results (`[AI-03]`, `[AI-07]`).

Same failure mode as `[FILE-02]` on NTFS. Different product, identical mechanism, identical outcome.

---

### `[SPO-05]` Sharing notification emails are not in message trace

**🛑 Reaching for message trace here wastes your time.** SharePoint and OneDrive sharing invitations are sent by **SharePoint's own notification infrastructure** from `no-reply@sharepointonline.com`. They do not originate from a mailbox in your tenant and **will not appear as outbound messages in an Exchange Online message trace.**

**Microsoft documents two causes for a sharing invitation not arriving:**

1. **The sending address is flagged as spam by the recipient's provider.** Check Junk/Spam first — free, instant, and often the answer.
2. **The `Email` property on the sender's Entra user profile is empty.** The invitation is sent *on behalf of* the sharing user and pulls that identity from **Entra → user → Contact Information → Email**. **This is a separate field from the mailbox's primary SMTP address.** A licensed account with a fully working mailbox can still have a blank profile Email, and the notification then **silently does not send**. Also confirm **User type is Member, not Guest**.

*(Same class of problem as the on-premises `mail` attribute in `[EXO-13]`: **the same logical concept lives in several attributes across several systems, and they do not update each other.** Recognizing that pattern is worth more than memorizing either instance.)*

---

### `[SPO-06]` The people picker trap

**⚠ One of the most common causes of "I shared it and they never got it."**

You start typing an external address, the picker surfaces a directory match whose display name resembles what you were typing, you press Enter — **and you have shared internally with the wrong principal.** The dialog confirms success, **because the share did succeed.** Just not to the address you meant.

**Evidence that this is what happened:**

| Observation | Reading |
|---|---|
| Confirmation dialog names a **person**, not the email address you typed | Resolved to a directory object |
| No guest object created in Entra | No external user was invited |
| Nothing at the recipient — **not even in spam** | Nothing was ever sent there |
| Post-share permissions show no external principal | Confirms it |

**Rule: read the confirmation dialog as data.** It names the recipient. **Verify it matches what you typed before you start diagnosing delivery** — `[DOCTRINE-12]`.

**Prevention:** type the full address and **do not accept an autocomplete suggestion** when sharing externally. The keystroke you save is not worth the twenty minutes.

**⚠ The security version of this is worse than the support version.** If the wrongly-matched principal happens to be a guest from an unrelated partner organization, you have just granted an outside party access to a document — and the only trace is a permission entry nobody is looking at. Same mechanism, different outcome.

---

### `[SPO-07]` Break-glass account naming

**🛑 Never give an emergency access account a display name that resembles a real person's.**

Two failure modes:

1. **Accidental use.** Any people picker in the tenant will offer it as a match. Files get shared to it, meetings get sent to it, and nobody notices because it looks like a colleague.
2. **Audit illegibility.** Break-glass sign-ins should be **rare and alarming**. When the account is named after a person, a sign-in looks like normal activity in a log rather than an event demanding an explanation. **The alert you built on it becomes noise.**

**Name it unmistakably:** `BREAKGLASS - Emergency Access (DO NOT USE)`.

**🛑 Change the display name only. Do not touch the UPN** — that is the credential used in an actual lockout, it is what is written in the vault and in the runbook, and it must stay **exactly** as documented. Changing it during a tidy-up is how a break-glass account stops working on the one day it is needed.

See `[APX-B]` and `[M365-14]` for the rest of the break-glass configuration — excluded from every Conditional Access policy, hardware key, alerted on.

---

### `[SPO-08]` Roles required, and the Business Premium reality

**SharePoint Administrator** (Entra role) is required for site-level permission management surfaces such as **Manage access**. Global Administrator covers it and should not be the answer.

**⚠ Least privilege — do not stack standing admin roles on a daily-driver account.** When something is grayed out, **diagnose the specific missing role and grant only that one.** "Give them Global Admin and see if it works" is a diagnostic method that leaves permanent damage behind, because nobody ever comes back to remove it.

**The production answer is Privileged Identity Management** — roles held *eligible* rather than *active*, elevated just-in-time with justification and a time limit (`[M365-15]`).

**🛑 PIM requires Entra ID P2. Microsoft 365 Business Premium includes P1 only.** There is no P1 workaround and no partial version. **The honest answer to a Business Premium client asking for just-in-time elevation is that it requires a license upgrade.**

**The Business Premium approximation** is a **separate admin account** holding the roles, used only for admin work, with MFA and no mailbox or license beyond what it needs. It is not JIT — the privilege is standing — but it does separate the blast radius of a compromised daily-driver account from the tenant's administrative control, which is most of the value. **Say plainly that it is an approximation**; do not describe it to a client as equivalent to PIM.

---
---

## CHANGELOG

| Version | Date | Changes |
|---|---|---|
| **1.3** | **2026-08-23** | Added **§28 Public DNS for mail `[DNS-MAIL]`**, **§29 Exchange Online administration `[EXO]`**, **§30 SharePoint Online and OneDrive — sharing and guest access `[SPO]`**. Extended §26 with `[PURV-14]`…`[PURV-19]` (Business Premium licensing boundary, create-vs-publish, the DLP confidence dial, the **simulation-mode trap**, Encrypt vs Block, reporting lag). Added `[DOCTRINE-11]` (an override makes your diagnostics lie) and `[DOCTRINE-12]` (read the screen before you diagnose). Added `[DNS-MAIL-PRE]` public-DNS pre-flight and a matching `[APX-A]` checklist; added `[BUILD-P0]` §0.6 and amended `[BUILD-P9]` so the full public DNS record set is completed at domain-verification time. Four new `[ERR]` subsections, 15 new `[APX-F]` rows, 14 new `[APX-H]` rows. Source: M365 administration project, 22–23 August 2026 — project-specific hosts, domains, and tenant names stripped. **12 further factual corrections applied — see `[APX-C]` #43–#54**, including a corrected DKIM CNAME format, a corrected message-trace retention boundary, and a corrected quarantine retention default. The module's own integration instructions were **not** followed on two points, both documented in `[APX-C]`-adjacent notes: it targeted §23–§26, which are occupied, and it proposed a `[PUR]` tag prefix that collides with the existing `[PURV]`. **Purview material was merged into §26 rather than creating a second Purview section.** Manual-wide spelling normalized to American English. Section numbers and tags §00–§27 unchanged. |
| **1.2** | **2026-08-21** | Added **§26 Microsoft Purview and data governance `[PURV]`** and **§27 Copilot and agent administration `[AI]`**. Expanded §11 with `[M365-08]`…`[M365-20]` (portal decision table, Exchange recipient objects, Entra group types, SharePoint objects and inheritance, Teams policies, licensing mechanics, Conditional Access anatomy, PIM, app registrations vs enterprise apps, the three security scores, unified audit log, authentication methods, Defender XDR). Added `[APX-F]` disambiguation index, `[APX-G]` requirement → tool index, `[APX-H]` hard limits and defaults. Added Microsoft 365 / Purview / Copilot rows to `[ERR]`. Source: AB-900 study guide (Microsoft 365 Copilot and Agent Administration Fundamentals) — exam mechanics, domain weighting, self-test, and study plan stripped; principles, procedures, and click-paths retained. **16 further factual corrections applied — see `[APX-C]` #27–#42.** Ten load-bearing claims independently verified against Microsoft Learn and Microsoft blogs in August 2026; the two that could not be verified are labeled as such in `[APX-C]` #40. Section numbers and tags §00–§25 unchanged; CHANGELOG relocated to the end of the document. |
| **1.1** | **2026-08-20** | Added **§22 Networking fundamentals `[NETF]`**, **§23 Security fundamentals `[SECF]`**, **§24 Systems and directory fundamentals `[SYSF]`**. Source: Google IT Support Specialist course notes — course and assessment scaffolding stripped, principles retained. Closes the manual's largest gap: it had operational depth with no protocol/security fundamentals layer (no prior coverage of OSI, CIDR, subnet math, DNS record types, DORA, TCP handshake semantics, cryptography, AAA, or the Kerberos ticket flow). Cross-references added from `[NET]`, `[AD-TIME]`, `[AD-LOCKOUT]`, `[SEC-LAPS]`, and `[DISK-02]`. **10 further factual corrections applied — see `[APX-C]` #17–26.** Personal additions renumbered §22 → §25. |
| 1.0 | 2026-08-19 | Initial consolidation. Sources: hybrid network build playbook, decommission runbook, MSP technician reference, PowerShell/AD cheat sheet, Entra Connect troubleshooting guide, homelab networking reference, DHCP option guide, AD decommissioning inventory script, SSD reformat guide, AZ-900 study guide, Round 1 build transcript. All client-identifying material stripped. 16 factual corrections applied — see `[APX-C]`. |

<!--
ADD NEW ENTRIES BELOW THIS LINE using the template in §00.3.
Keep the tag prefix consistent with the section it belongs to.
-->
