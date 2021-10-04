""" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" colorscheme/theme
source $PROFILE_PATH/_vim/colorscheme.vim
" remaining profile plugins
source $PROFILE_PATH/_vim/plugins.vim
" coc.nvim plugin and config
" source $PROFILE_PATH/_vim/coc-custom.vim

" Initialize plugin system
call plug#end()

""" from ~/.vim/janus/vim/core/before/plugin/mappings.vim
""
"" General Mappings (Normal, Visual, Operator-pending)
""

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

""
"" Command-Line Mappings
""

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"

""" from ~/.vim/janus/vim/core/before/plugin/settings.vim
""
"" Basic Setup
""

if has('vim_starting') && !has('nvim') && &compatible
  set nocompatible               " Be iMproved
endif
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
" Neovim disallow changing 'enconding' option after initialization
" see https://github.com/neovim/neovim/pull/2929 for more details
if !has('nvim')
  set encoding=utf-8  " Set default encoding to UTF-8
endif

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

""" Necessary new stuff
" let g:snipMate = {'snippet_version': 1}

""" From vim-janus ~/.vimrc.before
" NERDCommenter stuff
let g:NERDSpaceDelims = 1 " adds # of spaces default for all filetypes
let g:NERDDefaultAlign = 'left' " always to far left
let g:NERDAltDelims_python = 1 " without this python double spaces
let g:NERDCustomDelimiters = { 'arduino': { 'left': '//','right': '' } } " required for proper .ino file comments
let g:NERDCustomDelimiters = { 'ansible_template': { 'left': '#','right': '' } } " required for proper ansible file comments
let g:NERDCustomDelimiters = { 'text': { 'left': '#','right': '' } } " use # for unspecified file comments
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
" let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines

" powerline fancy stuff
" let g:Powerline_symbols = 'fancy'

" airline theme set here
let g:airline_theme='distinguished'
" let g:airline_powerline_fonts = 1
" let g:Powerline_symbols = 'unicode'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set encoding=utf-8

" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

let g:airline#extensions#ale#enabled = 1
let g:ale_completion_autoimport = 1

""" From vim-janus ~/.vimrc.after

