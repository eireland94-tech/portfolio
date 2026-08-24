#!/usr/bin/env python3
"""
build-field-manual.py — turn the IT Field Manual export into a site page.

WHY THIS SCRIPT EXISTS
----------------------
The Field Manual is written as one big Markdown file so it stays searchable
with Ctrl+F in VS Code, on GitHub, and on your phone. Its table of contents
links to headings using GitHub's anchor rules (e.g. "#05--active-directory-
operations-ad").

Jekyll does NOT use GitHub's anchor rules. Its Markdown engine strips leading
digits, so "## 05 — ACTIVE DIRECTORY OPERATIONS" would become
"#active-directory-operations" — and every link in your contents table would
land on the wrong place or nowhere at all.

This script fixes that by writing an EXPLICIT anchor into every heading, using
GitHub's rules, as a plain HTML <a id="..."></a> tag. Plain HTML is understood
by every Markdown renderer there is, so the anchors behave identically on the
site, on GitHub, and in any editor preview.

(Kramdown has its own shorthand for this -- "## Heading {#id}" -- but if that
shorthand is ever not honoured it renders as literal "{#id}" text next to all
440-odd headings. Inline HTML has no such failure mode.)

It also copies the original, untouched file to assets/docs/ so visitors can
download the real thing rather than a modified copy.

HOW TO USE IT
-------------
When you update the manual, save the new export somewhere, then run:

    python tools/build-field-manual.py path\\to\\IT_Field_Manual_v1.3.md

from the repo root. It rewrites two files:

    _pages/field-manual.md          the page people read at /reference/field-manual/
    assets/docs/it-field-manual.md  the raw download

Then commit and push as normal. Nothing else needs touching.

("python" may need to be "py" or "python3" depending on how Ruby/Python got
installed on your machine. If none work, Python is not on your PATH.)
"""

import re
import sys
import shutil
import unicodedata
from pathlib import Path

# --------------------------------------------------------------------------
#  The front matter that gets stapled to the top of the generated page.
#  Edit the description here if the manual's scope changes.
# --------------------------------------------------------------------------
FRONT_MATTER = """---
layout: page
title: IT Field Manual
description: "A living operational reference: networking and security fundamentals, Windows, Active Directory, hybrid identity, Intune, Microsoft 365, Exchange Online, public DNS and mail flow, Purview, Copilot administration, and Azure. Every block is tagged — search the tag, not the prose."
permalink: /reference/field-manual/
image:
toc: true
toc_depth: 2
---

"""

# Dropped into the page just under the front matter, above the manual itself.
INTRO = """> **This page is the full manual, rendered.** It is long on purpose — it is
> built to be searched, not read front to back. Use **Ctrl+F** (**Cmd+F** on a
> Mac) and search the bracketed tag, for example `[GPO-TRIAGE]` or `[HYB-SCP]`.
> Prefer it offline? [Download the raw Markdown](/assets/docs/it-field-manual.md)
> — it opens in VS Code, Obsidian, or any text editor.

"""


def github_anchor(heading_text: str) -> str:
    """
    Reproduce GitHub's heading-anchor algorithm.

    GitHub: strip the Markdown formatting, lowercase it, delete anything that
    is not a letter, number, space, hyphen or underscore, then turn spaces
    into hyphens. Note that it does NOT strip leading digits — which is the
    whole reason this script exists.
    """
    t = heading_text
    t = re.sub(r"`([^`]*)`", r"\1", t)                 # `code` -> code
    t = re.sub(r"\*\*([^*]*)\*\*", r"\1", t)           # **bold** -> bold
    t = re.sub(r"\*([^*]*)\*", r"\1", t)               # *italic* -> italic
    t = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", t)     # [label](url) -> label
    t = t.strip().lower()
    t = "".join(
        c for c in t
        if c.isalnum() or c in " -_" or unicodedata.category(c).startswith("M")
    )
    return t.replace(" ", "-")


def transform(markdown: str) -> str:
    out = []
    in_fence = False          # are we inside a ``` code block right now?
    seen = {}                 # anchor -> how many times we have used it
    dropped_h1 = False

    for line in markdown.split("\n"):
        # Track fenced code blocks. Lines inside them are code, not headings —
        # a "# comment" in PowerShell must never be treated as a heading.
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            out.append(line)
            continue

        if in_fence:
            out.append(line)
            continue

        m = re.match(r"^(#{1,6})\s+(.*?)\s*$", line)
        if not m:
            out.append(line)
            continue

        hashes, text = m.group(1), m.group(2)

        # The page layout already prints the title, so drop the document's
        # own H1 rather than showing the title twice.
        if len(hashes) == 1 and not dropped_h1:
            dropped_h1 = True
            continue

        # Respect an anchor the author already wrote by hand.
        if re.search(r"\{#[^}]+\}\s*$", text) or text.lstrip().startswith("<a id="):
            out.append(line)
            continue

        anchor = github_anchor(text)
        if not anchor:
            out.append(line)
            continue

        # GitHub appends -1, -2 ... to repeated anchors. Match that.
        n = seen.get(anchor, 0)
        seen[anchor] = n + 1
        if n:
            anchor = f"{anchor}-{n}"

        # The anchor goes INSIDE the heading, so a link lands exactly on it
        # rather than on a stray empty paragraph above it.
        out.append(f'{hashes} <a id="{anchor}"></a>{text}')

    return "\n".join(out)


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__)
        print("ERROR: give me exactly one argument — the path to the manual.\n")
        return 2

    source = Path(sys.argv[1])
    if not source.is_file():
        print(f"ERROR: no such file: {source}")
        return 1

    repo = Path(__file__).resolve().parent.parent
    page = repo / "_pages" / "field-manual.md"
    raw = repo / "assets" / "docs" / "it-field-manual.md"

    markdown = source.read_text(encoding="utf-8")

    # 1. The raw download is the author's file, byte for byte. Do not modify it.
    raw.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, raw)

    # 2. The rendered page gets front matter, an intro, and explicit anchors.
    page.parent.mkdir(parents=True, exist_ok=True)
    page.write_text(FRONT_MATTER + INTRO + transform(markdown), encoding="utf-8")

    words = len(markdown.split())
    # Count real headings only — a "# comment" inside a code block is not one.
    heads, in_fence = 0, False
    for line in markdown.split("\n"):
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
        elif not in_fence and re.match(r"^#{1,6}\s", line):
            heads += 1
    print(f"  source     {source}")
    print(f"  page       {page.relative_to(repo)}")
    print(f"  download   {raw.relative_to(repo)}")
    print(f"  {words:,} words, ~{heads} headings")
    print("\nDone. Commit and push.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
