### Variables

## Commands
# Pandoc
PANDOC=pandoc --from=markdown --to=latex --pdf-engine=xelatex

## Input files
# Folder the thesis sources are contained in
THESIS=thesis

# Space-separated list of files to use, in order to be included
THESIS_FILES_RAW=metadata.md abstract.md ack.md contents/intro.md contents/homotopy.md contents/hott.md contents/bm.md contents/agda.md

# This variable processes the previous one into a list usable by the bash commands
THESIS_FILES:=$(addprefix ${THESIS}/,${THESIS_FILES_RAW})

## Output files
# Folder to write the output to
OUT=out

# The final PDF file
OUT_THESIS=$(OUT)/thesis.pdf

# Intermediate markdown file with all the sources concatenated
OUT_CONCAT=$(OUT)/thesis.md

## Agda
# The folder containing the Agda source files
AGDA=agda

## Dependencies
# The dependencies folder for external Agda libraries
DEPS=deps

# List of Agda libraries repos
DEPS_REPOS=https://github.com/HoTT/HoTT-Agda "https://github.com/agda/agda-stdlib --branch v1.2"

# List of agda-lib files, relative to the dependencies folder
# Remember to always include the agda/src.agda-lib library!
DEPS_LIBFILES=../agda/src.agda-lib HoTT-Agda/hott-core.agda-lib agda-stdlib/standard-library.agda-lib

# Libraries file to be read by Agda
DEPS_LIBRARIES=$(DEPS)/libraries


### Tasks
# Which tasks are not files?
.PHONY: all clear agda clear-agda

# Build everything
all: thesis

## Thesis-related tasks
# Build the whole thesis
thesis: $(OUT_THESIS)

# Output folder
$(OUT):
	mkdir -p $(OUT)

# Concatenate all the source files inserting two new lines in between each for proper markdown
$(OUT_CONCAT): $(THESIS_FILES) $(OUT)
	for i in $(THESIS_FILES); do cat "$$i"; echo '\n\n'; done > $(OUT_CONCAT)

# Build the thesis PDF file
$(OUT_THESIS): $(OUT_CONCAT) $(OUT)
	$(PANDOC) --output=$(OUT_THESIS) $(OUT_CONCAT)

# Clean generated files. Should be the right inverse of `all`
clean:
	rm -rf $(OUT)

## Agda-related tasks
# Prepare the repo for running Agda. Only needs to be run once
agda: $(DEPS)

# The dependencies folder for Agda libraries
$(DEPS):
	mkdir -p $(DEPS)

	# Clone each dependency
	cd $(DEPS); for i in $(DEPS_REPOS); do git clone $$i; done

	# Include each library in the libraries file to be read by Agda
	for i in $(DEPS_LIBFILES); do \
		PWD=$( pwd ) echo $$PWD/$(DEPS)/$$i >> $(DEPS_LIBRARIES); \
	done

# Clean up workspace
clean-agda:
	rm -rf $(DEPS) $(AGDA)/**/*.agdai $(AGDA)/**/*.agda~