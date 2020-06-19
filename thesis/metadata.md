---
# Document format
documentclass: report
toc: true
numbersections: true
geometry:
- left=30mm
- right=30mm
- top=30mm
- bottom=30mm
fontsize: 11pt
urlcolor: cyan

mainfont: TeX Gyre Pagella
mathfont: TeX Gyre Pagella Math
monofont: DejaVu Sans Mono # TeX Gyre Cursor is missing lots of math characters

# Add links to the refs
link-citations: true
reference-section-title: References

# pandoc-crossref
chapters: true
cref: true

header-includes: |
  \usepackage{amsthm}
  \usepackage{tikz}
  \usetikzlibrary{arrows}
  \AtBeginDocument{\let\maketitle\relax}
---