set nocompatible
set number
set ruler
set hidden

syntax on

if has("win32")
  set directory=$TEMP
  set backupdir=$TEMP
  set list listchars=tab:\»\ ,trail:·
elseif has("mac")
  set list listchars=tab:\â‡¥\ ,trail:Â·
endif

" Whitespace stuff
set nowrap
if has("win32")
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
else
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
endif

set expandtab


" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set statusline=%<\ %n:%f\ %m%r%y\ [%{&ff}]%=%-35.(%l:%c\ %P(%L)\ \[0x%B]%)
set laststatus=2

" Leaderkey
let mapleader=","

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20


" CTags
map <Leader>t :TlistToggle<CR>
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10
" Default color scheme
color jellybeans+

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
