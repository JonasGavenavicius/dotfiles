
# Unified make targets for your dotfiles bootstrap

install: ## Auto-detect and install
	@./install.sh

install-macos: ## Force macOS install
	@./install.sh macos

install-debian: ## Force Debian-based install
	@./install.sh debian

install-arch: ## Force Arch-based install
	@./install.sh arch

.PHONY: install install-macos install-debian install-arch

