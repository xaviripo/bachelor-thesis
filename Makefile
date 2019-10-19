### Variables
# Commands
PANDOC=pandoc --from=markdown --to=latex

# Files and folders
THESIS_PATH=thesis
OUT_PATH=out
OUT_THESIS=thesis.pdf


### Tasks
# Which tasks are not files?
.PHONY: all clear

# Build everything
all: thesis

# Build the whole thesis
thesis: $(OUT_PATH)/$(OUT_THESIS)

# Build the thesis PDF file
$(OUT_PATH)/$(OUT_THESIS): $(THESIS_PATH)/*.md
	mkdir -p $(OUT_PATH)
	$(PANDOC) --output=$(OUT_PATH)/$(OUT_THESIS) $^

# Clean generated files. Should be the right inverse of `all`
clean:
	rm -rf $(OUT_PATH)