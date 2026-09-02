---
layout: page
title: Playbooks and Runbooks
description: Long-form procedures for work measured in hours – greenfield builds, inherited-network assessments, and controlled teardowns. Follow top to bottom.
permalink: /reference/playbooks/
image:
---

[← Back to the Reference Library](/reference/)

A playbook is not a tutorial: A tutorial teaches you a concept; a playbook gets
you through a job in the right order, with the reasoning attached and the traps
marked before you walk into them.

Each of these was written *after* doing the work, not before – which is why the
warnings are specific.

---

## Hybrid Microsoft Network – Build & Troubleshooting Playbook

**[Download the PDF →](/assets/docs/hybrid-network-playbook-v3.pdf)** · 48 pages · v3.0, August 2026 · 4.7 MB

The complete greenfield build of an on-premises Active Directory environment
joined to Microsoft Entra ID and Intune, in the order it should actually be
done rather than the order you learn it in.

Version 3.0 was rewritten after the second build of the environment. The
comparison between the two builds is the point of the document: Round 1 was
exploratory and out of order; Round 2 followed this playbook as a checklist and
finished in 5 hours 58 minutes with no rework.

**What is in it**

| Part | Contents |
|---|---|
| **0** | How to use it – the organizing principle, and how each phase is written |
| **1** | Project record – Round 2 architecture, what was delivered, Round 1 vs Round 2 |
| **2** | **23 root-cause findings and corrections** – every failure from Round 1, traced to cause |
| **3** | The build playbook – 15 phases, design through operations and handover |
| **4** | Standard operating procedures – onboarding, offboarding, shares, DC failure, lockouts |
| **5** | Assessing and troubleshooting an existing network – discovery, triage decision trees |
| **6** | Appendices – command reference, error index, port reference, checklists, rebuild drill |

**Why Part 2 is the part worth reading.** It is 23 things that went wrong, each
one traced to a root cause rather than worked around: a `.local` domain name
that forced every UPN to be rewritten later, Group Policy linked to an OU
holding no computer objects, a licensing group with a SKU assigned but no
members, Kerberos clock skew presenting as a DNS problem. Build guides tell you
the happy path. This one tells you where the floor gives way.

**Conventions.** Everything is written against placeholders – `ad.contoso.com`,
`SITE-DC01`, `10.10.10.0/24` – so the procedures transfer to a real environment
rather than describing one specific lab.

---

## Microsoft 365 Administration Playbook

**[Download the PDF →](/assets/docs/m365-administration-playbook-v1.pdf)** · 70 pages · v1.0, August 2026 · 3.1 MB

The other half of the job. Where the hybrid build playbook covers standing an
environment up, this one covers running it: mail flow, spam and quarantine,
shared mailboxes and delegation, groups, addressing, SharePoint sharing, and
data loss prevention.

It was written from a live tenant across eight tasks, and the findings are the
document – nine of them traced to root cause, including three separate cases
where a Microsoft system reported success while doing nothing useful.

**What is in it**

| Part | Contents |
|---|---|
| **Task 0** | Domain configuration for Exchange Online – MX, autodiscover, SPF, DKIM, DMARC, and a DNSSEC incident |
| **Tasks 1–2** | Message trace interpretation · spam filtering, quarantine, and quarantine policies |
| **Tasks 3–5** | Shared mailboxes and delegation · distribution vs mail-enabled security groups · aliases and primary SMTP |
| **Tasks 6–7** | SharePoint permission inheritance and external sharing · sensitivity labels and DLP in Purview |
| **Cross-cutting** | The three findings that were not product-specific, written as doctrine |
| **Appendices** | Corrections to prior understanding, deferred and unverified items, closing state |

**The finding worth the download.** A DLP policy left in simulation mode
produces the *complete appearance* of enforcement – the policy tip fires in
Outlook, message trace logs three DLP rule evaluations, the sender gets a
notification saying they shared a credit card number outside the organization –
and the card number still arrives at the external recipient in plain text. The
message trace is effectively identical to the enforcing run. Nothing on the
admin side contradicts you. **The only reliable verification is confirming what
the recipient actually received.**

