""" Vim Janus loaded plugins
" Plug 'Lokaltog/vim-easymotion'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'TechnoGate/janus-colors'
Plug 'airblade/vim-gitgutter'
" Plug 'altercation/vim-colors-solarized'
" Plug 'ap/vim-css-color'
" Plug 'blueshirts/darcula'
" Plug 'bronson/vim-trailing-whitespace'
" Plug 'chrisbra/NrrwRgn'
" Plug 'chrisbra/csv.vim'
" Plug 'chriskempson/base16-vim'
" Plug 'chriskempson/vim-tomorrow-theme'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'depuracao/vim-rdoc'
" Plug 'ervandew/supertab'
" Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'jeetsukumaran/vim-buffergator'
" Plug 'larssmit/vim-getafe'
Plug 'majutsushi/tagbar'
" Plug 'mattn/gist-vim'
" Plug 'mattn/webapi-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
" Plug 'mmalecki/vim-node.js'
Plug 'rgarver/Kwbd.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
" Plug 'sh-dude/ZoomWin'
Plug 'sheerun/vim-polyglot'
" Plug 'sjl/gundo.vim'
" Plug 'skalnik/vim-vroom'
" Plug 'sunaku/vim-ruby-minitest'
" Plug 'telamon/vim-color-github'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-visualstar'
" Plug 'tomtom/tlib_vim'
" Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-pathogen'
" Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vividchalk'
" Plug 'twerth/ir_black'
" Plug 'vim-scripts/Colour-Sampler-Pack'
" Plug 'vim-scripts/molokai'
" Plug 'vim-scripts/pyte'
" Plug 'vim-scripts/vimwiki'
" Plug 'vim-syntastic/syntastic'

""" Custom plugins from ~/.janus
Plug 'bronson/vim-crosshairs'
" Plug 'godlygeek/tabular'
" Plug 'hashivim/vim-terraform'
Plug 'ivanov/vim-ipython'
Plug 'jeetsukumaran/vim-indentwise'
" Plug 'juliosueiras/terraform-lsp'
" Plug 'keith/swift'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvie/vim-flake8'
Plug 'pearofducks/ansible-vim'
" Plug 'rstacruz/vim-closer'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'willthames/ansible-lint'
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
" Plug 'neoclide/jsonc.vim'
Plug 'aymericbeaumet/vim-symlink' " needed for vim-fugitive to follow symlinks

" Theme (colorscheme)
Plug 'liuchengxu/space-vim-dark'
" Plug 'rakr/vim-one'
" Plug 'marko-cerovac/material.nvim'
" Plug 'shaunsingh/nord.nvim'

" ale
Plug 'dense-analysis/ale'
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

let g:airline#extensions#ale#enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1

" signs to use for w0rp/ale linters
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Disable warnings about trailing whitespace in Python files
" let g:ale_warn_about_trailing_whitespace = 0

" required by ale for global eslint support
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'yarn'
let g:ale_javascript_eslint_options = 'run eslint'

" deoplete
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   let g:deoplete#enable_at_startup = 1
" endif

" Ultisnips
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger       = '<c-t>'
" let g:UltiSnipsJumpForwardTrigger  = '<c-e>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-a>'
