---
layout: default
title: "Hybrid Active Directory & Microsoft 365 Environment"
permalink: /projects/hybrid-ad-smb/
---

[← Back to home](/) · [All projects](/projects/)

# Hybrid Active Directory & Microsoft 365 Environment — SMB Simulation

**Bare-metal build of a small-business hybrid identity environment, executed twice to measure process improvement.**

Windows Server · Active Directory · Group Policy · Microsoft Entra ID · Entra Connect · Intune · Azure Arc

---

## At a glance

| | |
|---|---|
| **Objective** | Design, build, document, and decommission a production-shaped hybrid network for a simulated 5–50 seat business |
| **Approach** | Two full iterations — exploratory build, then a documented rebuild from a self-authored playbook |
| **Round 2 build time** | 5 hours 58 minutes, bare metal, single operator |
| **Hardware** | 1 × mini PC (domain controller / file server), 2 × laptops (clients), 1 × Hyper-V VM (second DC) |
| **Cloud** | Microsoft 365 Business Premium tenant with a registered custom domain |
| **Artifacts** | 48-page build & troubleshooting playbook, 12-phase decommission runbook, phase-by-phase build log |

---

## Why this project exists

I am changing careers into IT and had no production environment to learn in. Reading about Active Directory does not teach you what happens when Group Policy silently fails to apply, or why a laptop refuses to join a domain that responds perfectly to `ping`.

So I built the environment, broke it, diagnosed the breakage, wrote down what I learned, tore it down, and built it again — the second time from my own documentation rather than from tutorials.

The deliverable that matters is not the network. It is the **playbook**, and the measurable difference between the two builds.

---

## Scenario

A fictional small business, "HomeBiz," needs:

