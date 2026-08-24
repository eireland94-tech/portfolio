---
title: "Three times in two days, a system told me it worked when it hadn't"
description: "A wildcard DNS record, an allow-list entry, and a DLP policy in simulation mode. Different products, same failure: the diagnostic still returned an answer, and the answer was wrong."
date: 2026-08-23 18:00:00 -0600
image: '/assets/projects/m365-administration/57-plaintext-at-recipient.png'
tags: [Microsoft 365, Exchange Online, DNS, Purview, Troubleshooting]
toc: true
---

I spent two days last week doing the unglamorous half of Microsoft 365 —
mail flow, shared mailboxes, distribution lists, SharePoint sharing, and a
DLP policy. The full write-up is up now:

**[Microsoft 365 Administration — Mail Flow, Collaboration & Data Governance →](/projects/m365-administration/)**

The [last project](/projects/hybrid-ad-smb/) built a hybrid environment from
bare metal. It answered *how do you stand this up*. It did not answer *what do
you do on Tuesday*, and at a small business, Tuesday is almost entirely email.
Shared mailboxes, "where did my message go," "why is this in quarantine," "can
you give Sarah access to the sales inbox." I had zero hands-on with any of it,
so that is what I went after.

Nine root-cause findings came out of it. Three of them are the same finding
wearing different clothes, and that one is the reason I'm writing a post
instead of just linking the case study.

## The pattern

**A wildcard DNS record.** I ran an inventory script expecting five
`DNS name does not exist` answers for five missing records. I got five valid
answers instead. The registrar's default `*` parking CNAME was answering for
every subdomain that had no explicit record. Every "does this record exist?"
check came back yes. None of them existed.

**An allow-list entry.** I'd modified an anti-spam policy for a quarantine
test and then not reverted it, which contaminated the next task. So I added an
allowed-sender entry to stop the interference — which meant my subsequent "is
it reverted yet?" test would deliver successfully *whether or not the revert
had taken*. I had destroyed my own ability to tell the two states apart, using
a fix.

**A DLP policy in simulation mode.** This is the one that actually bothers me.
Outlook showed the policy tip before send. Message trace logged three DLP rule
evaluations. I got a notification saying I'd shared content containing a credit
card number outside the organisation. Everything a normal person checks said
the policy was working.

The card number arrived at the external recipient in plain text.

I flipped the policy to enforcement and ran the identical test half an hour
later. **The message trace was effectively identical.** Same events, same rule
evaluations, same policy tip, same user notification. The only difference in
the entire chain was at the far end: this time the recipient got an encrypted
`.rpmsg` wrapper instead of a readable card number.

## Why this is worth a post

An override doesn't just change behaviour. It changes what your tests
*report* — and it does it silently. The test still runs. It still returns a
result. The result still looks like an answer.

If I'd deployed that DLP policy for a client and walked away, I'd have told
them their data was protected. It wasn't. Nothing on the admin side would ever
have contradicted me.

Four rules I'm keeping:

1. **Remove overrides before testing, not after.** A revert verified while an
   override is still active is not verified.
2. **Verify at the far end.** DNS answering is not mail flowing. A policy tip
   is not enforcement. Check what the recipient actually received.
3. **When a result matches what you expected, ask what the test couldn't have
   told you.** Agreement is not confirmation.
4. **In an inherited environment, inventory the overrides before you trust any
   diagnostic.** Wildcard DNS records, allow lists, disabled policies,
   simulation-mode policies — all invisible until you go looking for them
   specifically.

## The other one I earned the hard way

Separately, and more embarrassingly: I burned about forty-five minutes waiting
for a DNS delegation to Microsoft that was never going to work, because
DNSSEC was enabled on the domain and Microsoft-hosted DNS doesn't support it.

The admin center had a banner saying exactly that. On screen. The whole time.

There are two more in the write-up of the same shape — a SharePoint share that
"never arrived" where the confirmation dialog had named the actual recipient,
and an unexplained `Drop` in a message trace whose detail line contained an
SMTP *success* code. In all three cases the answer was already rendered on the
screen I was looking at before I started theorising.

Read the banners. It's a cheaper habit than the alternative.

[Read the full case study →](/projects/m365-administration/)
