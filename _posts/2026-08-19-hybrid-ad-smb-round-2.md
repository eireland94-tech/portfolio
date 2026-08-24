---
title: "I built a hybrid AD environment, tore it down, and built it again"
description: "Round 1 was tutorial-led and full of failures. Round 2 was a rebuild from my own playbook, timed, to find out whether the documentation actually worked."
date: 2026-08-19 12:00:00 -0600
image: '/assets/projects/hybrid-ad-smb/26-second-domain-controller.png'
tags: [Active Directory, Entra ID, Documentation]
toc: true
---

I have been building a simulated small-business network in my basement – a
hybrid Active Directory and Microsoft 365 environment of the kind a 5–50 seat
company actually runs. The full case study is up now:

**[Hybrid Active Directory & Microsoft 365 Environment – SMB Simulation →](/projects/hybrid-ad-smb/)**

The part I think matters most, and this is just my own read on it, is that I
built the whole thing twice.

Round 1 was tutorial-led and out of order, and what it produced wasn't a
network so much as a list of failures. A `.local` domain name that forced me to
rewrite every UPN later. Group Policy linked to an OU that held no computer
objects, so it never applied to anything. Two separate administrative lockouts
from permissions I set incorrectly. Every one of those got traced back to a
root cause instead of worked around, and every one became a section of a
playbook I wrote for myself.

Round 2 was the real test: rebuild the environment from that playbook, treat
the playbook as a checklist, and find out whether the documentation held up
under somebody using it. It held up. Five hours and fifty-eight minutes, bare
metal to a hybrid-joined client with Intune-deployed apps and a replicating
second domain controller, with no rework.

Three problems from the build are written up in full in the case study, with
symptom, diagnosis, and resolution:

- A domain join failing against a domain controller that answered `ping`
  without complaint – the cause was Kerberos clock skew, not DNS.
- Hybrid Entra join failing after the users had synchronized perfectly – the
  Service Connection Point had never been written, because that step sits
  outside the linear Entra Connect wizard.
- Intune enrollment failing completely silently – a group-based licensing group
  that had been created and assigned a SKU and then never given any members.

That last one threw no error and/or warning in any console, which is the sort
of thing you don't learn until you walk into it.

[Read the full case study →](/projects/hybrid-ad-smb/)