**Conventions.** Body text is written against placeholders – `contoso.beer`,
`contoso.onmicrosoft.com`, `example.com` – so the procedures transfer. The
screenshots are from the lab as it actually ran.

**Companion case study:** [Microsoft 365 Administration →](/projects/m365-administration/)

---

## Proxmox VE Greenfield Cluster Build & Troubleshooting Guide

**[Download the PDF →](/assets/docs/proxmox-cluster-playbook-v1.pdf)** · 19 pages · v1.0, August 2026 · 0.4 MB

A complete procedure for standing up a multi-node Proxmox VE cluster from bare
hardware, including the decisions that shape it and the failures most likely to be
encountered. Written to be followed by someone who has not done it before.

Executed and verified on a live three-node build rather than compiled from
documentation - every command in it was run, and every failure in the
troubleshooting section was actually hit.

**What is in it**

| Part | Contents |
|---|---|
| **Pre-flight** | Network reachability, VLAN delivery, firmware settings, memory configuration, drive health baselines, installation media |
| **Installation** | First node, post-install hygiene (repositories, updates, virtualization verification), remaining nodes |
| **Cluster formation** | Timing, configuration replacement, joining, quorum behavior, migration capability, corosync, high availability |
| **Storage** | Root filesystem protection, storage type selection, node restriction, tiering |
| **Access & identity** | Administrative accounts, two-factor authentication, SSH, container security |
| **Backup infrastructure** | Placement, disk layout, least-privilege credentials, job scope, prune/GC/verification, restore testing |
| **Troubleshooting reference** | DNS interception, authentication vs. reachability failures, SSH key rejection, permission errors |
| **Checklists** | A verification checklist and a deferred-decision register with the condition that reverses each deferred item |

**The finding worth the download.** A recursive DNS resolver that returns SERVFAIL
for every query can still pass a DNSSEC validation test - because when every query
fails, a test expecting failure looks like a pass and proves nothing. The guide
walks through the two-command diagnosis that actually isolates the real cause: a
router transparently intercepting outbound DNS and starving the resolver's own
queries before they ever reach the root servers.

**Conventions.** Written as direct instruction to a practitioner executing the
build, not a narrative account. Rationale for every non-obvious decision sits next
to the step it governs rather than in a separate discussion.

**Companion case study:** [Three-Node Proxmox Cluster →](/projects/proxmox-cluster/)

---

## Decommissioning a hybrid environment

**Covered in the Field Manual – [§17 `[DECOM]`](/reference/field-manual/#17--decommissioning-a-hybrid-environment-decom)**

The full teardown sequence: Intune policy and apps, device identity, user
identity through the sync bridge, Entra Connect removal, tenant sync disable,
Entra purge, Azure decommission, on-premises demotion, and cancelling the
subscription last.

The governing rule is the whole trick – tear down from the top of the stack to
the bottom. Remove a lower layer first and the layer above it becomes orphaned
and unmanageable. The classic version is wiping a domain controller while Entra
Connect is still syncing: the cloud objects stay marked as on-premises-mastered,
turn read-only, and can no longer be deleted normally.

Client offboarding and tenant decommissioning are billable MSP work, and they
are work you cannot practice safely anywhere except a lab you own.

---

## In progress

Playbooks being written up as the work gets done:

- **Ubuntu Server file and print services** – Samba shares against AD
  authentication, CUPS, and the backup story
- **Inherited network assessment** – currently a section of the Field Manual
  (`[ASSESS-01]` through `[ASSESS-03]`); will become a standalone playbook once
  it has been run against a second environment

<!-- ===========================================================================
     HOW TO ADD A PLAYBOOK

     1. Put the PDF in  assets/docs/  using a lowercase, hyphenated filename:
            assets/docs/ubuntu-file-print-playbook-v1.pdf

     2. Copy one of the blocks above and edit it. The download line is:
            **[Download the PDF →](/assets/docs/YOUR-FILE.pdf)** · NN pages · vX.X · Month Year · N.N MB

     3. Keep the page count, version and file size honest - people decide
        whether to open a link based on how big it is.

     Keep PDFs under about 10 MB. If one is bigger, it is usually uncompressed
     screenshots; re-export at a lower image quality.
=========================================================================== -->
