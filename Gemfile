# =============================================================================
#  Gemfile — the list of Ruby libraries this site needs in order to build
# =============================================================================
#  Think of this like requirements.txt in Python or package.json in Node: it
#  names the tools, and Bundler (Ruby's package manager) installs them.
#
#  You do NOT need any of this installed on your PC for the live site to work.
#  GitHub installs these on its own build machine every time you push.
#  You only need them locally if you want to preview the site before pushing.
# =============================================================================

source "https://rubygems.org"

# The static site generator itself. "~> 4.3" means "4.3 or newer, but stay
# below 5.0" — patch and minor updates are allowed, a breaking major is not.
gem "jekyll", "~> 4.3"

# Generates /sitemap.xml automatically so search engines can crawl every page.
gem "jekyll-sitemap", "~> 1.4"

# Lets kramdown understand GitHub Flavored Markdown — this is what makes
# ```powershell fenced code blocks highlight correctly.
gem "kramdown-parser-gfm", "~> 1.1"

# Ruby 3 removed webrick from the standard library, and `jekyll serve` needs it
# to run the local preview web server. Without this line, `jekyll serve` fails
# on a modern Ruby with "cannot load such file -- webrick".
gem "webrick", "~> 1.8"

# Windows-only helpers. `tzinfo-data` supplies timezone information that Linux
# and macOS get from the operating system but Windows does not. `wdm` makes
# Jekyll's auto-rebuild-on-save actually work on Windows.
platforms :mingw, :x64_mingw, :mswin do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
  gem "wdm", "~> 0.1"
end
