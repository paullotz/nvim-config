require("vim._core.ui2").enable({})
vim.loader.enable()

vim.cmd [[set mouse=]]
vim.cmd [[set noswapfile]]
vim.cmd [[hi @lsp.type.number gui=italic]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.winborder = "rounded"
vim.opt.showtabline = 2
vim.opt.wrap = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "typst" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set("n", "<leader>dp", function()
      local clients = vim.lsp.get_clients({ name = "tinymist" })
      if #clients > 0 then
        clients[1]:exec_cmd({
          command = "tinymist.startDefaultPreview",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "Preview",
        })
      else
        vim.notify("Tinymist LSP is not running", vim.log.levels.WARN)
      end
    end, vim.tbl_extend("force", opts, { desc = "Typst: [D]ocument [P]review" }))
  end,
})

local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-q>', ":copen<CR>", { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<C-p>', ':e#<CR>', { desc = 'Go back to [p]revious file' })
map('n', '<leader>w', '<Cmd>update<CR>', { desc = 'Write changes to current file' })
map('n', '<leader>f', vim.lsp.buf.format)
map('n', '<leader>x', '<Cmd>quit<CR>', { desc = 'Close split window' })
map('n', '<leader>Q', '<Cmd>wqa<CR>', { desc = 'Write all and quit' })

local function reload_config()
  local config_dir = vim.fn.stdpath("config")
  local init_file = config_dir .. "/init.lua"
  dofile(init_file)
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end
map('n', '<leader>re', reload_config, { desc = 'Reload neovim config' })

map({ "n", "t" }, "<Leader>tn", "<Cmd>tabnew<CR>", { desc = "New tab" })
map({ "n", "t" }, "<Leader>tc", "<Cmd>tabclose<CR>", { desc = "Close tab" })
for i = 1, 8 do
  map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end

map({ "n" }, "<M-n>", "<cmd>resize +2<CR>")
map({ "n" }, "<M-e>", "<cmd>resize -2<CR>")
map({ "n" }, "<M-i>", "<cmd>vertical resize +5<CR>")
map({ "n" }, "<M-m>", "<cmd>vertical resize -5<CR>")

map({ "n" }, "gh", "0", { desc = "Jump: Start of line" })
map({ "n" }, "gl", "$", { desc = "Jump: End of line" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map({ "n", "v", "x" }, "<leader>rr", ":edit!<CR>", { desc = 'Reload current file' })
map({ "n" }, "<leader>cs", "1z=", { desc = "Correct spelling" })
map('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix item' })
map('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix item' })
map('x', '<leader>p', '"_dP', { desc = 'Paste without yanking selection' })

vim.cmd([[
  nnoremap gK @='ddkPJ'<cr>
]])

map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.pack.add({
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/vimpostor/vim-tpipeline',
  'https://github.com/lervag/vimtex',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/vague2k/vague.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/folke/lazydev.nvim',
})

require('vague').setup({ transparent = true })
vim.cmd 'colorscheme vague'
vim.cmd ':hi statusline guibg=NONE'

require 'nvim-tmux-navigation'.setup {
  disable_when_zoomed = true,
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  }
}

vim.g.vimtex_view_method = 'zathura_simple'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
  aux_dir = 'build',
  out_dir = '',
  callback = 1,
  continuous = 1,
  executable = 'latexmk',
  hooks = {},
  options = {
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}
vim.g.vimtex_quickfix_mode = 0

CustomOilBar = function()
  local path = vim.fn.expand '%'
  path = path:gsub('oil://', '')
  return '  ' .. vim.fn.fnamemodify(path, ':.')
end
require('oil').setup {
  view_options = {
    show_hidden = true,
  },
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = true,
  },
  columns = {
    "permissions",
    "icon",
  },
  float = {
    max_width = 0.7,
    max_height = 0.6,
    border = "rounded",
  },
}
vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.winbar = "%{%v:lua.CustomOilBar()%}"
  end,
})

require('mini.pairs').setup()
require('mini.git').setup()
require('mini.surround').setup()
require('mini.statusline').setup({
  use_icons = false,
})
require('mini.bufremove').setup({})
map('n', '<leader>q', require('mini.bufremove').delete, { desc = 'Delete current buffer safely' })

