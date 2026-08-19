# How to update this site

This file is a note to yourself. It is safe to keep in the repo (GitHub Pages
ignores it because it has no front matter and is not linked from anywhere), or
you can delete it once the process is second nature.

---

## How the site is put together

| File / folder | What it does |
|---|---|
| `_config.yml` | Site-wide settings: title, description, which theme to use |
| `CNAME` | Contains `evanireland.tech`. **Never delete or edit this** — it is what binds your custom domain to the site |
| `index.md` | The homepage |
| `about.md` | The About page → `/about/` |
| `certifications.md` | The Certifications page → `/certifications/` |
| `projects.md` | The Projects index → `/projects/` |
| `projects/` | One file per project case study |
| `_posts/` | Blog posts. Filenames **must** be `YYYY-MM-DD-title.md` |
| `assets/` | Images. Screenshots live in `assets/projects/<project-slug>/` |
| `assets/css/style.scss` | Custom styling layered on top of the theme |
| `.gitignore` | Tells git to ignore local build junk |

**The rule that trips people up:** anything in a folder starting with an
underscore (`_posts`, `_config.yml`) is special to Jekyll. Everything else is
either a page or a static file.

---

## Front matter

Every page and post starts with a block fenced by three dashes. This is called
*front matter*, and Jekyll requires it. A file without it will not be styled —
it will render as raw text on a white page.

```yaml
---
layout: default
title: "Your Page Title"
permalink: /your-url/
---
```

- `layout: default` — always this. It is the theme's page template.
- `title:` — shown in the browser tab. **Wrap it in quotes** if it contains a
  colon, an ampersand, or a dash at the start, or the build will fail.
- `permalink:` — the URL. Pages need it; posts do not (posts get their URL from
  the filename's date).

---

## Adding a new blog post

1. Create a file in `_posts/` named `YYYY-MM-DD-short-title.md` — for example
   `2026-09-14-pfsense-vlan-notes.md`. **The date in the filename is mandatory**
   and must be in that exact format, or Jekyll will silently ignore the file.
2. Give it front matter:

```yaml
---
layout: default
title: "Notes on VLAN segmentation in pfSense"
date: 2026-09-14
---

[← Back to home](/)

# {{ page.title }}

*{{ page.date | date: "%B %-d, %Y" }}*

Write the post here in markdown.
```

3. Commit and push. It appears on the homepage under "Recent posts"
   automatically — you do not edit the homepage to add it.

> **A post dated in the future will not appear.** If a post seems to vanish,
> check the date in the filename first.

---

## Adding a new project case study

This is the pattern used for the hybrid AD project. Copy it.

**Step 1 — put the screenshots somewhere sensible.**

Create `assets/projects/<project-slug>/` and drop the images in. Use a short
lowercase slug with hyphens, e.g. `assets/projects/pfsense-firewall/`.

**Step 2 — create the case study page.**

Create `projects/<project-slug>.md`:

```yaml
---
layout: default
title: "Your Project Title"
permalink: /projects/your-project-slug/
---

[← Back to home](/) · [All projects](/projects/)

# Your Project Title

**One bold sentence stating what you built and why it is interesting.**

Tech · Stack · Here

---

## At a glance

| | |
|---|---|
| **Objective** | ... |
| **Approach** | ... |
| **Hardware** | ... |

...the rest of your write-up...
```

**Step 3 — reference images with absolute paths.**

```markdown
![Description of the screenshot](/assets/projects/your-project-slug/01-thing.png)
*Caption line in italics directly underneath.*
```

> **This is the single most common mistake.** The path must start with a `/`.
> A relative path like `![x](images/01-thing.png)` works when you preview the
> file on your computer and then breaks on the live site, because the browser
> resolves it against the page URL instead of the site root.

**Step 4 — list it on the Projects page.**

Open `projects.md`. There is a commented-out template block at the bottom.
Copy it, uncomment it, fill it in.

**Step 5 — optionally feature it on the homepage.**

Open `index.md` and edit the "Featured project" section.

---

## The screenshot gallery

The gallery at the bottom of the hybrid AD case study is plain HTML, because
markdown cannot express a grid. To reuse it, copy the block and repeat one
`<figure>` per image:

```html
<div class="gallery">
  <figure class="shot">
    <a href="/assets/projects/SLUG/01-thing.png" target="_blank" rel="noopener">
      <img src="/assets/projects/SLUG/01-thing.png" alt="Short description" loading="lazy">
    </a>
    <figcaption>Short description</figcaption>
  </figure>
  <!-- repeat one <figure> per screenshot -->
</div>
```

The grid layout, hover effect, and captions are styled in
`assets/css/style.scss` under the `.gallery` rules.

---

## Publishing a change

1. Edit files in your local repo folder.
2. Open GitHub Desktop. Review the changed files listed on the left.
3. Write a short commit message describing the change — "Add pfSense project"
   is fine. Vague messages like "update" are a habit worth not forming.
4. **Commit to main**, then **Push origin**.
5. Wait 1–2 minutes and reload the site.

---

## When something does not show up

Work through these in order:

1. **Check the build actually succeeded.** Go to your repo on GitHub → the
   **Actions** tab. A green check means the site built and deployed. A red X
   means the build failed and *the live site still shows the previous version*.
   Click the failed run to read the error.
2. **If the build failed, suspect the front matter first.** An unquoted title
   containing a `:` is the most common cause. Bad indentation in `_config.yml`
   is second.
3. **If the build succeeded but a post is missing** — check the filename date
   format and that the date is not in the future.
4. **If the build succeeded but an image is broken** — check the path starts
   with `/`, and check the filename case matches exactly. GitHub's servers are
   case-sensitive; Windows is not, so `Photo.PNG` referenced as `photo.png`
   works on your machine and 404s on the live site.
5. **If the page looks unstyled** (black text, white background, no sidebar) —
   the front matter block is missing or malformed.

---

## Previewing locally (optional, later)

You do not need this — pushing to GitHub and waiting a minute works fine. But
once you are tired of that loop, installing Ruby and Jekyll lets you run
`bundle exec jekyll serve` and preview at `http://localhost:4000` instantly.
Worth doing eventually; not worth doing now.
