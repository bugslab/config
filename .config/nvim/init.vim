set shell=/bin/dash

call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'machakann/vim-sandwich'
Plug 'lifepillar/vim-colortemplate'
Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'vifm/vifm.vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'ap/vim-buftabline'
Plug 'godlygeek/tabular'
" Plug 'fatih/vim-go'
" Plug 'honza/vim-snippets'
" Plug 'fatih/vim-go'
" Plug 'SirVer/ultisnips'
Plug 'gregsexton/MatchTag'
" Plug 'mg979/vim-visual-multi'

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start
set splitbelow
set splitright

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set inccommand=nosplit

"" Directories for swp files
set nobackup
set nowritebackup
set noswapfile

set fileformats=unix,dos,mac
"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1

set mousemodel=popup
set t_Co=256
set scrolloff=3

"" Status bar
set laststatus=2
set noshowmode

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev q1 q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Personal

map j gj
map k gk
nnoremap ,cfv :vsplit ~/.config/nvim/init.vim <cr>
nnoremap ,ref :source ~/.config/nvim/init.vim <cr>

vnoremap <silent> ,r :call VisualSelection('replace')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

let g:vifm_embed_split = 1
let g:vifm_term = 'st -e'
let g:vifm_replace_netrw = 1



if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
imap <silent> jk <Esc>:FixWhitespace<CR>
imap <silent> kj <Esc>:FixWhitespace<CR>

set background=dark
colorscheme space_vim_theme "tequila-sunrise horizon   gruvbox-material
"horizon  codedark
set termguicolors
let g:space_vim_italicize_strings = 1
let g:space_vim_italic = 1

" mouse
set mouse=a
set number relativenumber

augroup terminal-mode
    autocmd!
    au TermOpen * setlocal nonumber
    au TermOpen * setlocal norelativenumber
    au TermOpen * setlocal noshowmode
    au TermOpen * setlocal noruler
    au TermOpen * setlocal laststatus=0
    au TermOpen * setlocal noshowcmd

    au TermClose * setlocal number
    au TermClose * setlocal relativenumber
    au TermClose * setlocal noshowmode
    au TermClose * setlocal ruler
    au TermClose * setlocal laststatus=2
    au TermClose * setlocal showcmd
augroup end

set list
"" Split
noremap <silent>,h :<C-u>split<CR>
noremap <silent>,j :<C-u>vsplit<CR>


"*****************************************************************************
" buftabline
"*****************************************************************************
nnoremap <silent> <S-t> :tabnew<CR>
let g:buftabline_numbers = 2
let g:buftabline_show = 1

nmap ,1 <Plug>BufTabLine.Go(1)
nmap ,2 <Plug>BufTabLine.Go(2)
nmap ,3 <Plug>BufTabLine.Go(3)
nmap ,4 <Plug>BufTabLine.Go(4)
nmap ,5 <Plug>BufTabLine.Go(5)
nmap ,6 <Plug>BufTabLine.Go(6)
nmap ,7 <Plug>BufTabLine.Go(7)
nmap ,8 <Plug>BufTabLine.Go(8)
nmap ,9 <Plug>BufTabLine.Go(9)
nmap ,0 <Plug>BufTabLine.Go(10)

hi! link BufTabLineCurrent TabLineSel
hi! link BufTabLineActive PmenuSel
hi! link BufTabLineHidden TabLine
hi! link BufTabLineFill TabLineFill

"*****************************************************************************
" coc.nvim
"*****************************************************************************
map ,s :CocComman session.save <C-R>=expand('%:p:h:t')<cr>
map ,l :CocComman session.load <C-R>=expand('%:p:h:t')<cr>

inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<CR>" :
      \ coc#refresh()

inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<TAB>"
" inoremap <silent><C-h> <BS>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = "<C-s>"
let g:coc_snippet_prev = "<C-S>"


nnoremap <silent> <leader>a :CocList buffers<CR>
nnoremap <silent> <leader>f :CocList files<CR>
nnoremap <silent> <leader>gc :CocList bcommits<CR>
nnoremap <silent> <leader>y :CocList yank<CR>
nnoremap <silent> <leader>w :CocList files<cr>
nmap <silent> <C-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-]> <Plug>(coc-diagnostic-next)


nmap <silent>gr <Plug>(coc-references)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>ge <Plug>(coc-definition)

set belloff+=ctrlg

nnoremap <silent> S :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> ,y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> ,r  :<C-u>CocList tags<cr>
vmap <silent>f <Plug>(coc-format-selected)
" coc-snippets
" imap <C-s> <Plug>(coc-snippets-expand)

" coc-lists
let g:coc_git_status=1
nnoremap <silent> <space>s  :<C-u>CocList --normal gstatus<CR>
nmap gs <Plug>(coc-git-chunkinfo)
nmap gd <Plug>(coc-git-commit)
nmap gN <Plug>(coc-git-prevchunk)
nmap gn <Plug>(coc-git-nextchunk)
nnoremap <silent> ,f :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" grep
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

vnoremap ,f :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  normal! `<v`>y
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


"" Buffer nav
noremap <silent> ,q :bp<CR>
noremap <silent> ,e :bn<CR>
noremap <silent> ,c :bd<CR>
noremap <silent> <C-w> :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

autocmd BufNewFile,BufRead *.go setlocal listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

" go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
autocmd Filetype gohtmltmpl setlocal ts=2 sw=2 expandtab
" autocmd BufWritePre *.go :CocCommand editor.action.organizeImport
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

function! g:IfErr() " go get -u github.com/koron/iferr
  let bpos = wordcount()['cursor_bytes']
  let out = systemlist('goret -pos ' . bpos, bufnr('%'))
  if len(out) == 0
    return
  endif
  return out[0]
endfunction

command! -buffer -nargs=0 IfErr call s:IfErr()

" html
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab

" Syntax highlight
let g:polyglot_disabled = ['python']


" rust
autocmd BufNewFile,BufRead *.rs setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" Vim racer
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

"*****************************************************************************
"" Statusline Modifications
"*****************************************************************************

" Left side
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ 
set statusline+=%2*\ %{get(g:,'coc_git_status')}%{get(b:,'coc_git_status')}
set statusline+=%6*\ %f%m%r%h%w
set statusline+=%=
" Right side
set statusline+=%2*\ %{&ff}\/%Y\ 
set statusline+=%5*%3p%%,\ %3l:%-3c
set statusline+=%7*%{Check_mixed_indent_file()}

hi User1 cterm=bold  ctermbg=25  ctermfg=189 gui=bold guibg=#853e64 guifg=#121212
hi User2 ctermbg=235 ctermfg=189 guibg=#262626  guifg=#d7d7ff
hi User3 ctermbg=235 ctermfg=25 guibg=#262626 guifg=#6981c5
hi User4 ctermbg=0 ctermfg=235 guibg=#000000 guifg=#262626
hi User5 ctermbg=25  ctermfg=189 guibg=#853e64 guifg=#121212
hi User6 cterm=italic ctermbg=0  ctermfg=133 guibg=#161616 guifg=#853e64
hi User7 cterm=bold ctermbg=209  ctermfg=0 guibg=#ca754b guifg=#121212

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! Check_mixed_indent_file()
  let head_spc = '\v(^ +)'
  let indent_tabs = search('\v(^\t+)', 'nw')
  let indent_spc  = search(head_spc, 'nw')
  if indent_tabs > 0 && indent_spc > 0
    return printf(" Mix tab:%d spc:%d ", indent_tabs, indent_spc)
  else
    return ''
  endif
endfunction
