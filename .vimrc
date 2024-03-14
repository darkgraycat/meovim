let g:mapleader=" "
let g:netrw_banner=0
let g:netrw_altv=0
let g:netrw_alto=0
let g:netrw_preview=1
let g:netrw_winsize=25
let g:netrw_liststyle=3
let g:netrw_browse_split=2
" search
set smartcase noignorecase
set incsearch nohlsearch
" indent
set expandtab tabstop=2 softtabstop=2
set shiftround shiftwidth=2
set autoindent smartindent
" behavior
set nocompatible noerrorbells
set noswapfile nobackup
set splitright splitbelow
set scrolloff=8 sidescrolloff=8
set virtualedit=onemore
set backspace=indent,eol,start
set completeopt=noinsert,menuone
set foldenable foldlevel=8 foldmethod=indent
set wildmenu wildignorecase pumheight=8
set timeout timeoutlen=500
set path+=**" mouse=a
" look
syntax on
set title
set termguicolors background=dark
set number relativenumber
set nowrap noshowmode nocursorline
set showtabline=2
set signcolumn=no
colorscheme base16-kanagawa
" chars
set list listchars=multispace:·\ ,tab:⬄\ 
set fillchars=eob:\ ,fold:\ ,
set statusline=\ [%{mode()}]\ %f\ %m\ %h%w\ %=%y\ %l:%c\ [%p%%]\ 
" mappings
inoremap jk <Esc>
inoremap <C-BS> <Right><BS>
inoremap <C-CR> <Esc>O
inoremap <C-h> <Esc>Bi
inoremap <C-l> <Esc>Ea
vnoremap <Leader>y "+y
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '>-2<CR>gv=gv
 noremap <C-d> <C-d>zz
 noremap <C-u> <C-u>zz
 noremap <C-j> 5j
 noremap <C-k> 5k
 noremap <C-h> B
 noremap <C-l> E
" auto close pair brackets
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>
inoremap <expr> ) getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
inoremap <expr> ] getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
inoremap <expr> } getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
inoremap <expr> > getline('.')[col('.')-1]==#'>' ? '<Right>' : '>'
" auto close strings
inoremap <expr> ' getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
inoremap <expr> " getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
" auto indent on CR
inoremap <expr> <CR> getline('.')[col('.')-2]=~'[\(\{\[]' ? '<CR><Esc>O' : '<CR>'
" tabs & buffers & splits
nnoremap <silent> §         :bn<CR>
nnoremap <silent> ±         :bp<CR>
nnoremap <silent> d§        :<C-U>bp <bar> bd #<CR>
nnoremap <silent> <A-=>     :tab sb<CR>
nnoremap <silent> <A-]>     :tabn<CR>
nnoremap <silent> <A-[>     :tabp<CR>
nnoremap <silent> <A-Up>    :horizontal resize +4<CR>
nnoremap <silent> <A-Down>  :horizontal resize -4<CR>
nnoremap <silent> <A-Left>  :vertical resize +4<CR>
nnoremap <silent> <A-Right> :vertical resize -4<CR>
" navigation
nnoremap <silent> <C-\>      <cmd>split term://zsh<CR>
nnoremap <silent> <Leader>e  <cmd>Lex<CR>
nnoremap <silent> <Leader>g  <cmd>split term://lazygit<CR>
nnoremap <silent> <Leader>r  <cmd>split term://ranger<CR>
tnoremap <silent> <C-\>      <C-\><C-n>:bd!<CR>
tnoremap <silent> <Esc><Esc> <C-\><C-n>
" autocmd
autocmd InsertCharPre * if !pumvisible() && v:char=~#'[a-zA-Z]'|call feedkeys("\<C-x>\<C-n>")|endif
autocmd WinEnter      * if winnr('$')==1 && getbufvar(winbufnr(winnr()), '&filetype') == 'netrw'|q|endif
autocmd VimLeave      * if confirm("Save session?", "&Yes\n&No", 2)==1|call SessionsHandler('save')|endif
autocmd VimEnter      * if confirm("Load session?", "&Yes\n&No", 2)==1|call SessionsHandler('load')|endif
autocmd TermOpen      * setlocal nonu nornu|:startinsert!
autocmd VimResized    * wincmd =
function! SessionsHandler(mode)
  let dir = stdpath('config')."/.sessions/"
  let fname = dir.substitute(getcwd(),'/','_','g').'.vim'
  if a:mode=='save'|call mkdir(dir,"p")|redraw!|exe "mksession! ".fname|endif
  if a:mode=='load'&&filereadable(fname)|exe "source".fname|endif
endfunction