require('which-key').setup({
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>c', group = '[C]ode',         mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>r', group = '[R]ename/Reload' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk',     mode = { 'n', 'v' } },
  },
})

local _, ts_parsers = pcall(require, 'nvim-treesitter.parsers')
if ts_parsers and not ts_parsers.ft_to_lang then
  ts_parsers.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sx', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.lsp_references, { desc = '[S]earch [R]eferences' })
vim.keymap.set('n', '<leader>sb', builtin.git_bcommits, { desc = '[S]earch [B]commits' })
vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch [O]ld files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sd', function()
  require('telescope.builtin').find_files {
    find_command = { 'fd', '--type', 'd', '--max-depth', '3', '--exclude', '.git', '--exclude', 'node_modules' },
    prompt_title = 'Select Directory to Search',
    attach_mappings = function(prompt_bufnr)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local dir = selection[1]
        require('telescope.builtin').live_grep {
          cwd = dir,
          prompt_title = 'Grep in ' .. dir,
        }
      end)
      return true
    end,
  }
end, { desc = '[S]earch inside a [D]irectory' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sc', function()
  local xdg_config = os.getenv 'XDG_CONFIG_HOME' or (os.getenv 'HOME' .. '/.config')
  builtin.find_files { cwd = xdg_config, follow = true, }
end, { desc = '[S]earch [C]onfig directory' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files {
    cwd = vim.fn.stdpath 'config',
    follow = true,
  }
end, { desc = '[S]earch [N]eovim files' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local bufmap = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
    end

    bufmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    bufmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    bufmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    bufmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    bufmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    bufmap('<leader>cd', require('telescope.builtin').diagnostics, '[C]ode [D]iagnostics')
    bufmap('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch workspace [S]ymbols')
    bufmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    bufmap('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe')
    bufmap(']d', function() vim.diagnostic.goto_next() end, 'Next diagnostic')
    bufmap('[d', function() vim.diagnostic.goto_prev() end, 'Previous diagnostic')
    bufmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    bufmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    bufmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    if client.name == 'vtsls' then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == 'biome' then
      client.server_capabilities.documentFormattingProvider = true
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("BiomeFixAll_" .. args.buf, { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.code_action({
            context = { only = { "source.fixAll" }, diagnostics = {} },
            apply = true,
            timeout = 100,
          })
        end,
      })
    end

    vim.bo[args.buf].formatexpr = nil

    if client:supports_method('textDocument/documentHighlight') then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight-' .. args.buf, { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client:supports_method('textDocument/inlayHint') and vim.lsp.inlay_hint then
      bufmap('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable({
  "lua_ls", "clangd", "biome", "gopls", "cssls", "sqls",
  "tailwindcss", "vtsls", "jsonls", "harper_ls", "tinymist",
})

vim.lsp.config('tinymist', {
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
  },
})

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      includeLanguages = { svelte = 'html' },
      hovers = false,
      colorDecorators = false,
    },
  },
})

require('mason').setup()
require('fidget').setup({})
require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
  sources = {
    default = { 'lsp', 'path', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  fuzzy = { implementation = 'prefer_rust' },
})

require('nvim-ts-autotag').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'svelte', 'markdown', 'lua', 'rust', 'typst', 'typescript', 'javascript', 'c', 'cpp', 'glsl', 'zig', 'python', 'typescriptreact', 'tsx', 'css', 'html', 'json', 'vim', 'bash', 'latex', 'go', 'diff' },
  callback = function() vim.treesitter.start() end,
})

local parsers = require('nvim-treesitter.parsers')
local wanted = { 'bash', 'c', 'cpp', 'css', 'diff', 'go', 'html', 'javascript', 'json', 'latex', 'lua', 'luadoc',
  'markdown',
  'tsx', 'typescript', 'vim', 'vimdoc', 'typst' }
local function sync_parsers()
  require('nvim-treesitter.install').install(vim.tbl_filter(function(l) return parsers[l] end, wanted))
end
vim.api.nvim_create_user_command('SyncParsers', sync_parsers, { desc = 'Install missing Treesitter parsers' })
vim.schedule(sync_parsers)

-- vim: ts=2 sts=2 sw=2 et