- Centralized user authentication and computer management
- Departmental file shares with least-privilege access (Sales and Accounting must not see each other's data)
- Automatically mapped drives and redirected user folders
- Single sign-on spanning on-premises and Microsoft 365
- Cloud-based device management and application deployment
- Directory redundancy and a tested backup

This is the shape of a large share of real small-business engagements: an on-premises domain that has grown into Microsoft 365, needing both halves to work as one system.

---

## Architecture

```
                        Internet
                            │
                 ┌──────────┴──────────┐
                 │  Firewall / Router  │   VLAN 40 · 192.168.40.0/24
                 │  DHCP opt 6 + 15    │   DNS → .10, .20
                 └──────────┬──────────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
   ┌────┴─────┐      ┌──────┴──────┐     ┌──────┴──────┐
   │ HL-DC01  │      │  HL-DC02    │     │  Clients    │
   │  .10     │◄────►│   .20       │     │  WS-ACCT01  │
   │ bare     │ repl │  Hyper-V VM │     │  WS-SALES01 │
   │ metal    │      │             │     │  Windows 11 │
   ├──────────┤      ├─────────────┤     └──────┬──────┘
   │ AD DS    │      │ AD DS       │            │
   │ DNS      │      │ DNS / GC    │      domain joined
   │ File svc │      └─────────────┘      hybrid joined
   │ Entra    │                                 │
   │ Connect  │                                 │
   └────┬─────┘                                 │
        │  Password Hash Sync · SCP · hybrid join│
        └──────────────────┬────────────────────┘
                           ▼
        ┌──────────────────────────────────────┐
        │  Microsoft Entra ID  ·  Microsoft 365│
        │  Intune MDM  ·  Conditional Access   │
        └──────────────────────────────────────┘
```

**Namespace design.** The public domain `homebiz.beer` was registered and verified in Entra ID; the internal AD domain is the subdomain `ad.homebiz.beer`. This avoids split-brain DNS entirely — the domain controller is authoritative only for the child zone and forwards everything else upstream — and it means user sign-in names and email addresses are the same string in both directories.

![Design planning](/assets/projects/hybrid-ad-smb/01-design-planning.png)
*Phase 0 — naming, addressing, and OU design fixed on paper before any hardware was touched.*

---

## Methodology

I ran this as two deliberate iterations against a crawl–walk–run model.

| | **Round 1 — Crawl** | **Round 2 — Walk** |
|---|---|---|
| Method | Tutorial-led, exploratory, out of order | Executed from my own playbook as a checklist |
| Goal | See the concepts work at least once | Test whether the documentation was actually usable |
| Output | A list of failures with root causes | A working build, plus revisions to the playbook |
| Duration | Several days | Under 6 hours |

Round 1's real product was a set of expensive mistakes. Each was traced to a root cause rather than a workaround, and each became a section of the playbook. Round 2 tested whether that playbook worked in the hands of the person who wrote it.

---

## Build sequence

The playbook's core principle: **everything that shapes a user's experience is built before the users exist and before any client is joined.** OU structure, security groups, share permissions, Group Policy, the UPN suffix, and MDM enrollment policy are all foundation. Built first, the first user to log in receives a finished environment.

| Phase | Work | Cumulative |
|---|---|---|
| 0 | Design: naming, addressing, OUs, groups, tenant, domain registration | — (untimed) |
| 1 | Server base build, static addressing, storage | 0:32 |
| 2 | Promote first DC · DNS forwarders, reverse zone, scavenging · external NTP | 1:47 |
| 3 | System State backup scheduled · AD Recycle Bin enabled | 1:53 |
| 4 | DHCP options 6 and 15 delivering DC as DNS | 1:55 |
| 5 | OU structure · `redircmp` / `redirusr` container redirection | 2:00 |
| 6 | Security groups — AGDLP model, both tiers | 2:05 |
| 7 | File shares · Access-Based Enumeration · NTFS by group | 2:22 |
| 8 | Five purpose-scoped GPOs, validated against a test user | 2:50 |
| 9 | Entra Connect · UPN suffix · SCP · hybrid join configuration | 3:24 |
| 10 | Scripted bulk user creation with generated credentials | 3:41 |
| 11 | Client build, domain join, hybrid Entra join | 4:48 |
| 12 | Intune policy and Microsoft 365 Apps deployment | 5:17 |
| 13 | Second domain controller promoted and replicating | 5:58 |

Phases 4, 5, and 6 took **twelve minutes combined** — the direct payoff of the untimed design phase.

---

## Selected technical work

### Identity and access model

Access is governed by AGDLP: user accounts go into **global role groups**, role groups nest into **domain local resource groups**, and permissions are assigned only to the resource group. No permission is ever assigned to an individual account.

```
sjohnson → GG-Accounting → GG-AllEmployees → DL-Company-Modify → NTFS on \Company
                         ↘ DL-Accounting-Modify → NTFS on \Departments\Accounting
```

The practical result: adding a user to one department group grants company-wide and department-specific access, and later revocation is a single group-membership change rather than an ACL edit.

![Security group nesting](/assets/projects/hybrid-ad-smb/12-security-groups-nesting.png)
*Global role groups nested into domain local resource groups.*

### File services — two layers of concealment

Share permissions were deliberately opened to `Authenticated Users` so that the share layer can never be the cause of an access problem, with all real control enforced through NTFS. Two independent mechanisms restrict visibility:

- **Item-level targeting** on Group Policy drive maps controls which *drive letters* appear per user
- **Access-Based Enumeration** on the share controls which *folders* are visible at all

Both are required. Item-level targeting alone still exposes every department folder to anyone browsing the UNC path directly.

![NTFS permissions](/assets/projects/hybrid-ad-smb/14-ntfs-permissions.png)
*Department folder ACL — administrative access, resource group at Modify, CREATOR OWNER scoped to child objects only.*

Verification included the negative case: an Accounting user could reach Company and Accounting data and could not see the Sales folder exists.

### Group Policy

Five purpose-named GPOs, each linked to the OU containing the objects it targets — User Configuration policies on the user OU, Computer Configuration policies on the workstation OU.

![Group Policy Objects](/assets/projects/hybrid-ad-smb/16-group-policy-objects.png)

| GPO | Link | Contents |
|---|---|---|
| Default Domain Policy | Domain root | Password and lockout policy only |
| Workstations – Baseline Security | `OU=Workstations` | Logon banner, guest disabled, wait-for-network at logon |
| Workstations – LAPS | `OU=Workstations` | Local admin password randomization with AD escrow |
| Workstations – MDM Auto-Enrollment | `OU=Workstations` | Automatic Intune enrollment via Entra credentials |
| Employees – Drive Maps | `OU=Employees` | Drive maps, action = Update, item-level targeting per group |
| Employees – Folder Redirection | `OU=Employees` | Documents, Desktop, Pictures to a dedicated server root |

### Hybrid identity

Entra Connect Sync with Password Hash Synchronization, Seamless SSO, and OU-scoped filtering. Connect Sync was selected over Entra Cloud Sync for one determining reason: **Cloud Sync does not synchronize device objects**, and hybrid Entra join requires the computer object to reach Entra ID before a device can register.

![Hybrid join success](/assets/projects/hybrid-ad-smb/23-hybrid-join-success.png)
*Client showing both domain join and hybrid Entra join complete.*

### Automation

User provisioning was scripted with per-user generated passwords, forced change at first logon, home directory creation, and automatic group placement — with existence checks and per-user error handling so a partial run can be safely repeated.

![Bulk user creation script](/assets/projects/hybrid-ad-smb/19-bulk-user-script.png)

---

## Results

| Dimension | Round 1 | Round 2 |
|---|---|---|
| Domain naming | `.local` — required rewriting every UPN later | Routable subdomain, correct from the start |
| Order of work | Discovery order, constant rework | Build order, no rework |
| OU structure | Collided with built-in containers | Single organizational OU with container redirection |
| Group Policy scoping | Linked to a groups OU — never applied | Linked where objects live — applied first attempt |
| Permissions | Two administrative lockouts | None; access verified positively and negatively |
| Drive mappings | `Replace` action froze both clients during policy refresh | `Update` action, no incidents |
| Device management | One device permanently limited by an ad-hoc enrollment shortcut | Corporate ownership via Group Policy enrollment |
| Privileged access | One global administrator used for everything | Break-glass account separated from daily admin; Azure RBAC scoped to Contributor |
| Backup / NTP / Recycle Bin | Never configured | Configured in Phases 2–3 |
| Elapsed | Several days | 5h 58m |

---

## Problems encountered and resolved

Three that were worth the time.

### Domain join failing against a reachable domain controller

**Symptom.** `An Active Directory Domain Controller for the domain could not be contacted.` DNS was correctly configured and the DC responded to `ping`.

**Diagnosis.** The client had been imaged in a different time zone and its clock was an hour off. Kerberos rejects authentication with more than five minutes of skew; the client, unable to complete authentication, reported it as an inability to locate a domain controller.

**Resolution.** Correct the time zone. Added a four-item pre-join verification block to the playbook — DNS server, SRV record resolution, clock skew, and port reachability — because `ping` tests none of the mechanisms a domain join actually uses.

### Hybrid Entra join failing after successful directory synchronization

**Symptom.** Users synchronized to Entra ID correctly. Clients reported `AzureAdJoined : NO` with `error_missing_device`.

**Diagnosis.** Reading the full diagnostic output revealed `Server operation: DeviceRenew` — the client was attempting to *renew* a registration using a locally cached device ID rather than create a new one. Two separate faults: the Service Connection Point had never been written to Active Directory, and the client held stale registration state from an earlier attempt.

The Service Connection Point step is genuinely easy to miss. "Configure device options" is not part of the linear Entra Connect installation wizard — it is a separate task selected on a subsequent launch. The installer completes, reports success, and synchronizes users flawlessly with hybrid join never configured.

**Resolution.** Configured the SCP, verified it by querying the object's `keywords` attribute directly, forced a **full** synchronization (a delta cycle will not move an object that has not changed), cleared client state with `dsregcmd /leave`, and re-registered.

![SCP verification](/assets/projects/hybrid-ad-smb/22-scp-verification.png)
*Verifying the Service Connection Point returns the expected tenant identifier and name.*

**Playbook change.** This is now a mandatory verification gate with a copy-paste command and its expected output, positioned before any client work begins.

### Intune enrollment failing silently

**Symptom.** Devices hybrid joined successfully but never appeared in Intune. No error surfaced in any console.

**Diagnosis.** Group-based licensing had been configured — the licensing group existed and the subscription SKU was assigned to it — but no members had been added. The group licensed nobody. Because the MDM auto-enrollment policy runs in the user's security context, an unlicensed user cannot enroll a device, and Intune reports nothing at all rather than a licensing error.

**Resolution.** Nested the synchronized `GG-AllEmployees` group into the cloud licensing group, so every future user inherits a license through the same chain that grants file access.

![License assignment](/assets/projects/hybrid-ad-smb/24-license-assignment.png)

---

## Artifacts produced

| Document | Contents |
|---|---|
| **Build & Troubleshooting Playbook** (48 pp.) | 15-phase build sequence, 23 root-cause findings, 8 standard operating procedures, an assessment methodology for inherited environments, command reference, and error-to-cause tables |
| **Decommission Runbook** (12 phases) | Full teardown in dependency order, covering the failure modes that make cloud objects unrecoverable if sequenced incorrectly |
| **Build log** | Phase-by-phase notes with timings, decisions, and errors, captured live |

The playbook is written to serve two purposes: build a greenfield environment, and assess an inherited one. The second half — discovery scripting, a prioritized findings table, and triage decision trees for the most common tickets — reflects that inheriting an undocumented environment is the more common professional situation.

---

## Skills demonstrated

**Windows Server** — AD DS, DNS (forwarders, reverse zones, scavenging), DHCP, file services, NTFS and share permissions, Access-Based Enumeration, Windows Server Backup, DC promotion and replication, FSMO roles, Windows Time Service

**Group Policy** — OU-based scoping, security filtering, Group Policy Preferences, item-level targeting, drive mapping, Folder Redirection, LAPS, MDM auto-enrollment, `gpresult` analysis

**Microsoft 365 / Entra ID** — tenant configuration, custom domain verification, Entra Connect Sync, password hash synchronization, Seamless SSO, hybrid Entra join, Service Connection Point, group-based licensing, dynamic device groups, break-glass account design

**Intune** — automatic enrollment, device ownership, application deployment, compliance and configuration policy

**Azure** — subscription and RBAC model, Azure Arc onboarding, separation of Entra directory roles from Azure resource roles

**PowerShell** — Active Directory module, SMB and DHCP cmdlets, scripted bulk provisioning with error handling, Microsoft Graph module

**Networking** — VLAN segmentation, static addressing, DHCP option delivery, DNS architecture and split-brain avoidance, IPv6 considerations for domain controllers

**Practice** — deliberate design ahead of execution, documented build sequences, verification gates, root-cause analysis, after-action review, and planned decommissioning

---

## Next iteration

Carried forward, in priority order:

1. Complete the redundancy wiring — cross-pointed DNS between domain controllers, DHCP failover, and a failover test using an account with no cached credentials on the test machine
2. Correct the DHCP scope so the pool does not overlap statically assigned infrastructure addresses
3. Test the System State restore; a backup is a hypothesis until it has been restored from
4. Intune compliance policy and Conditional Access, with the break-glass account excluded
5. Convert the playbook's inline scripts into a parameterized toolkit — configuration data separated from logic, CSV input, dry-run support
6. Rebuild from the playbook alone, unassisted and timed, as a test of retention rather than reference

---

## Screenshots

The full capture set, ordered by build phase. Click any image to open it full size.

<div class="gallery">
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/01-design-planning.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/01-design-planning.png" alt="Phase 0 — naming, addressing, and OU design" loading="lazy">
    </a>
    <figcaption>Phase 0 — naming, addressing, and OU design</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/02-dc-promotion-complete.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/02-dc-promotion-complete.png" alt="First domain controller promoted" loading="lazy">
    </a>
    <figcaption>First domain controller promoted</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/03-dns-resolution.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/03-dns-resolution.png" alt="DNS resolution verified" loading="lazy">
    </a>
    <figcaption>DNS resolution verified</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/04-ntp-configuration.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/04-ntp-configuration.png" alt="External NTP time source configured" loading="lazy">
    </a>
    <figcaption>External NTP time source configured</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/05-system-state-backup.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/05-system-state-backup.png" alt="System State backup scheduled" loading="lazy">
    </a>
    <figcaption>System State backup scheduled</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/06-backup-verification.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/06-backup-verification.png" alt="Backup verification" loading="lazy">
    </a>
    <figcaption>Backup verification</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/07-ad-recycle-bin.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/07-ad-recycle-bin.png" alt="AD Recycle Bin enabled" loading="lazy">
    </a>
    <figcaption>AD Recycle Bin enabled</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/08-dhcp-dns-delivery.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/08-dhcp-dns-delivery.png" alt="DHCP delivering DC as DNS server" loading="lazy">
    </a>
    <figcaption>DHCP delivering DC as DNS server</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/09-firewall-dhcp-options.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/09-firewall-dhcp-options.png" alt="Firewall DHCP options 6 and 15" loading="lazy">
    </a>
    <figcaption>Firewall DHCP options 6 and 15</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/10-ou-structure.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/10-ou-structure.png" alt="OU structure with container redirection" loading="lazy">
    </a>
    <figcaption>OU structure with container redirection</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/11-security-groups-global.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/11-security-groups-global.png" alt="Global role groups" loading="lazy">
    </a>
    <figcaption>Global role groups</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/12-security-groups-nesting.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/12-security-groups-nesting.png" alt="AGDLP group nesting" loading="lazy">
    </a>
    <figcaption>AGDLP group nesting</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/13-smb-share-troubleshooting.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/13-smb-share-troubleshooting.png" alt="SMB share troubleshooting" loading="lazy">
    </a>
    <figcaption>SMB share troubleshooting</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/14-ntfs-permissions.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/14-ntfs-permissions.png" alt="NTFS permissions by resource group" loading="lazy">
    </a>
    <figcaption>NTFS permissions by resource group</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/15-home-folder-acl.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/15-home-folder-acl.png" alt="Home folder ACL" loading="lazy">
    </a>
    <figcaption>Home folder ACL</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/16-group-policy-objects.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/16-group-policy-objects.png" alt="Group Policy Objects and links" loading="lazy">
    </a>
    <figcaption>Group Policy Objects and links</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/17-password-lockout-policy.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/17-password-lockout-policy.png" alt="Password and lockout policy" loading="lazy">
    </a>
    <figcaption>Password and lockout policy</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/18-entra-connect-configured.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/18-entra-connect-configured.png" alt="Entra Connect Sync configured" loading="lazy">
    </a>
    <figcaption>Entra Connect Sync configured</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/19-bulk-user-script.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/19-bulk-user-script.png" alt="Scripted bulk user provisioning" loading="lazy">
    </a>
    <figcaption>Scripted bulk user provisioning</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/20-users-created-onprem.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/20-users-created-onprem.png" alt="Users created on-premises" loading="lazy">
    </a>
    <figcaption>Users created on-premises</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/21-users-synced-entra.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/21-users-synced-entra.png" alt="Users synchronized to Entra ID" loading="lazy">
    </a>
    <figcaption>Users synchronized to Entra ID</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/22-scp-verification.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/22-scp-verification.png" alt="Service Connection Point verification" loading="lazy">
    </a>
    <figcaption>Service Connection Point verification</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/23-hybrid-join-success.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/23-hybrid-join-success.png" alt="Domain join + hybrid Entra join complete" loading="lazy">
    </a>
    <figcaption>Domain join + hybrid Entra join complete</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/24-license-assignment.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/24-license-assignment.png" alt="Group-based license assignment" loading="lazy">
    </a>
    <figcaption>Group-based license assignment</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/25-intune-enrollment.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/25-intune-enrollment.png" alt="Intune device enrollment" loading="lazy">
    </a>
    <figcaption>Intune device enrollment</figcaption>
  </figure>
  <figure class="shot">
    <a href="/assets/projects/hybrid-ad-smb/26-second-domain-controller.png" target="_blank" rel="noopener">
      <img src="/assets/projects/hybrid-ad-smb/26-second-domain-controller.png" alt="Second domain controller replicating" loading="lazy">
    </a>
    <figcaption>Second domain controller replicating</figcaption>
  </figure>
</div>


---

*This project was built on personally owned hardware in a home lab. No client or employer data was involved at any stage. All accounts, domains, and data are fictional.*

---

[← Back to home](/) · [All projects](/projects/)
