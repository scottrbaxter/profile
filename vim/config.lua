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
lvim.format_on_save = true
lvim.colorscheme = "space-vim-dark"
vim.g.space_vim_dark_background = 234

-- lvim.colorscheme = "space-nvim"
-- vim.g.space_nvim_transparent_bg = false
-- lvim.colorscheme = "substrata"
-- lvim.colorscheme = "tokyonight"
-- lvim.g.tokyonight_style = "night"
-- lvim.colorscheme = "moonfly"
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "material"
-- lvim.g.material_style = "deep ocean"
-- lvim.g.material_style = "darker"

-- lvim.line_wrap_cursor_movement = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
vim.cmd([[
  map <S-u> <C-r>
  nmap v ve
  nmap <space>r gcc
  vmap <space>r gcc<esc>
  nmap <space>q :q<CR>
  nnoremap q :q<CR>
  nmap <space>Q :q!<CR>
  nmap <space>w :w<CR>
  nmap <CR> o<Esc>
  nmap <Up> <Up>^
  nmap <Down> <Down>^
  nmap <S-C-Left> <C-W>h
  nmap <S-C-Right> <C-W>l
  nmap <S-Up> V<Up>^
  nmap <S-Down> V<Down>^
  nmap <space>' cs"'
  nmap <space>" cs'"
  vmap <S-Up> <Up>
  vmap <S-Down> <Down>
  vmap <S-Left> <
  nmap <S-Left> <<
  vmap <S-Right> >
  nmap <S-Right> >>
  nmap <space>b :GitBlameToggle<CR>
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
  let g:gitblame_enabled = 0
  set list lcs=eol:¬,tab:▸\-
  let g:indentLine_color_term = 239
  let g:indentLine_char = '|'
  let g:indentLine_concealcursor = 'inc'
  let g:indentLine_conceallevel = 1
  set nowrap                        " don't wrap lines
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
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {"bluz71/vim-moonfly-colors"},
  {"folke/tokyonight.nvim"},
  {"marko-cerovac/material.nvim"},
  {"liuchengxu/space-vim-dark"},
  {"Th3Whit3Wolf/space-nvim"},
  {"arzg/vim-substrata"},
  {"scrooloose/nerdcommenter"},
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
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

lvim.builtin.lualine.style = "default" -- or "none"
lvim.builtin.lualine.options.theme = "iceberg_dark"
-- lvim.builtin.lualine.options.theme = "papercolor_dark"
-- lvim.builtin.lualine.options.theme = "auto"

-- do not modify on write/save file
lvim.format_on_save = false
