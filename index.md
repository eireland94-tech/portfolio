---
layout: default
title: Home
---

# Evan Ireland

![Evan Ireland](/assets/pfp2.jpg)

IT technician building hands-on skills through learning, homelabbing, and coding.
This site tracks my homelab projects, documentatrion, scripts, and certifications as I go along.

**Find me:** [LinkedIn](https://www.linkedin.com/in/evan-ireland94) · [GitHub](https://github.com/eireland94-tech) · [Projects](/projects/) · [Certifications](/certifications/) · [About](/about/)

---

## Featured project

### [Hybrid Active Directory & Microsoft 365 Environment](/projects/hybrid-ad-smb/)

A full hybrid identity environment for a simulated small business — built on
bare metal, torn down, and rebuilt a second time from my own playbook to test
whether the documentation held up. Round 2 took 5 hours 58 minutes with no
rework.

Windows Server · Active Directory · Group Policy · Entra ID · Entra Connect · Intune

[Read the case study →](/projects/hybrid-ad-smb/) · [See all projects →](/projects/)

---

## Recent posts

Check back Later! - Evan

<ul>
{% for post in site.posts limit:10 %}
  <li>
    <a href="{{ post.url }}">{{ post.title }}</a>
    <small> — {{ post.date | date: "%B %-d, %Y" }}</small>
  </li>
{% endfor %}
</ul>