" personal custom shortcuts
nmap <silent> <space>j <Plug>(ale_next_wrap)
nmap <silent> <space>J <Plug>(ale_previous_wrap)
nmap <silent> <space><up> [c " GitGutterPrevHunk
nmap <silent> <space><down> ]c " GitGutterNextHunk
nmap <silent> <space><right> <leader>hp:wincmd P<CR>gg " GitGutterPreviewHunk
nmap <space> \
nmap <space>a \cA
nmap <space>d :Gdiff<CR>
nmap <space>f :StripWhitespace<CR>
nmap <space>r \c<space>
nmap <space>b :Git blame<CR>
nmap <space>q :q<CR>
nmap <space>Q :q!<CR>
nmap <space>w :w<CR>
nmap <space><tab> :%s/\t/    /g<CR>
nmap <space>' cs"'
nmap <space>" cs'"
nmap ' ysiw'
nmap " ysiw"
nmap <space>[ ysiw]
nmap <space>] ysiw}i$<Esc>
nmap <space>} ysiw{
nmap <space>{ ysiw[
nmap <space>- :s/-/_/<CR>
vmap <space>- :s/\%V-/_/<CR>
nmap <space>_ :s/_/-/<CR>
vmap <space>_ :s/\%V_/-/<CR>
nmap ` v~
nmap t :TagbarOpenAutoClose<CR>
nnoremap q :q<CR>
vmap <space>r \c<space>
vmap <space>= :s/[ ]\{2,}=/ =/g<CR><C-O>
nmap <space>= :%s/[ ]\{2,}=/ =/g<CR><C-O>
vmap <space>t :Tabularize /=<CR>
vmap <space>T :Tabularize<CR>
vmap <space># :Tabularize /#<CR>
vmap <space>" :Tabularize /"<CR>
vnoremap A <C-v>$A
vnoremap I <C-v>$I
" nmap v<down> vi}
nmap <silent> <space>c :call MessageToClipboard()<CR>
nmap f zA| " toggle open/close folding
nmap F :call FoldAllToggle()<cr>| " equiv to toggle for zM/zR
vmap ' S'
vmap " S"
vmap [ S[
vmap ] S]
vmap } S}
vmap { S{
vmap ( S(
vmap ) S)
vmap ` S`

" set nonumber
" set nolist " list disables linebreak
" set lbr " without lbr the line can be split on a word
set nocompatible
" end of line has $, tab has ▸
set list lcs=eol:¬,tab:▸\-
" set list lcs=tab:\▸\
set wrap

" au == autocmd
" autocmd VimEnter *.py nested :TagbarOpen
" autocmd VimEnter *.sh nested :TagbarOpen
" autocmd VimEnter * if &ft!='ansible.yaml' | nested :TagbarOpen | endif

" quit help with 'q'
au FileType help noremap <buffer> q :q<cr>

" disable 'recording @p'
" map q <Nop>
" disable 'Entering Ex mode'
map Q <Nop>

" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=** " '**' recursively searches through subdirectories
set wildmenu " Display all matching files when we tab-complete

" se mouse=c "
" se mouse=a " mouse copy turns into visual mode and provides smooth scroll all nice like, i prefer this one
se mouse+=a " mouse copy turns into visual mode
" se mouse=nicr " mouse scroll is nicer, and click puts you where the mouse is, but click select doesn't enable visual mode
" let g:wheel#scroll_on_wrap = 1      " 0=disable, 1=enable (default)

" set ttymouse=sgr
" set balloondelay=250
" set ballooneval
" set balloonevalterm
let g:ale_set_balloons = 1

if has('nvim')
  set clipboard=unnamedplus
else
  set clipboard=autoselect " yank to osx clipboard, but doesn't put vim's change/delete stuff in clipboard
  " set clipboard=unnamedplus,unnamed,autoselect " yank to osx clipboard
  " set clipboard=unnamed,autoselect " yank to osx clipboard including change/delete in vim
endif

set startofline

" move to 1st character on line when changing lines
nmap <Up> <Up>^
nmap <Down> <Down>^
" vimdiff vertical split switching
nmap <S-C-Left> <C-W>h
nmap <S-C-Right> <C-W>l
" hold shift to highlight text in visual mode.
nmap <S-Up> V<Up>^
nmap <S-Down> V<Down>^
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <
vmap <S-Right> >
" vmap <S-Left> <Left>
" vmap <S-Right> <Right>
" change indent while in normal mode
nmap <S-Left> <<
nmap <S-Right> >>

" leaves cursor after end of yank while in visual mode, not needed with 'se mouse+=a'
" vmap y y`]

" NerdTree on vim start
" au StdinReadPre * let s:std_in=1
" au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" powerline fancy stuff
let g:Powerline_symbols = 'fancy'

" Make vim searches case insensitive
" set ignorecase " won't find insensitive searches if using capital letter in search
set smartcase " will change to case sensitive if typing capital letters

" vim-indentwise remappings
map <S-C-Up> <Plug>(IndentWisePreviousEqualIndent)
map <S-C-Down> <Plug>(IndentWiseNextEqualIndent)

"map [- <Plug>(IndentWisePreviousLesserIndent)
"map [= <Plug>(IndentWisePreviousEqualIndent)
"map [+ <Plug>(IndentWisePreviousGreaterIndent)
"map ]- <Plug>(IndentWiseNextLesserIndent)
"map ]= <Plug>(IndentWiseNextEqualIndent)
"map ]+ <Plug>(IndentWiseNextGreaterIndent)
"map [_ <Plug>(IndentWisePreviousAbsoluteIndent)
"map ]_ <Plug>(IndentWiseNextAbsoluteIndent)
"map [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
"map ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)

" http://vimdoc.sourceforge.net/htmldoc/filetype.html
" needed both of these for nerdcommenter to play nice
filetype plugin on " detect: on, plugin: on, indent: unchanged
" filetype indent off " detect: unchanged, plugin: unchanged, indent: off

" insert new line in normal mode by pressing enter without using insert mode
" leaves cursor on initial line
nmap <CR> o<Esc>

" change U to redo
" http://vim.wikia.com/wiki/Undo_and_Redo
map <S-u> <C-r>


" toggle highlight
nnoremap <silent> <F2> :set hlsearch!<CR>

" highlight whole word on click-drag
" nmap <S-LeftMouse> viw
" nmap <S-LeftDrag> viw
" nmap <S-LeftRelease> w

" add single quote around text until next white space
" nnoremap " lBcE""<Esc>Pw
" nnoremap ' lBcE''<Esc>Pw
" nnoremap [ lBcE[]<Esc>Pw
" nnoremap { lBcE"{{  }}"<Esc>3hPw
" add single quote around word
" nnoremap " ciw""<Esc>P
" nnoremap ' ciw''<Esc>P
" nnoremap [ ciw[]<Esc>Pw
" nnoremap { ciw{}<Esc>Pw

" nmap <Leader>' ds'
" nmap <Leader>" ds"
" nmap <Leader>[ ds[
" nmap <Leader>{ ds{ds{ds"
" nmap <Leader>( ds(

" stay in visual mode when changing indent level with < or >
vmap < <gv
vmap > >gv

" shortcuts in normal mode
nmap ge G$
nmap ; :
nmap ;q :q<CR>
nmap ;Q :q!<CR>
nmap v ve
nnoremap <bs> i<bs><esc>w
" nnoremap <tab> >>
" nnoremap <S-tab> <<

" don't add newline character if the file didn't already have one
set nofixeol

" colorscheme default " reverts colorscheme
let g:space_vim_dark_background = 234 " (233 = darkest, 235 = default, 238 = lightest)
" set termguicolors " sets term to use gui colors
colorscheme space-vim-dark " submodule in profile repo
" autocmd FileType yaml colorscheme material-monokai " makes vim colors (expecially highlight) tolerant
" autocmd FileType yaml colorscheme asu1dark " makes vim colors (expecially highlight) tolerant
" autocmd FileType yaml colorscheme getafe " makes vim colors (expecially highlight) tolerant
" colorscheme getafe " makes vim colors (expecially highlight) tolerant

" highlighting (colors)
" You can see all the groups currently active with this command: >
    " :so $VIMRUNTIME/syntax/hitest.vim
highlight LineNr ctermfg=grey ctermbg=235
highlight Comment ctermfg=Grey
highlight Normal ctermfg=White
highlight Visual cterm=NONE ctermbg=052
highlight IncSearch cterm=NONE ctermbg=20 ctermfg=250
highlight Search cterm=NONE ctermbg=20 ctermfg=250
highlight SpellBad ctermbg=235
highlight SpellCap ctermbg=DarkRed
" highlight Search cterm=NONE ctermbg=237
" highlight Search cterm=NONE ctermfg=white ctermbg=blue
" highlight Search cterm=NONE ctermbg=103
" set colorcolumn=80 " vertical line at 80 characters


" let g:indentLine_setColors = 0 " highlight conceal color with your colorscheme
let g:indentLine_color_term = 239 " indent marker color
let g:indentLine_char = '|' " indent marker character (options: ¦┆│⎸▏)
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 0 " default "2" hides markdown(.md) hyperlinks

" fix tab for proper indenting, except for ft-plugin file types that have this set elsewhere
" tabstop is the number of spaces pressing tab enters, softtapstop is the number of spaces deleted with the delete key
" expandtab changes tabs to spaces set tabstop=2 softtabstop=2 expandtab " global

" only needed if global tabstop is defined differently above
au FileType dockerfile setlocal tabstop=2 shiftwidth=2 softtabstop=2
au FileType gitconfig setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab " conform to bashate (pep8) standards
au FileType python setlocal tabstop=4 shiftwidth=4 foldmethod=indent foldnestmax=10 foldlevel=2
au FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab
au FileType sh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab " conform to bashate (pep8) standards
au FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
au FileType yaml.ansible setlocal tabstop=2 shiftwidth=2 softtabstop=2
au FileType zsh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab " conform to bashate (pep8) standards

" ansible formatting for yaml files
" au BufNewFile,BufRead *.ini set filetype=ansible_hosts
" au BufEnter * if &filetype == "" | setlocal ft=sh | endif
" au BufNewFile,BufRead *.yaml set filetype=ansible.yaml
" au BufNewFile,BufRead *.yml set filetype=ansible.yaml
au BufRead,BufNewFile */*.bats set filetype=bash
au BufRead,BufNewFile */playbooks/*.y*ml set filetype=ansible.yaml
au BufRead,BufNewFile *.hcl set filetype=terraform
au BufNewFile,BufRead *.yaml setlocal indentkeys=0{,0},:,0#,!^F,o,0,e
au BufEnter * if &filetype == "" | setlocal ft=text | endif " any unknown filetype will be known as 'text'
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_syntaxes = "sh.vim ruby.vim"
let g:ansible_attribute_highlight = "a"

" FKey Reference
" F1 help
" F3 set/unset line wrap (janus shortcut = \tw)
" F4 nopaste/paste
" F5 open Gundo
" F6 pretty print json (.json files only)
" F7 toggle line break
" F8 set autoindent
" F9 flake8 linter (python files only), toggle conceal level (json files only)
" F10 vim display highlight group
" F11 toggle vertical line at 80 characters

" :set inv{thing} sets the inverted, and :set {thing}? shows what the value is set to
" set paste " handles pasting with additional comment or tabs, indentation is a pita here
" set autoindent " newline adds indents, toggle with F9
" au FileType python :set nopaste " keep jedi but also not new comment on new line after commented line
" nmap <silent> <F2> :set cursorline! cursorcolumn!<CR>

" From :help fo-table
" letter  meaning when present in 'formatoptions'
" t       Auto-wrap text using textwidth
" c       Auto-wrap comments using textwidth, inserting the current comment
"         leader automatically.
" r       Automatically insert the current comment leader after hitting
"         <Enter> in Insert mode.
" o       Automatically insert the current comment leader after hitting 'o' or
"         'O' in Normal mode.
" q       Allow formatting of comments with "gq".
"	        Note that formatting will not change blank lines or lines containing
"	        only the comment leader.  A new paragraph starts after such a line,
" l       Long lines are not broken in insert mode: When a line was longer than
"         'textwidth' when the insert command started, Vim does not
"         automatically format it.

function! ConcealLevelToggle()
    if &conceallevel
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction

function! ColorColumnToggle()
    if &colorcolumn
        setlocal colorcolumn=0
    else
        setlocal colorcolumn=80
    endif
endfunction

function! MessageToClipboard()
  redir @+
  1message
  redir END
endfunction

au BufNewFile,BufRead * setlocal formatoptions-=cro " default: croql
nmap <silent> H :set cursorcolumn!<CR>
nmap <silent> <F3> :set invwrap<CR>:set wrap?<CR>
nmap <silent> <F7> :set invlbr<CR>:set lbr?<CR>
nmap <silent> <F8> :set invautoindent<CR>:set autoindent?<CR>
au FileType gitcommit set tw=99
au FileType json syntax match Comment +\/\/.\+$+
au FileType json nnoremap <silent> <F6> :%!python -m json.tool<CR>
" au FileType json nnoremap <silent> <F9> :call ConcealLevelToggle()<CR>
" au FileType python map <buffer> <F9> :call Flake8()<CR>
au FileType json,yaml nnoremap <silent> <F9> :call ConvertJsonYaml()<CR>
au FileType markdown nnoremap <silent> <F9> :call ConcealLevelToggle()<CR>
au FileType markdown set tw=120
nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nmap <silent> <F11> :call ColorColumnToggle()<CR>

" crosshair colors
hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=grey guibg=darkred guifg=white

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  if !has('nvim-0.5')
    set undodir=$HOME/.vim/_temp  "directory where the undo files will be stored
  endif
endif

" signs to use for w0rp/ale linters
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Check Python files with flake8 and pylint.
let g:ale_linters = {
\  'python': ['pylint', 'flake8'],
\}
let g:ale_fixers = {
\  'python': ['autopep8', 'yapf'],
\}
" Disable warnings about trailing whitespace
let g:ale_warn_about_trailing_whitespace = 1

" vim-markdown-preview https://github.com/JamshedVesuna/vim-markdown-preview#mac-os-x
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
" let vim_markdown_preview_hotkey='<C-p>'
let vim_markdown_preview_browser='Google Chrome'

function! ConvertJsonYaml()
  if (&ft=='json')
    :%!json2yaml
    :set ft=yaml
  elseif (&ft=='yaml')
    :%!yaml2json
    :set ft=json
  endif
endfunction

" search hyphenated words
" set iskeyword+=-

" vim folding
set nofoldenable

function! FoldAllToggle()
    if &foldlevel
        setlocal foldlevel=0
    else
        setlocal foldlevel=2
    endif
endfunction

" remember cursor position on file re-open
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" YCM
" let g:ycm_auto_hover = 'CursorHold'
" let g:ycm_auto_hover = ''
" " let g:ycm_key_detailed_diagnostics = '<leader>d'
" let g:ycm_key_detailed_diagnostics = ''
" nmap <space>d <plug>(YCMHover)
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
" let g:ycm_key_invoke_completion = ['<C-space>', '<Enter>']
" let g:ycm_key_list_stop_completion = ['<C-y>', '<space>']

" let s:ycm_hover_popup = -1
" function s:Hover()
"   let response = youcompleteme#GetCommandResponse( 'GetDoc' )
"   if response == ''
"     return
"   endif

"   call popup_hide( s:ycm_hover_popup )
"   let s:ycm_hover_popup = popup_atcursor( balloon_split( response ), {} )
" endfunction

" " CursorHold triggers in normal mode after a delay
" autocmd CursorHold * call s:Hover()
" " Or, if you prefer, a mapping:
" nnoremap <silent> <leader>D :call <SID>Hover()<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<s-tab>"
