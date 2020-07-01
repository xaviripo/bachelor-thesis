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
definitions.md metadata.md\
contents/0-intro/0-intro.md\
contents/1-preliminaries/0-preliminaries.md\
contents/1-preliminaries/1-homotopy.md\
contents/1-preliminaries/2-hott.md\
contents/1-preliminaries/3-curry-howard.md\
contents/2-agda/0-agda.md\
contents/2-agda/1-setup.md\
contents/2-agda/2-language.md\
contents/2-agda/3-hott.md\
contents/3-circle/0-circle.md\
contents/3-circle/1-truncation.md\
contents/3-circle/2-covering-spaces.md\
contents/3-circle/3-fundamental-group.md\
contents/4-rp2/0-rp2.md\
contents/4-rp2/1-construction-classical.md\
contents/4-rp2/2-pushouts.md\
contents/4-rp2/3-construction-pushout.md\
contents/4-rp2/4-construction-hit.md\
contents/5-conclusions/0-conclusions.md\


# Thesis files to be included before the table of contents
THESIS_FILES_BEFORE_RAW=\
title.tex abstract.tex


# This variable processes the previous one into a list usable by the bash commands
THESIS_FILES:=$(addprefix ${THESIS}/,${THESIS_FILES_RAW})

THESIS_FILES_BEFORE:=$(addprefix ${THESIS}/,${THESIS_FILES_BEFORE_RAW})

## Output files
# Folder to write the output to
OUT=out

# The final PDF file
OUT_THESIS=$(OUT)/thesis.pdf

# Standalone TeX file
OUT_THESIS_TEX=$(OUT)/thesis.tex

# Intermediate markdown file with all the sources concatenated
OUT_CONCAT=$(OUT)/thesis.md

OUT_CONCAT_BEFORE=$(OUT)/before.md

# University logo
OUT_LOGO=$(OUT)/logo.png

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

$(OUT_LOGO): $(OUT)
	cp $(THESIS)/logo.png $(OUT)/logo.png

# Concatenate all the source files inserting two new lines in between each for proper markdown
$(OUT_CONCAT): $(THESIS_FILES) $(OUT)
	for i in $(THESIS_FILES); do cat "$$i"; echo '\n\n'; done > $(OUT_CONCAT)

$(OUT_CONCAT_BEFORE): $(THESIS_FILES_BEFORE) $(OUT)
	for i in $(THESIS_FILES_BEFORE); do cat "$$i"; echo '\n\n'; done > $(OUT_CONCAT_BEFORE)

# Build the thesis PDF file
$(OUT_THESIS): $(OUT_CONCAT) $(OUT_CONCAT_BEFORE) $(OUT) $(OUT_LOGO)
	$(PANDOC) --include-before-body=$(OUT_CONCAT_BEFORE) --output=$(OUT_THESIS) $(OUT_CONCAT)

# Build the thesis TeX file
$(OUT_THESIS_TEX): $(OUT_CONCAT) $(OUT_CONCAT_BEFORE) $(OUT) $(OUT_LOGO)
	$(PANDOC) --include-before-body=$(OUT_CONCAT_BEFORE) --output=$(OUT_THESIS_TEX) $(OUT_CONCAT)

# Clean generated files. Should be the right inverse of `all`
clean:
	rm -rf $(OUT)

# Clean up workspace
clean-agda:
	rm -rf $(AGDA)/**/*.agdai $(AGDA)/**/*.agda~ $(AGDA)/**/.deps


### Defense

# Pandoc commands
PANDOC_DEFENSE=pandoc\
--standalone\
--pdf-engine=xelatex\
--from=markdown\
--to=beamer\
--slide-level=2\


## Input files

# Folder the thesis sources are contained in
DEFENSE=defense

DEFENSE_FILES_RAW=\
metadata.md\
contents/0-intro.md\
contents/1-covering-spaces.md\
contents/2-circle.md\
contents/3-pushouts.md\
contents/4-rp2.md\
contents/5-agda.md\


DEFENSE_FILES:=$(addprefix ${DEFENSE}/,${DEFENSE_FILES_RAW})

DEFEENSE_IMAGES:=$(DEFENSE)/images

DEFENSE_IMAGES_OUT:=$(OUT)/images

## Output files

# The final PDF file
OUT_DEFENSE=$(OUT)/defense.pdf

# Intermediate markdown file with all the sources concatenated
OUT_CONCAT_DEFENSE=$(OUT)/defense.md

# Concatenate all the source files inserting two new lines in between each for proper markdown
$(OUT_CONCAT_DEFENSE): $(DEFENSE_FILES) $(DEFENSE_IMAGES_OUT) $(OUT)
	for i in $(DEFENSE_FILES); do cat "$$i"; echo '\n\n'; done > $(OUT_CONCAT_DEFENSE)

$(DEFENSE_IMAGES_OUT):
	mkdir -p $(DEFENSE_IMAGES_OUT)
	cp -r $(DEFEENSE_IMAGES)/* $(DEFENSE_IMAGES_OUT)

# Build the defense PDF file
$(OUT_DEFENSE): $(OUT_CONCAT_DEFENSE) $(OUT)
	$(PANDOC_DEFENSE) --output=$(OUT_DEFENSE) $(OUT_CONCAT_DEFENSE)


## Tasks

# Build the defense
defense: $(OUT_DEFENSE)
