# Neovim Configuration

A personal, high-performance Neovim configuration built with built-in `vim.pack` package management, `blink.cmp` for completions, `telescope.nvim` for search, and Treesitter for syntax highlighting.

---

## 🛠️ System Requirements

### 1. Core Dependencies (Required)
You must install these before starting Neovim:

*   **Neovim** (>= 0.10.0 recommended)
*   **Git** (for downloading plugins)
*   **C Compiler & Make** (`gcc` or `clang` / `make`) — required to compile Treesitter parsers and search engines.
*   **Nerd Font** (highly recommended, e.g., JetBrainsMono Nerd Font) — since icons and UI elements depend on it.

### 2. Search & Directory Dependencies (Highly Recommended)
Required for Telescope search and directory-restricted grep:
*   **ripgrep** (`rg`)
*   **fd** (`fd`)

### 3. Workflow Specific (Optional)
*   **tmux** (for `nvim-tmux-navigation` and status pipeline)
*   **latexmk** & **zathura** (for `vimtex` LaTeX compiling & previewing)

---

## 📦 OS Installation Guides

### Arch Linux
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

## 🚀 Installation & Setup

Clone this repository directly into the standard Neovim configuration directory:

```bash
# Clone the repository
git clone <your-repo-url> ~/.config/nvim

# Open Neovim
nvim
```

Upon launching Neovim for the first time, it will automatically download the configured plugins and Treesitter parsers.

### Syncing Treesitter Parsers
To sync and install missing Treesitter parsers, run inside Neovim:
```vim
:SyncParsers
```
