" meovim minimal (mvm)

filetype plugin on
set nocompatible
let g:mapleader=" "
let g:netrw_banner=0
let g:netrw_liststyle=0
let g:netrw_use_errorwindow=0
let g:mvm_transparent_bg=0
" search
set smartcase noignorecase
set incsearch nohlsearch
" indent
set shiftwidth=4 tabstop=4 softtabstop=4
set expandtab shiftround
set autoindent smartindent
" behavior
set noswapfile nobackup
set splitright splitbelow
set foldenable foldlevel=8 foldmethod=indent
set scrolloff=8 sidescrolloff=8
set complete+=k completeopt=noinsert,menuone,menu
set backspace=indent,eol,start
set omnifunc=syntaxcomplete#Complete
set wildmenu wildmode=full wildcharm=<C-n> 
set wildignorecase wildignore+=**/build/**,**/dist/**,**/node_modules/**,**/vendor/**
set sessionoptions+=localoptions
set virtualedit=onemore
set updatetime=2000
set path+=** mouse=a
" look
syntax on
set title
set termguicolors background=dark
set number relativenumber signcolumn=no
set nowrap noshowmode nocursorline
set showtabline=2 pumheight=8
" chars
set list listchars=multispace:·\ ,tab:⬄\ ,
set fillchars=eob:\ ,fold:\ ,
set statusline=\[%{ModeCurr()}]\ %n:%{%len(getbufinfo({'buflisted':1}))%}\ %f\ %m\ %=%y\ %l:%c\ [%p%%]

" keys@shortcuts
inoremap jk <Esc>
 noremap <C-j> 5j
 noremap <C-k> 5k
 noremap <C-d> <C-d>zz
 noremap <C-u> <C-u>zz
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '>-2<CR>gv=gv
nnoremap <silent> X f,a<CR><Esc>
vnoremap <Leader>y "+y
vnoremap <Leader>p "_dP
nnoremap <Leader>r "hyiw:s/<C-r>h//g<Left><Left>
vnoremap <Leader>r "hy:%s/<C-r>h//gc<Left><Left><Left>
nnoremap <silent> <Leader>w :update<CR>
nnoremap ;; :s/\v
inoremap ;; <Esc>==A;<Esc>
    nmap vv va%
nnoremap <expr> gcc getline('.')[match(getline('.'),'\S'):match(getline('.'),'\S')+2]==#'// ' ? '^df ' : '^i// <Esc>'
vnoremap gcc :normal gcc<CR>
" keys@remap
     map <C-z> <Nop>
     map q: <Nop>
" keys@autopair
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap <expr> ) getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
inoremap <expr> ] getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
inoremap <expr> } getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
inoremap <expr> ' getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
inoremap <expr> " getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
inoremap <expr> <CR> (getline('.')[col('.')-2:col('.')-1]=~#'\v(\<\>\|[]\|\{\}\|\(\))') ? '<CR><Esc>O' : '<CR>'
inoremap <expr> <BS> (getline('.')[col('.')-2:col('.')-1]=~#'\v(''''\|""\|[]\|\{\}\|\(\))') ? '<BS><Del>' : '<BS>'
" keys@surround
vnoremap {} <Esc>`>a}<Esc>`<i{<Esc>gv
vnoremap [] <Esc>`>a]<Esc>`<i[<Esc>gv
vnoremap () <Esc>`>a)<Esc>`<i(<Esc>gv
vnoremap "" <Esc>`>a"<Esc>`<i"<Esc>gv
vnoremap '' <Esc>`>a'<Esc>`<i'<Esc>gv
vnoremap `` <Esc>`>a`<Esc>`<i`<Esc>gv
nnoremap <> "hyiw:s/<C-r>h/<<C-r>h><\/<C-r>h>/<CR>f>a
" keys@navigation 
nnoremap <silent> <C-w>n      :bn<CR>
nnoremap <silent> <C-w>p      :bp<CR>
nnoremap <silent> <C-w>d      :<C-U>bp <bar> bd #<CR>
nnoremap <silent> <C-w><C-n>  :tabn<CR>
nnoremap <silent> <C-w><C-p>  :tabp<CR>
nnoremap <silent> <C-w><C-d>  :tabclose<CR>
nnoremap <silent> <C-w><C-t>  :tab sb<CR>
nnoremap <silent> <A-Up>      :horizontal resize +4<CR>
nnoremap <silent> <A-Down>    :horizontal resize -4<CR>
nnoremap <silent> <A-Left>    :vertical resize -4<CR>
nnoremap <silent> <A-Right>   :vertical resize +4<CR>
" keys@terminal
nnoremap <silent> <C-\>     :split term://zsh<CR>
tnoremap <silent> <C-\>     <C-\><C-n>:bd!<CR>
tnoremap <silent> <C-w>     <C-\><C-n><C-w>
" keys@tools
nnoremap <silent> <Leader>e :Ex<CR>
nnoremap <silent> <Leader>tf <cmd>term fzf<CR>:startinsert!<CR>
nnoremap <silent> <Leader>tg <cmd>term lazygit<CR>:startinsert!<CR>
nnoremap <silent> <Leader>tr <cmd>term ranger<CR>:startinsert!<CR>
nnoremap <C-p> :e <C-n>
nnoremap <C-e> :Lex 25<CR>
nnoremap <Leader>b :buffer <C-n>
nnoremap <Leader>f "hyiw:vimgrep /<C-r>h/gj **/*.{js,ts,rs,go,php}<CR>:copen<CR>
vnoremap <Leader>f "hy:vimgrep /<C-r>h/gj **/*.{js,ts,rs,go,php}<CR>:copen<CR>
nnoremap <silent> <C-x> :call ToggleQuickFix()<CR>

