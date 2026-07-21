# Neovim Configuration

A personal, high-performance Neovim configuration built with built-in `vim.pack` package management, `blink.cmp` for completions, `telescope.nvim` for search, and Treesitter for syntax highlighting.

---

## Requirements

*   **neovim** (>= 0.12.0)
*   **ripgrep**
*   **fd**
*   **tmux** (for `nvim-tmux-navigation` and status pipeline)

---

## Installation Guides

### Arch 
Install the core, search, and language requirements:
```bash
sudo pacman -S neovim git base-devel ripgrep fd
```

### macOS
First, ensure you have Xcode Command Line Tools installed (`xcode-select --install`), then use Homebrew:
```bash
brew install neovim git ripgrep fd
```

---

## Installation & Setup

```bash
git clone https://github.com/paullotz/nvim-config ~/.config/nvim
nvim
:SyncParsers
```
