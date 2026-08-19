---
layout: default
title: "I built a hybrid AD environment, tore it down, and built it again"
date: 2026-08-19
---

[← Back to home](/)

# {{ page.title }}

*{{ page.date | date: "%B %-d, %Y" }}*

I have been building a simulated small-business network in my basement — a
hybrid Active Directory and Microsoft 365 environment of the kind a 5–50 seat
company actually runs. The full case study is now up:

**[Hybrid Active Directory & Microsoft 365 Environment — SMB Simulation →](/projects/hybrid-ad-smb/)**

The part I think matters most is that I built it twice.

Round 1 was tutorial-led and out of order, and it produced a long list of
failures: a `.local` domain name that forced me to rewrite every UPN later,
Group Policy linked to an OU that contained no computer objects so it never
applied, and two separate administrative lockouts from permissions I set
incorrectly. Each of those got traced to a root cause rather than worked
around, and each became a section of a playbook I wrote for myself.

Round 2 was the real test: rebuild the whole thing from that playbook, as a
checklist, and see whether the documentation actually worked. It did. Five
hours and fifty-eight minutes, bare metal to a hybrid-joined client with
Intune-deployed apps and a replicating second domain controller, with no
rework.

Three problems from the build are written up in full in the case study, with
symptom, diagnosis, and resolution:

- A domain join failing against a domain controller that responded fine to
  `ping` — it was Kerberos clock skew, not DNS.
- Hybrid Entra join failing after users synchronized perfectly — the Service
  Connection Point had never been written, because that step is not part of the
  linear Entra Connect wizard.
- Intune enrollment failing completely silently — a group-based licensing group
  that had been created and assigned a SKU but never given any members.

That last one produced no error in any console, which is the kind of thing you
only learn by hitting it.

[Read the full case study →](/projects/hybrid-ad-smb/)
