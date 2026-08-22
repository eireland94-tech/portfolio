# HOW TO UPDATE evanireland.tech

Your own reference. This file lives in the repo but is **excluded from the
build**, so it never appears on the public site — it is listed under `exclude:`
in `_config.yml`.

Last rewritten: 19 August 2026, when the site moved from the Minimal theme to
the **Hexdump** theme.

---

## Table of contents

1. [What changed and why](#1-what-changed-and-why)
2. [Dependencies — what you need to install](#2-dependencies--what-you-need-to-install)
3. [The one-time GitHub setting you must change](#3-the-one-time-github-setting-you-must-change)
4. [How a change reaches the live site](#4-how-a-change-reaches-the-live-site)
5. [Where everything lives](#5-where-everything-lives)
6. [Add a blog post](#6-add-a-blog-post)
7. [Add a project case study](#7-add-a-project-case-study)
8. [Add a standalone page](#8-add-a-standalone-page)
9. [Update the Reference Library](#9-update-the-reference-library)
10. [Front matter reference](#10-front-matter-reference)
11. [Images](#11-images)
12. [Change your details, menu, or colours](#12-change-your-details-menu-or-colours)
13. [Preview the site on your PC before pushing](#13-preview-the-site-on-your-pc-before-pushing)
14. [When a build fails](#14-when-a-build-fails)
15. [Rolling back](#15-rolling-back)
16. [Things to be careful about](#16-things-to-be-careful-about)

---

## 1. What changed and why

The old site used `remote_theme: pages-themes/minimal`. GitHub downloaded that
theme at build time; the repo held almost nothing but your Markdown.

Hexdump is a **purchased theme**, so the theme's own source now lives in your
repo: `_layouts/`, `_includes/`, `css/`, `js/`. That means more files, and it
means you can change anything — but it also means theme bugs are now yours to
fix rather than the theme author's to push.

The other big change is **how the site gets built**.

| | Before | Now |
|---|---|---|
| Who builds it | GitHub's built-in Jekyll | A GitHub Actions workflow you own |
| Jekyll version | 3.9 (old) | 4.3 (current) |
| Sass compiler | LibSass (retired) | Dart Sass (current) |
| Config | Pages → "Deploy from a branch" | Pages → "GitHub Actions" |
| Build recipe | invisible | `.github/workflows/jekyll.yml` |

**Why this was not optional.** Hexdump's stylesheet opens with
`@use "sass:list";`. `@use` is modern Sass syntax that the retired compiler
GitHub's built-in builder still runs *cannot parse at all*. It is not a warning
— the CSS build fails outright and you get an unstyled site. Running our own
Actions workflow lets us pick Jekyll 4 and Dart Sass, which is what the theme
was written against.

**Terms worth knowing, since these are IT words you will meet again:**

- **CI/CD** — Continuous Integration / Continuous Deployment. Automation that
  builds and ships your code when you push it. `.github/workflows/jekyll.yml`
  is a small, real example of it.
- **Workflow** — one automation recipe. Yours has two *jobs* (`build`, then
  `deploy`), each made of *steps*.
- **Runner** — the throwaway Linux VM GitHub spins up to run your workflow. It
  is destroyed afterwards, which is why every run installs Ruby from scratch.
- **Artifact** — the output one job hands to the next. Here it is the finished
  `_site` folder.

---

## 2. Dependencies — what you need to install

This is the note from last time, now answered properly.

### For the live site: nothing.

Everything the site needs to build is installed on GitHub's runner by the
workflow, using the list in `Gemfile`. You can edit Markdown in VS Code, commit
in GitHub Desktop, and never install Ruby. **You are not blocked on anything.**

### For local preview: Ruby + Jekyll. Recommended, not required.

Local preview means running the site on your own machine at
`http://localhost:4000` and seeing changes the moment you save — before any of
it is public. With a theme this complex that is worth the one-time setup, and
it turns a mistake into a five-second fix instead of a failed public build.

**Install, on Windows, once:**

**Step 1 — install Ruby with the DevKit.**
Go to <https://rubyinstaller.org/downloads/> and download the version marked
**"Ruby+Devkit"** with **(x64)** — the one they recommend in bold. "Devkit"
matters: some Ruby libraries include C code that has to be *compiled* on your
machine, and the DevKit is the compiler toolchain that does it. Without it the
install fails partway with a wall of red text.

Run the installer, accept the defaults, and leave **"Add Ruby to PATH"** ticked.
PATH is the list of folders Windows searches when you type a command — being on
it is what lets you type `ruby` in any terminal instead of the full path to
`ruby.exe`.

**Step 2 — let it finish.**
At the end the installer opens a black window offering MSYS2 components. Press
**Enter** to accept the default (option 3, "MSYS2 and MINGW development
toolchain"). It takes a few minutes. When it finishes, press Enter again to
close.

**Step 3 — verify.**
Open a **new** PowerShell window (new, so it picks up the changed PATH) and run:

```powershell
ruby -v
```

You want something like `ruby 3.3.x`. If PowerShell says the term is not
recognised, PATH did not get set — re-run the installer and make sure that box
is ticked.

**Step 4 — install Bundler and this site's gems.**

```powershell
cd "C:\Users\evan\Documents\GitHub\portfolio"
gem install bundler
bundle install
```

Breaking that down:

- `cd` — **c**hange **d**irectory. Moves your shell into the repo folder. The
  quotes are needed because the path contains no spaces here, but they cost
  nothing and save you when a path does.
- `gem` — Ruby's package manager, the equivalent of `pip` for Python or `npm`
  for Node. `gem install bundler` fetches one package: Bundler.
- `bundle install` — Bundler reads `Gemfile`, works out every library and
  version needed, downloads them all, and writes the exact resolved set to
  `Gemfile.lock`. That lock file is why two machines building the same repo get
  identical results.

First run takes a few minutes. After that it is instant.

> **Note** — There is no `sudo` on Windows. The Linux equivalent of what you are doing here would be `sudo gem install bundler` — `sudo` = "**s**uper **u**ser **do**", run this one command as the administrator account, because installing software system-wide writes to folders a normal user cannot touch. On Windows the equivalent is right-clicking PowerShell and choosing "Run as administrator". You should **not** need to for any of the above; RubyInstaller puts gems in your user profile.

**Step 5 — commit `Gemfile.lock`.**
`bundle install` creates it. Commit it. It pins exact versions so GitHub's
runner builds with precisely what you tested locally, and it makes the Actions
build faster.

---

## 3. The one-time GitHub setting you must change

**Nothing publishes until you do this.** The workflow will run, go green on the
build job, and fail on the deploy job with a permissions error.

1. Go to <https://github.com/eireland94-tech/portfolio>
2. **Settings** (top row of the repo, not your account settings)
3. **Pages** in the left sidebar
4. Under **Build and deployment → Source**, change the dropdown from
   **"Deploy from a branch"** to **"GitHub Actions"**
5. That is it — there is no Save button, it applies immediately

Your custom domain and the "Enforce HTTPS" tick stay exactly as they are. The
`CNAME` file in the repo root keeps `evanireland.tech` pointed at the site;
**never delete it**.

---

## 4. How a change reaches the live site

```
   You edit a .md file in VS Code
                 |
                 v
   GitHub Desktop: write a summary, "Commit to main"
                 |
                 v
   GitHub Desktop: "Push origin"
                 |
                 v
   GitHub sees the push, reads .github/workflows/jekyll.yml
                 |
                 v
   Runner: install Ruby -> bundle install -> jekyll build
                 |
                 v
   Deploy job publishes the built site
                 |
                 v
   Live at evanireland.tech  (~1-3 minutes total)
```

To watch it: repo → **Actions** tab. Yellow dot = running. Green tick = live.
Red X = it failed and the live site is untouched — see section 13.

> **Important** — A failed build cannot break the live site. The deploy job only runs if the build job succeeds, so a broken commit leaves the previous version up.

---

## 5. Where everything lives

```
portfolio/
├── .github/workflows/jekyll.yml   The build recipe. Rarely touched.
├── _config.yml                    How Jekyll builds. Rarely touched.
├── _data/
│   └── settings.yml               YOUR DETAILS. Edited most often.
├── _pages/                        Standalone pages
│   ├── about.md                     -> /about/
│   ├── certifications.md            -> /certifications/
│   ├── reference.md                 -> /reference/                the library hub
│   ├── field-manual.md              -> /reference/field-manual/   GENERATED - see §9
│   ├── playbooks.md                 -> /reference/playbooks/
│   ├── scripts.md                   -> /reference/scripts/
│   ├── elements.md                  -> /elements/  (your formatting cheat sheet)
│   ├── posts.html                   -> /posts/     (auto-lists all posts)
│   ├── projects.html                -> /projects/  (auto-lists all projects)
│   └── tags.html                    -> /tags/      (auto-lists all tags)
├── _posts/                        Blog posts     -> /posts/<slug>/
├── _projects/                     Case studies   -> /projects/<slug>/
├── tools/
│   └── build-field-manual.py      Regenerates the Field Manual page. See §9.
├── _layouts/                      Page skeletons        } theme internals —
├── _includes/                     Reusable HTML blocks  } you can edit these,
├── css/                           Sass source           } but you rarely need
├── js/                            Terminal, search, etc } to
├── assets/                        YOUR images and documents
│   ├── pfp2.jpg
│   ├── battlestation.jpg
│   ├── projects/<slug>/*.png        project screenshots
│   └── docs/                        downloadable PDFs and the raw Field Manual
├── index.html                     Homepage — just picks which sections show
├── 404.html, feed.xml, search.json, favicon.ico
├── CNAME                          "evanireland.tech" — NEVER DELETE
├── Gemfile                        Library list for the build
├── .gitignore                     What git ignores
└── HOW-TO-UPDATE.md               This file (not published)
```

**Why the underscores?** Jekyll treats any file or folder starting with `_` as
source material rather than output. `_posts/my-post.md` is *input*; the built
`/posts/my-post/index.html` is *output*. Nothing starting with `_` is ever
copied to the site as-is.

---

## 6. Add a blog post

**1. Create the file** in `_posts/`. The name must be exactly:

```
YYYY-MM-DD-short-words-with-hyphens.md
```

Example: `_posts/2026-09-04-fixing-a-broken-gpo-link.md`

The date prefix is not decoration — Jekyll reads it. Everything after the date
becomes the URL, so that file lands at `/posts/fixing-a-broken-gpo-link/`.
Lowercase, hyphens not spaces, no apostrophes.

**2. Paste this at the very top:**

```yaml
---
title: "Fixing a broken GPO link"
description: "One sentence for search results and the card on the homepage. Aim for 120-160 characters."
date: 2026-09-04 14:30:00 -0600
image: '/assets/posts/broken-gpo/hero.png'
tags: [Group Policy, Troubleshooting]
toc: true
---
```

**3. Write the post below the closing `---`.** Plain Markdown. Open
`/elements/` on the live site to see every formatting option rendered.

**4. Commit and push.**

### Post gotchas, in the order they will bite you

- **`-0600` is your timezone offset** (Mountain, currently daylight time). A
  post dated in the *future* silently does not publish — no error, it just is
  not there. If a new post does not appear, check this first.
- **Titles with `:` or `&` must be in double quotes.** `title: AD: a primer`
  breaks the build because YAML reads the colon as a new key. `title: "AD: a
  primer"` is fine. Quoting every title is the easy habit.
- **`toc: true`** builds the clickable table of contents in the sidebar from
  your `##` headings. Worth it for anything long.
- **`tags`** are what drive `/tags/`, the "Related Posts" sidebar, and the
  filter buttons on `/posts/`. Reuse existing tag spellings exactly —
  `Group Policy` and `group policy` become two separate tags.
- **`featured: true`** is an optional extra line. Any post with it appears in
  the "Recommended" sidebar widget. With one or two posts, skip it.

---

## 7. Add a project case study

Same idea, different folder, and `labels` instead of `tags`.

**1. Create** `_projects/YYYY-MM-DD-project-slug.md`.

The slug is the URL. Your existing one is
`_projects/2026-08-19-hybrid-ad-smb.md` → `/projects/hybrid-ad-smb/`.

**2. Front matter:**

```yaml
---
title: "Ubuntu Server File and Print Services"
description: "One or two sentences. Lead with the outcome, not the tooling. This is what shows on the project card."
date: 2026-09-20 09:00:00 -0600
labels: [Ubuntu, Samba, CUPS, Bash]
image: '/assets/projects/ubuntu-file-print/01-overview.png'
toc: true
---
```

**3. Make the image folder:** `assets/projects/ubuntu-file-print/` and put the
screenshots in it. One folder per project keeps this navigable at twenty
projects.

**4. Write it. 5. Commit and push.**

The project appears automatically on `/projects/` and on the homepage. There is
**no index file to update** — the old theme needed you to hand-edit
`projects.md`; this one does not.

> **Tip** — After adding a project, bump `projects_completed:` in `_data/settings.yml`. It feeds the terminal's `about` command. Nothing breaks if you forget — it is just a number that will be wrong.

### `tags` vs `labels`

Two different systems, and they are not interchangeable:

| | `tags` | `labels` |
|---|---|---|
| Used by | posts | projects |
| Powers | `/tags/`, related posts, post filters | project card chips, `/projects/` filters |
| Written as | `tags: [Linux, CLI]` | `labels: [Rust, Systems]` |

Putting `tags` on a project does nothing. Putting `labels` on a post does
nothing. Neither errors — they just quietly do not work, which is worse.

---

## 8. Add a standalone page

For things that are not posts or projects — a resume page, a scripts index.

**1. Create** `_pages/scripts.md` (no date in the filename).

**2. Front matter:**

```yaml
---
layout: page
title: Scripts
description: PowerShell and Bash I actually use, with what each one is for.
permalink: /scripts/
image:
---
```

`permalink` is the URL, and the trailing slash matters — `/scripts/` not
`/scripts`.

**3. To put it in the top menu**, add it to `navigation:` in
`_data/settings.yml`:

```yaml
  - label: 'Scripts'
    url: '/scripts/'
```

Leave it out of `navigation` and the page still works — it is just unlisted.
That is exactly what `/elements/` is.

---

## 9. Update the Reference Library

`/reference/` is a hub page with three sub-pages under it. All four are ordinary
files in `_pages/`:

| File | URL | What it is |
|---|---|---|
| `_pages/reference.md` | `/reference/` | The hub. Four numbered areas, each linking onward. |
| `_pages/field-manual.md` | `/reference/field-manual/` | **Generated — do not hand-edit.** See below. |
| `_pages/playbooks.md` | `/reference/playbooks/` | Downloadable playbook PDFs, one block each. |
| `_pages/scripts.md` | `/reference/scripts/` | Script toolkit. Currently a stub. |

Downloadable documents live in `assets/docs/`.

### Updating the IT Field Manual

The manual is one 37,000-word Markdown file. You keep writing it wherever you
normally write it; the site takes a copy.

**Do not edit `_pages/field-manual.md` by hand.** It is generated, and your edits
would be wiped the next time you regenerate it. Edit your own master copy, then
run:

```powershell
cd "C:\Users\evan\Documents\GitHub\portfolio"
python tools\build-field-manual.py "C:\path\to\IT_Field_Manual_v1.1.md"
```

That rewrites two files, then you commit and push as normal:

- `_pages/field-manual.md` — the page people read
- `assets/docs/it-field-manual.md` — the raw download, an exact copy of yours

If `python` is not recognised, try `py` instead. If neither works, Python is not
on your PATH — the RubyInstaller steps in section 2 do not install Python.

**Why a script is needed at all.** Your contents table links to headings using
GitHub's anchor rules, so `## 05 — ACTIVE DIRECTORY OPERATIONS` becomes
`#05--active-directory-operations-ad`. Jekyll's Markdown engine uses different
rules and would strip the leading `05`, producing a different anchor — and all
24 of your internal links would break. The script writes an explicit
`<a id="..."></a>` into each of the 248 headings using GitHub's rules, so the
same file behaves identically in both places. The script is commented in full
if you want to read what it does.

> **Note** — After bumping the version, update the "Current version" row in `_pages/reference.md` and the `Version` row inside the manual itself. Nothing breaks if you forget; the page will just claim to be older than it is.

### Adding a playbook

1. Export the PDF. Give it a lowercase, hyphenated name and drop it in
   `assets/docs/` — for example `assets/docs/ubuntu-file-print-playbook-v1.pdf`.
2. Open `_pages/playbooks.md`, copy an existing block, and edit it. The download
   line carries page count, version, date, and file size:

   ```markdown
   **[Download the PDF →](/assets/docs/your-file.pdf)** · 24 pages · v1.0, October 2026 · 2.1 MB
   ```

3. Keep those four numbers honest. People decide whether to open a link based on
   how big it is, and being wrong about it is a small, avoidable credibility hit.

> **Warning** — Before publishing any document, re-read it for real hostnames, real IPs, real usernames, real domains, and real tenant names. Rule 1 of your own maintenance protocol — *strip the client* — applies to anything that goes on a public website. Once it is pushed to a public repo it is in the git history forever, even if you delete the file in a later commit.

Two more things worth checking on a PDF before it goes up:

- **Keep it under about 10 MB.** An oversized PDF is almost always uncompressed
  screenshots; re-export at a lower image quality.
- **Make sure the text is real text.** Open it and try Ctrl+F for a word you can
  see. If nothing is found, the text was exported as vector outlines or images —
  which means nobody can search it, copy from it, or read it with a screen
  reader. Re-export it properly. This is why the Decommissioning Runbook PDF is
  not on the site; that material lives in Field Manual §17 instead, where it
  actually is searchable.

### Adding a script

`_pages/scripts.md` has a commented block at the bottom with the exact steps.
Short version: put the `.ps1` in `assets/scripts/`, add a section with a
description, a download link, and the first 15–20 lines pasted in a
```` ```powershell ```` block so people can see its shape without downloading it.

Delete the "This section is being built" note at the top of that page once there
is at least one real script on it.

---

## 10. Front matter reference

"Front matter" is the block between the two `---` lines at the top of a file.
It is YAML, and it is settings, not content.

| Key | Where | What it does |
|---|---|---|
| `title` | all | Page heading, browser tab, link text. Quote it if it has `:` or `&`. |
| `description` | all | One-line summary: search results, social previews, cards. |
| `date` | posts, projects | Sort order and the printed date. Future = does not publish. |
| `image` | all | Header image, plus the card thumbnail and social preview. |
| `image_caption` | all | Caption under the header image. Markdown allowed. |
| `tags` | posts | `[A, B]`. Drives /tags/, related posts, filters. |
| `labels` | projects | `[A, B]`. Drives project chips and filters. |
| `toc` | posts, projects, pages | `true` builds the sidebar table of contents. |
| `featured` | posts | `true` puts it in the "Recommended" widget. |
| `permalink` | pages | The URL. Keep the trailing slash. |
| `video_embed` | posts, projects | An embed URL, shown *instead of* `image`. |
| `layout` | any | Usually unnecessary — `_config.yml` sets it by folder. |

---

## 11. Images

**Where they go:** `assets/`. Project screenshots in
`assets/projects/<project-slug>/`.

**Paths must start with `/`:**

```markdown
GOOD   ![Alt text](/assets/projects/my-project/01.png)
BAD    ![Alt text](assets/projects/my-project/01.png)
```

A relative path works in local preview and breaks on the live site — because
`/projects/my-project/` is a different depth than the page you tested it on.
This is the single most common way to ship a broken page.

**Filenames are case-sensitive on GitHub and not on Windows.** `Screenshot.PNG`
and `screenshot.png` are the same file to your PC and two different files to
GitHub's Linux servers. Keep everything lowercase and you never think about it
again.

**A single image with a caption** — the italic line goes immediately after:

```markdown
![Domain controller promoted](/assets/projects/hybrid-ad-smb/02-dc-promotion-complete.png)
*Server Manager confirming the AD DS role installed*
```

**A gallery** with click-to-enlarge:

```liquid
<div class="gallery-box">
  <div class="gallery gallery-columns-3">
    {% include img.html src="/assets/projects/SLUG/01.png" alt="What it shows" caption="Short caption" %}
    {% include img.html src="/assets/projects/SLUG/02.png" alt="What it shows" caption="Short caption" %}
  </div>
  <em>Optional caption for the whole gallery</em>
</div>
```

`gallery-columns-1` through `-4` control how many across.

**`alt` is not optional.** It is what a screen reader announces and what shows
if the image fails to load. Describe what the image *shows*, not that it is a
screenshot.

**Size them before committing.** A 3 MB PNG makes the page slow on a phone.
Aim under 500 KB. Windows Photos → Resize, or Paint → Resize, is enough.

---

## 12. Change your details, menu, or colours

Almost everything is in **`_data/settings.yml`**, and that file is commented
line by line. The highlights:

| Want to change | Key in `_data/settings.yml` |
|---|---|
| Name in the header / footer | `title` |
| Top menu items | `navigation` |
| Default colour scheme | `theme.default` — `azure`, `dracula`, `matrix`, `nord`, `gruvbox`, `mono` |
| Hide the colour-dot switcher | `theme.theme_switcher: false` |
| Terminal prompt (`evan@evanireland`) | `author.username`, `author.hostname` |
| Job title, email, bio | `author.role`, `author.email`, `author.bio` |
| Availability badge | `author.status` — `available`, `busy`, `open_to_offers` |
| Skill bars | `author.skills` |
| Big text on the homepage | `hero.title`, `hero.description` |
| Homepage About text | `about.description` |
| Homepage photo slider | `about_images` |
| LinkedIn / GitHub links | `author.social` and `social_footer` |

**YAML rules that cause 90% of failed builds:**

1. **Spaces only, never tabs.** VS Code shows a tab as a wide gap; YAML rejects
   it outright.
2. **Indentation is meaning.** Two spaces deeper = "belongs to the thing above".
3. **A colon-space inside a value needs quotes.** `role: IT: the job` breaks.
   `role: "IT: the job"` is fine.
4. **`|` means "keep my line breaks".** Everything under it must stay indented
   consistently — `about.description` uses this.

> **Warning** — The site has a no-JavaScript quirk worth knowing: the default colour scheme is applied by a small script in `_includes/head.html`. A visitor with JavaScript disabled sees Matrix green rather than Dracula purple, because the stylesheet's `:root` block is Matrix. Everything is readable either way. Fixing it properly means editing `css/_0-settings/color-scheme.scss` so `:root` carries the Dracula values.

---

## 13. Preview the site on your PC before pushing

Once section 2 is done:

```powershell
cd "C:\Users\evan\Documents\GitHub\portfolio"
bundle exec jekyll serve --livereload
```

Then open <http://localhost:4000>.

- `bundle exec` — "run this command using exactly the library versions in
  `Gemfile.lock`". Without it you get whatever Ruby finds first, which may be a
  different version than GitHub uses.
- `jekyll serve` — build the site, then run a small web server on port 4000.
- `--livereload` — refresh the browser automatically when you save a file.

Stop it with **Ctrl+C**.

> **Important** — Editing `_config.yml` or `_data/settings.yml` requires a **restart** — Ctrl+C, then run the command again. Jekyll reads those two once at startup. Editing a Markdown file rebuilds automatically. Losing ten minutes to "my change isn't showing up" when the answer was "restart the server" is a rite of passage; skip it.

If preview matches what you want, commit and push with confidence.

---

## 14. When a build fails

**Symptom:** red X in the **Actions** tab. Live site unchanged.

**Read the error:**

1. Repo → **Actions**
2. Click the failed run (top of the list)
3. Click the **build** job
4. Click the red step to expand it
5. The real error is usually the **last 10 lines**, in red

**The ones you will actually hit:**

| Error text | What it means | Fix |
|---|---|---|
| `did not find expected key` / `mapping values are not allowed` | YAML broken — usually an unquoted colon in a title, or a tab | Quote the value; retype the indentation with spaces |
| `Invalid date` | Malformed `date:` in front matter | Use `YYYY-MM-DD HH:MM:SS -0600` |
| `Could not locate Gemfile` | `Gemfile` deleted or renamed | Restore it |
| `Liquid Exception ... Could not locate the included file` | An `{% include x.html %}` points at a file that is not in `_includes/` | Fix the name, or restore the file from the original theme folder |
| Post is missing, no error at all | The `date:` is in the future | Set it to a past time |
| Deploy job fails, build job green | Pages source is still "Deploy from a branch" | Section 3 |

**Nuclear option:** rebuild without changing anything — Actions → "Build and
deploy site" → **Run workflow**. Fixes the occasional transient failure.

---

## 15. Rolling back

**One bad commit, undo it:**
GitHub Desktop → **History** → right-click the commit → **Revert changes** →
push. This makes a *new* commit that undoes the old one. Nothing is erased,
which is the point.

**Whole theme change was a mistake:**
You have your pre-theme backup. Restore it over the repo folder, then commit
the result. The old site used `remote_theme` and the built-in builder, so you
would also switch **Settings → Pages → Source** back to **"Deploy from a
branch"** (main, `/root`).

**A single file:**
GitHub Desktop → History → find the commit that last had the good version →
right-click the file → **Revert changes in commit**.

> **Tip** — `_to_delete/` in the repo folder holds every file the theme change replaced — the old `index.md`, `about.md`, `certifications.md`, `projects.md`, `projects/hybrid-ad-smb.md`, and `assets/css/style.scss`. It is in `.gitignore`, so it never reaches GitHub. Delete the folder from File Explorer once you are happy.

---

## 16. Things to be careful about

**Do not delete `CNAME`.** One line, `evanireland.tech`. Delete it and the
custom domain detaches and the site reverts to `eireland94-tech.github.io`.

**The theme's source is now public.** Hexdump is a paid theme, and your repo is
public, so anyone can read `_layouts/`, `css/`, and `js/`. That is the normal
trade-off for hosting a paid theme on GitHub Pages for free, and it is what
most people do — but check the licence you bought before you distribute it
anywhere further. Related: the footer credits Artem Sheludko. Many theme
licences require keeping that. Check yours before removing it.

**Old post URLs changed.** The one existing post moved from
`/2026/08/19/hybrid-ad-smb-round-2.html` to `/posts/hybrid-ad-smb-round-2/`.
Your project URL `/projects/hybrid-ad-smb/` was **deliberately preserved** — if
you have that on a resume or LinkedIn, it still works.

**Your skill percentages are a claim.** They are self-assessed numbers on a
public page an interviewer may well read. I set them deliberately low against
what your case study actually demonstrates. Re-read them before every
interview and be ready to defend each one.

**Fonts and icons come from CDNs.** Google Fonts and Font Awesome load from
external servers. If icons ever render as empty boxes, that is a CDN or network
issue, not your site being broken.

**Do not commit `_site/`.** It is the build output and it is in `.gitignore`
already. If it ever shows up in GitHub Desktop's changed-files list, something
is wrong with `.gitignore`.

**Restoring a removed theme feature.** Testimonials, the newsletter signup, the
Formspree contact form, Disqus comments and Google Analytics were removed
rather than disabled. The originals are all in:

```
C:\Users\evan\Documents\Website\00. Theme\hexdump-jekyll-theme-v1.0\Hexdump
```

To bring one back you need its include from `_includes/`, its stylesheet from
`css/_3-modules/`, the `{% include ... %}` line in whichever layout used it,
the matching `{% include_relative ... %}` line in `css/main.scss`, and its
settings block in `_data/settings.yml`. Compare against the original files and
copy each piece across.
