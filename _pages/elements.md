---
layout: page
title: Formatting Cheat Sheet
description: Every piece of formatting this site supports, rendered live. This page exists so I can see what a thing looks like before I use it in a post.
permalink: /elements/
image:
# Working reference, not portfolio content. Kept reachable by URL but out of
# the sitemap and told not to index, so it does not surface in search results.
sitemap: false
noindex: true
---

This page is a working reference for me. It is not linked in the menu, but it is
public – anyone with the URL can read it. Every block below shows the rendered
result *and* the Markdown that produced it.

***

## Headings

Use `##` for the main sections of a post. `#` is reserved for the page title,
which the layout already prints for you – using `#` in your own text gives you
two page titles and confuses screen readers and search engines.

## H2 – a main section
### H3 – a subsection
#### H4 – rarely needed
##### H5
###### H6

```markdown
## H2 – a main section
### H3 – a subsection
```

***

## Lists

Numbered lists for steps that must happen in order:

1. Promote the server to a domain controller
2. Point DNS at itself
3. Verify SRV records registered
4. Take a system state backup before doing anything else

Bulleted lists for things with no order:

* Windows Server 2022
* Ubuntu Server 24.04 LTS
* pfSense firewall
* Entra Connect sync server

```markdown
1. First step
2. Second step

* A thing
* Another thing
```

***

## Tables

Tables need a blank line before them and a `|---|` separator row.

| Symptom | Wrong diagnosis | Actual cause |
|---|---|---|
| Domain join fails | DNS | Kerberos clock skew |
| Hybrid join fails | Sync error | Missing Service Connection Point |
| Intune enrollment silently fails | Network | Licensing group had no members |

```markdown
| Symptom | Wrong diagnosis | Actual cause |
|---|---|---|
| Domain join fails | DNS | Kerberos clock skew |
```

If a table is too wide for the page, wrap it so it scrolls sideways instead of
spilling off the edge:

```html
<div class="table-container">
  ... your table here ...
</div>
```

***

## Quotes

> Round 2 was the real test: rebuild the whole thing from that playbook, as a
> checklist, and see whether the documentation actually worked.

```markdown
> Your quote goes here.
```

***

## Callouts

These are the colored attention boxes. The syntax is unusual – `{: .note }` on
its own line, then the text on the line directly below it, with **no blank line
between them**. A blank line breaks it.

{: .note }
Useful information the reader should know even when skimming.

{: .tip }
Helpful advice for doing something better or faster.

{: .important }
Key information the reader needs to achieve their goal.

{: .warning }
Urgent information needed to avoid a problem.

{: .caution }
A risk or a negative outcome of a particular action.

```markdown
{: .warning }
Do not run this against a production domain controller.
```

***

## Code

Inline code – like `Get-ADUser` or `C:\Windows\System32` – uses single
backticks. Use it for anything the reader might type or any literal path.

For blocks, use three backticks and name the language so it gets colored
correctly. Supported names you are likely to want: `powershell`, `bash`,
`cmd`, `yaml`, `json`, `html`, `css`, `js`, `python`, `sql`, `text`.

```powershell
# Bulk-create users from a CSV, one OU per department
Import-Csv .\new-hires.csv | ForEach-Object {
    New-ADUser -Name              $_.Name `
               -SamAccountName    $_.SamAccountName `
               -UserPrincipalName "$($_.SamAccountName)@evanireland.tech" `
               -Path              "OU=$($_.Department),OU=Users,DC=corp,DC=local" `
               -AccountPassword   (ConvertTo-SecureString $_.Password -AsPlainText -Force) `
               -Enabled           $true
}
```

```bash
# Check that the DC is answering on the ports that actually matter
for port in 53 88 389 445 636; do
  nc -zv dc01.corp.local $port
done
```

Every code block gets a copy button automatically. You do not have to add one.

***

## Images

A single image with a caption. The line in `*italics*` directly underneath
becomes the caption:

![Domain controller promotion completed successfully](/assets/projects/hybrid-ad-smb/02-dc-promotion-complete.png)
*Server Manager confirming the AD DS role installed and the server promoted*

```markdown
![Alt text describing the image](/assets/projects/my-project/screenshot.png)
*The caption goes here, in italics, on the line straight after*
```

{: .important }
Image paths must start with a forward slash – `/assets/...` not `assets/...`. A relative path works in local preview and breaks on the live site, which is the single easiest way to ship a broken page.

### Galleries

A grid of images, any of which opens full-screen when clicked. Change
`gallery-columns-2` to `-1`, `-3` or `-4` for a different number across.

<div class="gallery-box">
  <div class="gallery gallery-columns-2">
    {% include img.html src="/assets/projects/hybrid-ad-smb/10-ou-structure.png" alt="Organizational unit structure in Active Directory Users and Computers" caption="OU structure" %}
    {% include img.html src="/assets/projects/hybrid-ad-smb/16-group-policy-objects.png" alt="Group Policy Management console showing linked GPOs" caption="Group Policy objects" %}
    {% include img.html src="/assets/projects/hybrid-ad-smb/21-users-synced-entra.png" alt="Users synchronized into Entra ID" caption="Users synced to Entra ID" %}
    {% include img.html src="/assets/projects/hybrid-ad-smb/25-intune-enrollment.png" alt="Device enrolled in Microsoft Intune" caption="Intune enrollment" %}
  </div>
  <em>Hybrid AD build – selected screenshots</em>
</div>

{% raw %}
```liquid
<div class="gallery-box">
  <div class="gallery gallery-columns-2">
    {% include img.html src="/assets/projects/SLUG/01.png" alt="Describe it" caption="Short caption" %}
    {% include img.html src="/assets/projects/SLUG/02.png" alt="Describe it" caption="Short caption" %}
  </div>
  <em>Optional caption for the whole gallery</em>
</div>
```
{% endraw %}

***

## Video embeds

Paste the `src` from the platform's own "Embed" option – not the address bar URL.

```html
<p><iframe src="https://www.youtube.com/embed/VIDEO_ID" loading="lazy" frameborder="0" allowfullscreen></iframe></p>
```

***

## Horizontal rule

Three asterisks on their own line, with a blank line above and below, draws a
divider – like every one on this page.

```markdown
***
```
