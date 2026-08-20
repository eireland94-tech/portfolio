# IT FIELD MANUAL

**A living, searchable operational reference for Windows, Active Directory, Microsoft 365, Entra ID, Intune, and Azure.**

| | |
|---|---|
| **Version** | 1.0 |
| **Compiled** | 19 August 2026 |
| **Scope** | Endpoint support → AD/hybrid infrastructure → cloud administration |
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
| **22** | [Personal additions](#22--personal-additions) | your new entries go here |

### Fast paths — the five things you will look up most

| Situation | Go to |
|---|---|
| Something is broken and you have an error message | **§18** `[ERR]` |
| A user cannot log in | `[AD-LOCKOUT]` → `[ASSESS-03]` |
| Group Policy is not applying | `[GPO-TRIAGE]` |
| A device is not showing up in Intune | `[HYB-JOIN]` → `[MDM-04]` |
| You are walking into a network you have never seen | `[ASSESS-01]` |

## 00 — HOW TO USE THIS MANUAL

### 00.1 — Search tags

Every major block carries a bracketed tag. **Search the tag, not the prose.** Tags are stable across versions, so a note you write today that says "see `[AD-JOIN-FAIL]`" still resolves in version 12.

| Prefix | Domain |
|---|---|
| `[DOC]` | Documentation templates, ticket formats |
| `[PS]` | PowerShell language, syntax, safety patterns |
| `[NET]` | Networking, DNS, DHCP, diagnostics, ports |
| `[AD]` | Active Directory operations and build |
| `[GPO]` | Group Policy |
| `[FILE]` | File services, shares, NTFS, permissions |
| `[HYB]` | Hybrid identity — Entra Connect, hybrid join, SCP |
| `[MDM]` | Intune, device management, compliance |
| `[M365]` | Exchange Online, SharePoint, OneDrive, Graph, licensing |
| `[AZ]` | Azure architecture, governance, cost |
| `[WIN]` | Windows client build, OOBE, imaging |
| `[DISK]` | Storage, partitioning, BitLocker, recovery |
| `[SOP]` | Standard operating procedures / runbooks |
| `[ASSESS]` | Assessing and inheriting an existing network |
| `[DECOM]` | Decommissioning |
| `[ERR]` | Error → cause → fix index |
| `[SEC]` | Security, incident response, least privilege |

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

Community module that mirrors nmap behaviour and returns pipeable objects.

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

#### 0.6 Credential handling

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

**⚠ Report this behaviour as version-dependent.** Microsoft has changed it repeatedly, and it may change again. If a method fails, do not assume the machine is broken — check the build number and try the media-based route. **Test on one machine before promising a deployment schedule.**

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

**GPT vs MBR:** use **GPT** for anything modern — required for disks over 2 TB and for UEFI boot. MBR only for legacy compatibility.

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

Client offboarding and tenant decommissioning are **billable MSP work**. It is also the only realistic opportunity to practise a forced domain controller removal and metadata cleanup, because in production that only happens during an outage.

### `[DECOM-00]` 🛑 The one rule that governs the whole sequence

> **Tear down from the top of the stack to the bottom.**
>
> Applications → policies → device identity → user identity → the sync bridge → the directory → the servers → **the billing, last.**

**Every layer depends on the one beneath it. Remove a lower layer first and the layer above becomes orphaned and unmanageable.**

The classic version of this mistake: **wiping the domain controller while Entra Connect is still syncing.** The cloud objects stay marked as on-premises-mastered, become read-only, and can no longer be deleted normally.

**Corollary: cancel the paid subscription absolutely last.** Cancelling deactivates your licenses, and you need a live Intune license to administer Intune.

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

**Training exercise if you have two machines — do one of each so you see the behaviour firsthand:**
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

**Timing note:** a cancelled Azure subscription can be **deleted** from the portal 7 days after cancellation (3 days for a free trial or pay-as-you-go). **You do not need to complete that deletion — cancellation stops billing immediately.** It only matters if you later want to delete the tenant entirely.

### `[DECOM-P10]` Phase 10 — On-premises teardown

**Order matters. Demote the secondary DC first, then the last one.**

**10.1 Remove supporting services**
```powershell
# If the DC runs DHCP, unauthorize it BEFORE demotion
Remove-DhcpServerInDC -DnsName "SITE-DC01.ad.contoso.com" -IpAddress 10.10.10.10
Get-DhcpServerInDC       # confirm it is gone
```

**10.2 Optional training exercise — forced removal and metadata cleanup**

**This is the highest-value item in the entire runbook and you will never get to practise it in production.** Skip to 10.3 for the clean path only.

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
- [ ] **Leave Microsoft Entra ID Free alone.** It is automatically added, costs nothing, and cannot be cancelled.

**Final financial verification:**
- [ ] **Check the actual card statement in about 45 days.** Date cancelled ______ · Statement verified clear on ______

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

## CHANGELOG

| Version | Date | Changes |
|---|---|---|
| 1.0 | 2026-08-19 | Initial consolidation. Sources: hybrid network build playbook, decommission runbook, MSP technician reference, PowerShell/AD cheat sheet, Entra Connect troubleshooting guide, homelab networking reference, DHCP option guide, AD decommissioning inventory script, SSD reformat guide, AZ-900 study guide, Round 1 build transcript. All client-identifying material stripped. 16 factual corrections applied — see `[APX-C]`. |

<!--
ADD NEW ENTRIES BELOW THIS LINE using the template in §00.3.
Keep the tag prefix consistent with the section it belongs to.
-->

## 22 — PERSONAL ADDITIONS

*(Empty. This is where new material goes as you learn it. Use the `[TAG-NN]` format from §00.3 so it stays searchable, then move entries up into the relevant section when you have a few in the same area.)*

