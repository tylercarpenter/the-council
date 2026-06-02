# Jedi Council — installer
#
# Copies the council (agents, /council command, skill) into a Claude Code config dir.
# Defaults to ~/.claude. Override with DEST=/path/to/project/.claude
#
#   make preview                    # show what would happen, change nothing
#   make install                    # install to ~/.claude
#   make install DEST=./.claude     # install into a project
#   make uninstall                  # remove installed council files
#   make check                      # verify the install
#
# Note: the override variable is DEST, not PATH — PATH is the shell's own
# executable-search variable and must never be reused here.

DEST ?= $(HOME)/.claude
SRC  := .claude

AGENTS  := grand-master jedi-archivist jedi-artificer jedi-sentinel jedi-diplomat jedi-watchman
AGENT_FILES := $(addsuffix .md,$(AGENTS))

.DEFAULT_GOAL := help

.PHONY: help preview install uninstall check

help:
	@echo "Jedi Council — make targets"
	@echo ""
	@echo "  make preview                 Show what install would copy (no changes)"
	@echo "  make install                 Install to ~/.claude (default)"
	@echo "  make install DEST=<dir>      Install into a specific .claude dir"
	@echo "  make uninstall               Remove installed council files"
	@echo "  make check                   Verify the install is complete"
	@echo ""
	@echo "  Current target DEST: $(DEST)"

preview:
	@echo "Would install into: $(DEST)"
	@echo ""
	@echo "  agents/        -> $(DEST)/agents/"
	@for f in $(AGENT_FILES); do echo "    $$f"; done
	@echo "  commands/      -> $(DEST)/commands/council.md"
	@echo "  skills/council -> $(DEST)/skills/council/SKILL.md"
	@echo ""
	@echo "Run 'make install' to apply, or 'make install DEST=<dir>' to retarget."

install:
	@echo "Installing Jedi Council into $(DEST) ..."
	@mkdir -p "$(DEST)/agents" "$(DEST)/commands" "$(DEST)/skills/council"
	@cp $(SRC)/agents/*.md "$(DEST)/agents/"
	@cp $(SRC)/commands/council.md "$(DEST)/commands/"
	@cp $(SRC)/skills/council/SKILL.md "$(DEST)/skills/council/"
	@echo "Done. The council is installed."
	@echo "Open Claude Code and run:  /council <your task>"

uninstall:
	@echo "Removing Jedi Council from $(DEST) ..."
	@for f in $(AGENT_FILES); do rm -f "$(DEST)/agents/$$f"; done
	@rm -f "$(DEST)/commands/council.md"
	@rm -rf "$(DEST)/skills/council"
	@echo "Done. Council files removed (your other agents/commands are untouched)."

check:
	@echo "Checking install at $(DEST) ..."
	@missing=0; \
	for f in $(AGENT_FILES); do \
		if [ ! -f "$(DEST)/agents/$$f" ]; then echo "  MISSING: agents/$$f"; missing=1; fi; \
	done; \
	if [ ! -f "$(DEST)/commands/council.md" ]; then echo "  MISSING: commands/council.md"; missing=1; fi; \
	if [ ! -f "$(DEST)/skills/council/SKILL.md" ]; then echo "  MISSING: skills/council/SKILL.md"; missing=1; fi; \
	if [ $$missing -eq 0 ]; then echo "  All council files present. Ready."; \
	else echo "  Install incomplete. Run 'make install'."; exit 1; fi
