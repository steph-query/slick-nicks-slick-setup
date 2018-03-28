set encoding=utf8
call plug#begin('~/.local/share/nvim/plugged')
" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Ale, an async linter for vim
Plug 'w0rp/ale'
" Super Tab allows for tab completion in insert mode
Plug 'ervandew/supertab'
" Auto Commenter
Plug 'scrooloose/nerdcommenter'
" Nerd Tree, a file manager for vim
Plug 'scrooloose/nerdtree'
"Eunuch for file management in nerdtree pane
Plug 'tpope/vim-eunuch'
"Some react JS and JSX syntax engines
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ryanoasis/vim-devicons'
Plug 'rakr/vim-two-firewatch'
"Versatile syntax plugin
Plug 'sheerun/vim-polyglot'
" deoplete, an async completion engine.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python Completion for deoplete
Plug 'zchee/deoplete-jedi'
"JavaScript completion with tern
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Emmet for vim
Plug 'mattn/emmet-vim'
"git tools
Plug 'airblade/vim-gitgutter'
"multiple cursors
Plug 'terryma/vim-multiple-cursors'
"For grep
Plug 'mileszs/ack.vim'
"Silver Searcher
Plug 'numkil/ag.nvim'
"lightline status bar
Plug 'itchyny/lightline.vim'
"markdown preview
Plug 'euclio/vim-markdown-composer'
"change surrounding characters
Plug 'tpope/vim-surround'
"allow '.' key to repeat plugin commands
Plug 'tpope/vim-repeat'
"code snippets for reactjs
Plug 'justinj/vim-react-snippets'
"delete buffers without closing windows
Plug 'qpkorr/vim-bufkill'
"peaksea color scheme
Plug 'vim-scripts/peaksea'
"auto docstring generator for python
Plug 'heavenshell/vim-pydocstring'
"fixes indentation in yaml files
Plug 'pearofducks/ansible-vim'
call plug#end()

"yaml intentation config
let g:ansible_unindent_after_newline = 1

"python docstring shortcut
let g:pydocstring_enable_mapping = 0
nmap <C-i> :Pydocstring<CR>

" re-map leader key to ';'
let mapleader=";"

set termguicolors
if ! has("gui_running")
  set t_Co=256
endif
set background=dark
colors peaksea
filetype on             " vim will try to detect the file type
filetype plugin on      " if i'm using a plugin for this filetype it will get loaded
set tabstop=2           " show tabs with two spaces
set shiftwidth=2        " when indenting with '>' use two spaces width
set expandtab           " on pressing tab insert 2 spaces
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matche
set hidden              " let vim leave unwritten buffers

"" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Fuzzy file finder to behave like cntrl-P
nnoremap <c-p> :FZF<cr>
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

"Buffer controls
nmap ; :buffers<CR>
nmap <C-d> :BD<cr>
nmap <C-c> :BD!<cr>
nnoremap <C-a> :bp<CR>
nnoremap <C-s> :bn<CR>
nnoremap <C-t> <C-^>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>

"tell fzf to use Silver Searcher to filter out gitignored files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:ackprg = 'ag --vimgrep'

"Change arrow keys to escape to stop using them!
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>


"ctrl modifier to move through splits
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
let g:ackprg = 'ag --nogroup --nocolor --column'

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" Bind \ to do our Ag:
nnoremap \ :Ag<SPACE>

" JSX highlighting in JS files
let g:jsx_ext_required = 0

" enable deoplete on startup
let g:deoplete#enable_at_startup = 1

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ ]
"remap emmet-vim Cntrl y to contrl e
let g:user_emmet_expandabbr_key='<C-E>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx',
\      'quote_char': "'",
\  },
\}

" Auto open nerdtree and set some configurations
autocmd vimenter * NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.pyc$']
nmap <C-o> :NERDTreeToggle<CR>

"use j+j to exit insert mode
:imap jj <Esc>

"prevent multi-cursor from conflicting with deoplete
func! Multiple_cursors_before()
    call deoplete#init#_disable()
endfunc
func! Multiple_cursors_after()
    call deoplete#init#_enable()
endfunc

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Trim Whitespaces
function! TrimWhitespace()
  let l:save = winsaveview()
  %s/\\\@<!\s\+$//e
  call winrestview(l:save)
endfunction
autocmd FileType * autocmd BufWritePre <buffer> :call TrimWhitespace()

