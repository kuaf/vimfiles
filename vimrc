" Vim profile
" Author: yal <kuaf.lee@gmail.com>
" Last Change: July 9, 2011
"
" This script is inspired by Vim Guru, special thanks to
" - Steve Francia <steve.francia@gmail.com> (https://github.com/spf13/spf13-vim)
" - Peter Odding <peter@peterodding.com> (http://peterodding.com/code/vim/profile/vimrc)
"

" Environment {{{1

" Environment # Basics {{{2
set nocompatible  " must be first line
set background=dark  " Assume a dark background

" Environment # Setup Bundle Support {{{2
" The next two lines ensure that the ~/.vim/bundle/ system works

silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()


" General {{{1

set background=dark  " Assume a dark background

if !has('win32') && !has('win64')
    set term=$TERM  " Make arrow and other keys work
endif

filetype plugin indent on " Automatically detect file types.
syntax on " syntax highlighting
set mouse=a
scriptencoding utf-8
set autowrite  " automatically write a file when leaving a modified buffer
set viewoptions=folds,options,cursor,unix,slash  " better unix / windows compatibility
set virtualedit=all  " allow for cursor beyond last character
set history=1000  " Store a ton of history (default is 20)
"set spell  " spell checking on

" Setting up the directories {{{2
set backup
set backupdir=$HOME/tmp
set directory=$HOME/tmp
"set viewdir=~/.vim/view
"au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview  "make vim load view (state) (folds, cursor, etc)

" Vim UI {{{1

if has('gui_running')
  set background=light
else
  set background=dark
endif

color solarized  " load a colorscheme
set tabpagemax=15  " only show 15 tabs
set showmode  " display the current mode
set cursorline  " highlight current line

if has('cmdline_info')
  set ruler  " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd  " show partial commands in status line and
               " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\  " Filename
  set statusline+=%w%h%m%r  " Options
  "set statusline+=%{fugitive#statusline()}  "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]  " filetype
  set statusline+=\ [%{getcwd()}]  " current dir
  set statusline+=\ [A=\%03.3b/H=\%02.2B]  " ASCII / Hexadecimal value of char
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " backspace for dummys
set linespace=0  " No extra spaces between rows
set nu  " Line numbers on
set showmatch  " show matching brackets/parenthesis
set incsearch  " find as you type search
set hlsearch  " highlight search terms
set winminheight=0  " windows can be 0 line high
set ignorecase  " case insensitive search
set smartcase  " case sensitive when uc present
set wildmenu  " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]  " backspace and cursor keys wrap to
set scrolljump=5  " lines to scroll when cursor leaves screen
set scrolloff=3  " minimum lines to keep above and below cursor
set foldenable  " auto fold code
set gdefault  " the /g flag on :s substitutions by default
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" Formatting {{{1

set nowrap  " wrap long lines
set autoindent  " indent at the same level of the previous line
set shiftwidth=2  " use indents of 4 spaces
set expandtab  " tabs are spaces, not tabs
set tabstop=2  " an indentation every four columns
set softtabstop=2  " let backspace delete indent
"set matchpairs+=<:>  " match, to be used with %
"map <F12> :set invpaste<CR>
set pastetoggle=<F12>  " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType vim,c,cpp,java,php,js,python,twig,xml,yml,txt autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
set foldmethod=marker " foldopen=all,insert foldclose=all


" Automatic updating of "Last Change:" comments. {{{2

autocmd BufWritePre * call s:UpdateLastChangeDate()

function s:UpdateLastChangeDate()
  let pattern = '\<Last Change:\s\zs.*'
  let lnum = match(getline(1, 10), pattern)
  if lnum >= 0
    let existing = getline(lnum+1)
    echo existing
    let substitute = substitute(strftime('%B %e, %Y'), '\s\{2,}', ' ', 'g')
    let updated = substitute(existing, pattern, substitute, '')
    if updated !=# existing
      undojoin
      keepjumps call setline(lnum+1, updated)
    endif
  endif
endfunction

" Key (re)Mappings {{{1

" The default leader is '\', but many people prefer ',' as it's in a standard location
let mapleader=','
" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :
" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-K> <C-W>k<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$


map <F12> :set invpaste<CR>

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Insert new line
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>


" Plugins {{{1

" Solarized {{{2

call togglebg#map("<F5>")
let g:solarized_contrast='high'

" Vim-fakeclip {{{2

let g:fakeclip_no_default_key_mappings=1

if !has('clipboard')

  nmap <silent> <leader>y <Plug>(fakeclip-y)
  nmap <silent> <leader>Y <leader>y$
  nmap <silent> <leader>yy <Plug>(fakeclip-Y)
  vmap <silent> <leader>y <Plug>(fakeclip-y)
  vmap <silent> <leader>Y <Plug>(fakeclip-Y)

  nmap <silent> <leader>p <Plug>(fakeclip-p)
  nmap <silent> <leader>P  <Plug>(fakeclip-P)
  nmap <silent> <leader>gp  <Plug>(fakeclip-gp)
  nmap <silent> <leader>gP  <Plug>(fakeclip-gP)
  nmap <silent> <leader>]p  <Plug>(fakeclip-]p)
  nmap <silent> <leader>]P  <Plug>(fakeclip-]P)
  nmap <silent> <leader>[p  <Plug>(fakeclip-[p)
  nmap <silent> <leader>[P  <Plug>(fakeclip-[P)
  vmap <silent> <leader>p  <Plug>(fakeclip-p)
  vmap <silent> <leader>P  <Plug>(fakeclip-P)
  vmap <silent> <leader>gp  <Plug>(fakeclip-gp)
  vmap <silent> <leader>gP  <Plug>(fakeclip-gP)
  vmap <silent> <leader>]p  <Plug>(fakeclip-]p)
  vmap <silent> <leader>]P  <Plug>(fakeclip-]P)
  vmap <silent> <leader>[p  <Plug>(fakeclip-[p)
  vmap <silent> <leader>[P  <Plug>(fakeclip-[P)

"  map! <silent> <C-r>p  <Plug>(fakeclip-insert)
"  map! <silent> <C-r><C-r>p  <Plug>(fakeclip-insert-r)
"  map! <silent> <C-r><C-o>p  <Plug>(fakeclip-insert-o)
"  imap <silent> <C-r><C-p>p  <Plug>(fakeclip-insert-p)

endif