" handlers
function! Session(mode)
    let dir = stdpath('config').'/.sessions/'
    let fname = dir.substitute(getcwd(),'/','_','g').'.vim'
    if a:mode=='save'|call mkdir(dir,"p")|redraw!|exe 'mksession!' fname|endif
    if a:mode=='load'&&filereadable(fname)|exe 'source' fname|endif
endfunction

function! NoneBG()
    hi Normal guibg=None
    hi LineNr guibg=None
    hi VertSplit guibg=None
endfunction

function! ModeCurr()
    return get({
    \ 'n': 'Normal',
    \ 'v': 'Visual',
    \ 'V': 'V-Line',
    \ "\<C-v>": 'V-Block',
    \ 'i': 'Insert',
    \ 'R': 'Replace',
    \ 'c': 'Command'}, mode(), 'Unknown')
endfunction

function! GetWindowId(type)
    for win in range(1, winnr('$'))
        if win_gettype(win) == a:type
            return win_getid(win)
        endif
    endfor
    return -1
endfunction

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen|exe 'wincmd p'
    else
        cclose
    endif
endfunction

" autocmds
augroup MeoVim
  autocmd!
  autocmd VimResized            *         wincmd =
  autocmd TermOpen              *         setlocal nonu nornu
  autocmd WinEnter              *         if winnr('$')==1 && getbufvar(winbufnr(winnr()),'&filetype')=='netrw'|q|endif
  autocmd InsertCharPre         *         if !pumvisible() && v:char=~#'[a-zA-Z]'|call feedkeys("\<C-x>\<C-n>")|endif
  autocmd BufWinEnter,WinEnter  term://*  startinsert!
augroup END

" commands
command! -nargs=0 MVSourceConfig  so ~/.config/nvim/.vimrc
command! -nargs=+ MVGrep          exe 'vimgrep /<args>/gj **/*'|copen
command! -nargs=1 MVYankCmd       let @+=system('<args>')
command! -nargs=1 MVSession       call Session('<args>')
command! -nargs=0 MVNoneBG        call NoneBG()

colorscheme tokyo-night
finish
