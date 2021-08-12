syntax on
set nu
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'crusoexia/vim-monokai'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-cucumber'
Plug 'tomlion/vim-solidity'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'racer-rust/vim-racer'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dyng/ctrlsf.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

set background=dark
syntax on
colorscheme onedark

syntax enable
filetype plugin indent on
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <F2> :echo 'Current time is ' . strftime('%c')<CR>
map <C-b> :NERDTreeToggle<CR>
map <C-T> :tabedit<CR>
map <C-z> :vs<CR>
map <C-p> :Files<CR>
map <C-s> :w<CR>
map <C-q> :q<CR>
map <C-c> :w !xclip -sel clip<CR><CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"show filepath
set statusline+=%F


"CtrlSF
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

nnoremap <c-s> :w<CR> 
inoremap <c-s> <Esc>:w<CR>l  
vnoremap <c-s> <Esc>:w<CR>  

"Go-vim
nmap <C-@> <Esc>:GoDef<Enter>

"Open NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" history
set history=700

" Vim recommended
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
set synmaxcol=9999
set hidden " Allows you to switch buffers without saving current
set wildmenu "tab completion
set wildmode=longest:full,full " First tab brings up options, second tab cycles
set encoding=utf8

" Movement
let mapleader = ","
set tm=2000
noremap ,, ,

" treat wrapped lines as different lines
nnoremap j gj
nnoremap k gk

" Enable mouse support
set mouse=a

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show current position
set ruler

" Remove bell
set visualbell
set t_vb=

" Better searching
set incsearch
set ignorecase
set smartcase
set wrapscan "wraps around end of file
" Redraw screen and clear highlighting
nnoremap <Leader>r :nohl<CR><C-L>

" Don't redraw while executing macros (good performance config)
set lazyredraw

" tabs
set expandtab
set smarttab

" nowrap
set nowrap

" Show matching bracket
set showmatch
set matchtime=2
set shiftwidth=2
set tabstop=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Close nerdtree after a file is selected
"let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
"nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
"nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

nnoremap gp :silent %!yarn prettier --stdin-filepath %<CR>
let g:coc_disable_startup_warning = 1

let NERDTreeShowHidden=1

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>

au filetype go inoremap <buffer> . .<C-x><C-o>

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor     

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\t` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

