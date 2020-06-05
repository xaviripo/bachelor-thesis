### Variables

## Commands
# Pandoc
PANDOC=pandoc\
--standalone\
--filter=pandoc-crossref\
--from=markdown\
--to=latex\
--pdf-engine=xelatex\
--bibliography=thesis/citations.bib

## Input files
# Folder the thesis sources are contained in
THESIS=thesis

# Space-separated list of files to use, in order to be included
THESIS_FILES_RAW=\
definitions.md metadata.md abstract.md ack.md\
contents/1-intro/0-intro.md\
contents/1-intro/1-homotopy.md\
contents/1-intro/2-hott.md\
contents/1-intro/3-agda.md\
contents/2-hits/0-hits.md\
contents/2-hits/1-concept.md\
contents/2-hits/2-circle.md\
contents/3-pushouts/0-pushouts.md\
contents/3-pushouts/1-homotopy-pushouts.md\
contents/3-pushouts/2-svk.md\
contents/3-pushouts/3-bm.md\
contents/4-rpn/0-rpn.md\
contents/4-rpn/1-construction.md\
contents/4-rpn/2-piece.md\
contents/4-rpn/3-rp2.md

# This variable processes the previous one into a list usable by the bash commands
THESIS_FILES:=$(addprefix ${THESIS}/,${THESIS_FILES_RAW})

## Output files
# Folder to write the output to
OUT=out

# The final PDF file
OUT_THESIS=$(OUT)/thesis.pdf

# Standalone TeX file
OUT_THESIS_TEX=$(OUT)/thesis.tex

# Intermediate markdown file with all the sources concatenated
OUT_CONCAT=$(OUT)/thesis.md

## Agda
# The folder containing the Agda source files
AGDA=agda

### Tasks
# Which tasks are not files?
.PHONY: all clear clear-agda

# Build everything
all: thesis

## Thesis-related tasks
# Build the whole thesis
thesis: $(OUT_THESIS)

# Build the whole thesis, as a standalone TeX file
tex: $(OUT_THESIS_TEX)

# Output folder
$(OUT):
	mkdir -p $(OUT)

# Concatenate all the source files inserting two new lines in between each for proper markdown
$(OUT_CONCAT): $(THESIS_FILES) $(OUT)
	for i in $(THESIS_FILES); do cat "$$i"; echo '\n\n'; done > $(OUT_CONCAT)

# Build the thesis PDF file
$(OUT_THESIS): $(OUT_CONCAT) $(OUT)
	$(PANDOC) --output=$(OUT_THESIS) $(OUT_CONCAT)

# Build the thesis TeX file
$(OUT_THESIS_TEX): $(OUT_CONCAT) $(OUT)
	$(PANDOC) --output=$(OUT_THESIS_TEX) $(OUT_CONCAT)

# Clean generated files. Should be the right inverse of `all`
clean:
	rm -rf $(OUT)

# Clean up workspace
clean-agda:
	rm -rf $(AGDA)/**/*.agdai $(AGDA)/**/*.agda~ $(AGDA)/**/.deps