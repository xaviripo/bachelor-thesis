### Variables
# Commands
PANDOC=pandoc --from=markdown --to=latex

# Input files
THESIS_PATH=thesis
THESIS_FILES_RAW=metadata.md,abstract.md,ack.md,contents/intro.md
THESIS_FILES:=$(shell echo ${THESIS_PATH}/{${THESIS_FILES_RAW}})
THESIS_CONCAT=thesis.md

# Output files
OUT_PATH=out
OUT_THESIS=thesis.pdf


### Tasks
# Which tasks are not files?
.PHONY: all clear

# Build everything
all: thesis

# Build the whole thesis
thesis: $(OUT_PATH)/$(OUT_THESIS)

# Output folder
$(OUT_PATH):
	mkdir -p $(OUT_PATH)

# Concatenate all the source files appropriately
$(OUT_PATH)/$(THESIS_CONCAT): $(THESIS_FILES) $(OUT_PATH)
	for i in $(THESIS_FILES); do cat "$$i"; echo '\n\n'; done > $(OUT_PATH)/$(THESIS_CONCAT)

# Build the thesis PDF file
$(OUT_PATH)/$(OUT_THESIS): $(OUT_PATH)/$(THESIS_CONCAT) $(OUT_PATH)
	$(PANDOC) --output=$(OUT_PATH)/$(OUT_THESIS) $(OUT_PATH)/$(THESIS_CONCAT)

# Clean generated files. Should be the right inverse of `all`
clean:
	rm -rf $(OUT_PATH)