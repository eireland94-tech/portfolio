---
layout: default
title: Home
---

# Evan Ireland

<!-- TODO: swap this for a real photo. Create an /assets folder, drop the image
     in there, then reference it like:
     ![Evan Ireland](/assets/profile.jpg) -->

IT professional building hands-on skills through a home lab, including a
simulated small-business network. This site tracks certifications, homelab
projects, and write-ups as I go.

<!-- TODO: replace the LinkedIn URL below with your real profile link -->
**Find me:** [LinkedIn](https://www.linkedin.com/in/evan-ireland94) · [GitHub](https://github.com/eireland94-tech) · [Certifications](/certifications/) · [About](/about/)

## Recent posts

<ul>
{% for post in site.posts limit:10 %}
  <li>
    <a href="{{ post.url }}">{{ post.title }}</a>
    <small> — {{ post.date | date: "%B %-d, %Y" }}</small>
  </li>
{% endfor %}
</ul>
