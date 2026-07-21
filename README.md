# Neovim Configuration

Personal Neovim configuration built on standard packages, blink.cmp, telescope, and Treesitter.

## Requirements

### Core Packages
* Neovim (>= 0.10.0)
* git
* gcc or clang, and make (for treesitter and blink.cmp builds)
* Nerd Font (recommended)
* ripgrep (for telescope search)
* fd (for directory search)

## Installation

```bash
git clone <your-repo-url> ~/.config/nvim
```

To sync Treesitter parsers:
```vim
:SyncParsers
```
