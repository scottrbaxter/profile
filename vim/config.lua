--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.builtin.treesitter.highlight.enable = false
lvim.transparent_window = true
lvim.colorscheme = "space-vim-custom" -- custom: ~/.config/lvim/colors/space-vim-custom.vim

-- vim.cmd "let g:space_vim_dark_background = 234"
-- lvim.lsp.document_highlight = false
-- vim.g.space_nvim_transparent_bg = false
-- lvim.colorscheme = "substrata"
-- lvim.colorscheme = "tokyonight"
-- lvim.g.tokyonight_style = "night"
-- lvim.colorscheme = "moonfly"
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "material"
-- lvim.g.material_style = "deep ocean"
-- lvim.g.material_style = "darker"

vim.cmd "set iskeyword+=-"
vim.cmd "set whichwrap=b,s" -- do not wrap cursor

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
vim.cmd([[
  " Map the arrow keys to be based on display lines, not physical lines
  map <Down> gj
  map <Up> gk
  map <S-u> <C-r>
  nmap gg gg^
  nmap v ve
  nmap <space>r gcc
  vmap <space>r gcc<esc>
  nmap <space>q :q<CR>
  nnoremap q :q<CR>
  nnoremap <space>Q :q!<CR>
  nnoremap Q :q<CR>
  nmap <space>w :w<CR>
  nmap <CR> o<Esc>
  nmap <Up> <Up>^
  nmap <Down> <Down>^
  nmap <S-C-Left> <C-W>h
  nmap <S-C-Right> <C-W>l
  nmap <S-Up> V<Up>^
  nmap <S-Down> V<Down>^
  vmap <S-Up> <Up>
  vmap <S-Down> <Down>
  vmap <S-Left> <
  nmap <S-Left> <<
  vmap <S-Right> >
  nmap <S-Right> >>
  nmap ` v~
  nmap <space>f :StripWhitespace<CR>
  nnoremap <C-Up> :m .-2<CR>==
  nnoremap <C-k> :m .-2<CR>==
  nnoremap <C-Down> :m .+1<CR>==
  nnoremap <C-j> :m .+1<CR>==
  vnoremap <C-Down> :m '>+1<CR>gv=gv
  vnoremap <C-Up> :m '<-2<CR>gv=gv
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv
  cnoremap <Up> <C-p>
  cnoremap <Down> <C-n>
  vmap ' S'
  vmap " S"
  vmap [ S[
  vmap ] S]
  vmap } S}
  vmap { S{
  vmap ( S(
  vmap ) S)
  vmap ` S`
  vmap ` S`
  let g:gitblame_enabled = 0
  set list lcs=eol:¬,tab:▸\-
  let g:indentLine_color_term = 239
  let g:indentLine_char = '|'
  let g:indentLine_concealcursor = 'inc'
  let g:indentLine_conceallevel = 0 " do not conceal/hide extmarks (e.g. quotes)
  set nowrap                          " wrap lines
  set tabstop=2                     " a tab is two spaces
  set shiftwidth=2                  " an autoindent (with <<) is two spaces
  set expandtab                     " use spaces, not tabs
  set list                          " Show invisible characters
  set backspace=indent,eol,start    " backspace through everything in insert mode
  set listchars=""                  " Reset the listchars
  set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
  set listchars+=trail:.            " show trailing spaces as dots
  set listchars+=extends:>          " The character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
  set listchars+=precedes:<         " The character to show in the last column when wrap is
  " end of line has $, tab has ▸
  set list lcs=eol:¬,tab:▸\-
  nmap <silent> <F3> :set invwrap<CR>:set wrap?<CR>
  nmap W :set invwrap<CR>:set wrap?<CR>
  " show current line diagnostics
  nmap <silent> ; :lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>
]])

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>q!<CR>", "Quit!" }
lvim.builtin.which_key.mappings["Th"] = { "<cmd>TSHighlightCapturesUnderCursor<CR>", "Highlight"}
lvim.builtin.which_key.mappings["Tp"] = { "<cmd>TSPlaygroundToggle<CR>", "Playground"}
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.mappings["F"] = { "<cmd>StripWhitespace<CR>", "Fix Whitespace"}
lvim.builtin.which_key.mappings["B"] = { "<cmd>GitBlameToggle<CR>", "Git Blame Toggle"}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "dockerfile",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "yaml",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
-- lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  {"norcalli/nvim-colorizer.lua"},
  {"rktjmp/lush.nvim"},
  {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
  {"f-person/git-blame.nvim"},
  {"iamcco/markdown-preview.nvim"},
  {"karb94/neoscroll.nvim"},
  {"farmergreg/vim-lastplace"},
  {"Yggdroot/indentLine"},
  {"tpope/vim-surround"},
  {"ntpeters/vim-better-whitespace"},
  {"Raimondi/delimitMate"},
  {"luochen1990/rainbow"},
  -- {"folke/tokyonight.nvim"},
  -- {"marko-cerovac/material.nvim"},
  -- {"arzg/vim-substrata"},
  -- {"bluz71/vim-moonfly-colors"},
  -- {"liuchengxu/space-vim-dark"},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

lvim.builtin.lualine.style = "default" -- or "none"
-- lvim.builtin.lualine.style = "none" -- or "none"
-- lvim.builtin.lualine.options.theme = "iceberg_dark"
-- lvim.builtin.lualine.options.theme = "auto"

local colors = {
  black = "#0f1419", -- black
  light_black = "#14191f", -- lighter black
  slight_black = "#303c4b", -- slightly lighter black
  dark_grey = "#3e4b59", -- dark grey
  dark_yellow = "#b8cc52", -- dark yellow
  faint_yellow = "#e6e1cf", -- faint yellow
  yellow = "#ffee99", -- yellow
  light_blue = "#36a3d9", -- light blue
  light_red = "#f07178", -- light red
  d_black = "#000000", -- distinguished text black
  d_grey = "#8a8a8a", -- distinguished normal grey
  d_orange = "#c86627", -- distinguished normal orange
  d_yellow = "#afaf69", -- distinguished insert yellow
  d_red = "#a46361", -- distinguished visual red
  d_blue = "#6886ab", -- distinguished replace blue
}

lvim.builtin.lualine.options.theme = {
  normal = {
    c = { fg = colors.d_grey, bg = colors.light_black },
    -- a = { fg = colors.black, bg = colors.light_blue, gui = "bold" },
    a = { fg = colors.d_black, bg = colors.d_grey, gui = "bold" },
    b = { fg = colors.faint_yellow, bg = colors.light_black },
  },
  insert = {
    -- a = { fg = colors.black, bg = colors.dark_yellow, gui = "bold" },
    a = { fg = colors.black, bg = colors.d_yellow, gui = "bold" },
    b = { fg = colors.faint_yellow, bg = colors.light_black },
  },
  visual = {
    -- a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
    a = { fg = colors.black, bg = colors.d_red, gui = "bold" },
    b = { fg = colors.faint_yellow, bg = colors.light_black },
  },
  replace = {
    -- a = { fg = colors.black, bg = colors.light_red, gui = "bold" },
    a = { fg = colors.black, bg = colors.d_blue, gui = "bold" },
    b = { fg = colors.faint_yellow, bg = colors.light_black },
  },
  inactive = {
    c = { fg = colors.faint_yellow, bg = colors.black },
    a = { fg = colors.faint_yellow, bg = colors.light_black, gui = "bold" },
    -- a = { fg = colors.faint_yellow, bg = colors.light_black, gui = "bold" },
    b = { fg = colors.faint_yellow, bg = colors.light_black },
  },
}

-- do not modify on write/save file
lvim.format_on_save = false

-- https://github.com/LunarVim/LunarVim/issues/1867
lvim.builtin.treesitter.indent = { enable = true, disable = { "python" } }

vim.opt.timeoutlen = 10

-- vim.opt.swapfile = true
-- vim.cmd "set backupdir^=~/.cache/nvim/backupdir//" -- where to put backup files.
-- vim.cmd "set directory^=~/.caache/nvim/temp//"   -- where to put swap files.

lvim.builtin.treesitter.playground.enable = true
lvim.lsp.diagnostics.virtual_text = false -- line diagnostics will not auto display, use 'gl'

-- present line diagnostics below current line only
-- lvim.autocommands.custom_groups = {
--   { "CursorHold", "*", "lua vim.diagnostic.open_float(0,{scope='line'})" },
-- }
