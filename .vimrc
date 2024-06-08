filetype plugin on
set nocompatible
let g:mapleader=" "
let g:netrw_banner=0
let g:netrw_use_errorwindow=0
let g:mvm_transparent_bg=1
" search
set smartcase noignorecase
set incsearch nohlsearch
" indent
set expandtab tabstop=2 softtabstop=2
set shiftround shiftwidth=2
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
colorscheme base16-kanagawa
" chars
set list listchars=multispace:·\ ,tab:⬄\ ,
set fillchars=eob:\ ,fold:\ ,
set statusline=\[%{ModeCurr()}]\ %n:%{%len(getbufinfo({'buflisted':1}))%}\ %f\ %m\ %=%y\ %l:%c\ [%p%%]
" mappings
inoremap jk <Esc>
inoremap <C-h> <Esc>Bi " do i really need this kmap?
inoremap <C-l> <Esc>Ea " do i really need this kmap?
vnoremap <Leader>y "+y
vnoremap <Leader>p "_dP
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '>-2<CR>gv=gv
 noremap <C-d> <C-d>zz
 noremap <C-u> <C-u>zz
 noremap <C-j> 5j
 noremap <C-k> 5k
 noremap <C-h> B
 noremap <C-l> E
 map <C-z> <Nop>
" autoclose pair symbols
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>
inoremap <expr> ) getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
inoremap <expr> ] getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
inoremap <expr> } getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
inoremap <expr> > getline('.')[col('.')-1]==#'>' ? '<Right>' : '>'
inoremap <expr> ' getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
inoremap <expr> " getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
" insert mode
inoremap <expr> <CR> getline('.')[col('.')-2]=~'[\(\{\[]' ? '<CR><Esc>O' : '<CR>'
inoremap <A-CR> <CR><Esc>O
inoremap <A-BS> <Right><BS>
" surround
nnoremap <> "hyiw:s/<C-r>h/<<C-r>h><\/<C-r>h>/<CR>f>a
vnoremap {} <Esc>`>a}<Esc>`<i{<Esc>gv
vnoremap [] <Esc>`>a]<Esc>`<i[<Esc>gv
vnoremap () <Esc>`>a)<Esc>`<i(<Esc>gv
vnoremap "" <Esc>`>a"<Esc>`<i"<Esc>gv
vnoremap '' <Esc>`>a'<Esc>`<i'<Esc>gv
vnoremap `` <Esc>`>a`<Esc>`<i`<Esc>gv
" tabs & buffers & splits
nnoremap <silent> §         :bn<CR>
nnoremap <silent> ±         :bp<CR>
nnoremap <silent> d§        :<C-U>bp <bar> bd #<CR>
nnoremap <silent> <A-=>     :tab sb<CR>
nnoremap <silent> <A-]>     :tabn<CR>
nnoremap <silent> <A-[>     :tabp<CR>
nnoremap <silent> <A-Up>    :horizontal resize +4<CR>
nnoremap <silent> <A-Down>  :horizontal resize -4<CR>
nnoremap <silent> <A-Left>  :vertical resize -4<CR>
nnoremap <silent> <A-Right> :vertical resize +4<CR>
" tools
nnoremap <silent> <Leader>e :Ex<CR>
nnoremap <silent> <Leader>g :split term://lazygit<CR>
nnoremap <silent> <Leader>r :split term://ranger<CR>
nnoremap <silent> <Leader>f :split term://mvm $(fzf)<CR>
nnoremap <silent> <C-\>     :split term://zsh<CR>
tnoremap <silent> <C-\>     <C-\><C-n>:bd!<CR>
tnoremap <silent> <C-w>     <C-\><C-n><C-w>
" shortcuts
nnoremap <A-f> "hyiw:vimgrep /<C-r>h/gj **/*.{js,ts,rs,hs,php}<CR>:copen<CR>
vnoremap <A-f> "hy:vimgrep /<C-r>h/gj **/*.{js,ts,rs,hs,php}<CR>:copen<CR>
nnoremap <A-s> "hyiw:s/<C-r>h//g<Left><Left>
vnoremap <A-s> "hy:%s/<C-r>h//gc<Left><Left><Left>
nnoremap <silent> <Leader>w :update<CR>
" wildmenu shortcuts
nnoremap <A-f> :find *
nnoremap <A-b> :buffer <C-n>
" autocmds
augroup MeoVim
  au!
  au VimResized    * wincmd =
  au TermOpen      * setlocal nonu nornu
  au BufWinEnter,WinEnter term://* startinsert!
  au WinEnter      * if winnr('$')==1 && getbufvar(winbufnr(winnr()),'&filetype')=='netrw'|q|endif
  au InsertCharPre * if !pumvisible() && v:char=~#'[a-zA-Z]'|call feedkeys("\<C-x>\<C-n>")|endif
""  au InsertCharPre * if !pumvisible() && v:char=~#'[a-zA-Z]'|call feedkeys("\<C-x>\<C-l>")|endif
""  au VimLeave      * if confirm("Save session?", "&Yes\n&No", 2)==1|call Session('save')|endif
""  au VimEnter      * if confirm("Load session?", "&Yes\n&No", 2)==1|call Session('load')|endif
augroup END
" commands
command! -nargs=0 MVRefresh   so ~/.config/nvim/.vimrc
command! -nargs=+ MVGrep      exe 'vimgrep /<args>/gj **/*'|copen
command! -nargs=1 MVYankCmd   let @+=system('<args>')
command! -nargs=1 MVSession   call Session('<args>')
command! -nargs=0 MVNoneBG    call NoneBG()
func! Session(mode) " mode load|save
  let dir = stdpath('config').'/.sessions/'
  let fname = dir.substitute(getcwd(),'/','_','g').'.vim'
  if a:mode=='save'|call mkdir(dir,"p")|redraw!|exe 'mksession!' fname|endif
  if a:mode=='load'&&filereadable(fname)|exe 'source' fname|endif
endfunc
func! NoneBG()
  hi Normal guibg=None
  hi LineNr guibg=None
  hi VertSplit guibg=None
endfunc
func! ModeCurr()
  return get({
  \ 'n': 'Normal',
  \ 'v': 'Visual',
  \ 'V': 'V-Line',
  \ "\<C-v>": 'V-Block',
  \ 'i': 'Insert',
  \ 'R': 'Replace',
  \ 'c': 'Command'}, mode(), 'Unknown')
endfunc
" user customizations
set showcmd showcmdloc=statusline
" set statusline=\%#DiffText#▌[%{mode()}]▐%#DiffDelete#\ %n:%{%len(getbufinfo({'buflisted':1}))%}\ %*
" set statusline+=▌%q%a\ %=%y%m%f%=▐%#DiffDelete#\ %l:%c\ %#DiffAdd#▌%S[%p%%]▐%*
" colorscheme base16-atelier-sulphurpool

" test lua usage
lua << EOF
print('Hello from internal lua')
print('Hello from internal lua')
print('Hello from internal lua')
print('Hello from internal lua')
print('Hello from internal lua')
EOF
luafile ~/.config/nvim/test_how_vimrc_can_use.lua



" exit config
finish







""snippets using macro
let @a = 'oasync () => {'
" snippets kinda
iabbrev  @f  for(; ; )<C-O>4<Left>

inoreabbrev  @F for (let i = 0; i <= *; i++) {} <C-O>T*<BS><BS>
inoreabbrev  @I if (*) {} <C-O>T*<BS>

"" TODO remap <C-f> and <C-b> - its only scrolls page up and down
"" TODO remap <C-e> and <C-y> - its only scrolls page up and down

"" just check how it works
""snippet structure
""autocmd FileType |my-filetype| inorea <buffer> |my-sippet<c-a>| |my-expansion|
""augroup haml
""  autocmd!
""  autocmd FileType haml inorea <buffer> 
""        \ table %table<CR>%thead<CR>%tr<CR>%th {%header row%}<CR><BS><BS>%tbody<CR>%tr<CR>%td {%body row%}
""augroup END
""nnoremap <Plug>GoToNextPlaceholder :call search('{%[^%]*%}')<CR>va{
"""" expand: originaly <C-q><C-e>
""imap <silent> <C-e><C-t> <C-v><C-a><C-]><Esc><Plug>GoToNextPlaceholder
"""" go next: originaly <C-q><C-q>
""nmap <silent> <C-e><C-e> <Plug>GoToNextPlaceholder
""imap <silent> <C-e><C-e> <Esc><Plug>GoToNextPlaceholder
""vmap <silent> <C-e><C-e> <Esc><Plug>GoToNextPlaceholder

"" it conflicts because feedkeys used
augroup haml
  autocmd!
  autocmd FileType haml inorea <buffer> 
        \ table %table<CR>%thead<CR>%tr<CR>%th {%header row%}<CR><BS><BS>%tbody<CR>%tr<CR>%td {%body row%}
augroup END
nnoremap <Plug>GoToNextPlaceholder :call search('{%[^%]*%}')<CR>va{
imap <silent> <C-s><C-e> <C-v><C-a><Esc><Plug>GoToNextPlaceholder
nmap <silent> <C-s><C-s> <Plug>GoToNextPlaceholder
imap <silent> <C-s><C-s> <Esc><Plug>GoToNextPlaceholder
vmap <silent> <C-s><C-s> <Esc><Plug>GoToNextPlaceholder

""nmap <silent> ;; <Plug>GoToNextPlaceholder
""imap <silent> ;; <Esc><Plug>GoToNextPlaceholder
""vmap <silent> ;; <Esc><Plug>GoToNextPlaceholder

function! MyCompletionFunction(findstart, base)
    if a:findstart
        let line = getline('.')
        let start = col('.') - 1
        return start - strridx(line, a:base, start)
    else
        let completions = getcompletion(a:base, 'buffer')
        if !empty(completions)
            call complete(col('.'), completions)
            " Uncomment the appropriate line below
            " call feedkeys("\<C-n>") " For <C-x><C-n> behavior
            call feedkeys("\<C-l>")   " For <C-x><C-l> behavior
        endif
        return []
    endif
endfunction
""set completefunc=MyCompletionFunction
""au! InsertCharPre * if !pumvisible() && v:char =~# '\a'|call complete_info([])|endif
""au! InsertCharPre * if !pumvisible() && v:char =~# '\a' | call MyCompletionFunction(0, matchstr(getline('.'), '\k*$')) | endif

""au! InsertCharPre * if !pumvisible() && v:char=~#'[a-zA-Z]'|call complete_info([])|endif

""augroup Snippets
""  au!
""  au FileType typescript inorea <buffer>
""        \ for for (let {%i%} = 0; {%i%} < {%length%}; {%i%}++) {<CR>}
""augroup END

""nnoremap <Plug>GoToNextPlaceholder :call search('{%[^%]*%}')<CR>va{
""imap <silent> <C-e><C-e> <C-v><C-a><C-]><Esc><Plug>GoToNextPlaceholder
""nmap <silent> ;;    <Plug>GoToNextPlaceholder
""imap <silent> ;;    <Esc><Plug>GoToNextPlaceholder
""vmap <silent> ;;    <Esc><Plug>GoToNextPlaceholder

""inoremap ;; <esc>/{%[^%]*%}<cr>v/%}<cr><right>c
""inoremap ;; <Esc>/%}/e<CR>c%
""inoremap ;; <esc>:call search('{%[^%]*%}', 'zW')<cr>c%
""
""au! FileType go noreabbr fnc func {% <funcName> %} ({% <params> %}){% <returnType> %}{{% <funcBody> %}}



"" usage of complete function
	inoremap <F5> <C-R>=ListMonths()<CR>
	func! ListMonths()
	  call complete(col('.'), ['January', 'February', 'March',
		\ 'April', 'May', 'June', 'July', 'August', 'September',
		\ 'October', 'November', 'December'])
	  return ''
	endfunc

" Enable Python support
""python << EOF
""import vim
""
""def show_completions():
""    base = vim.call('escape', vim.eval('matchstr(getline("."), "\\k*\\%#\\k*")'), '\\')
""    if base:
""        completions = vim.call('getcompletion', base, 'buffer')
""        if completions:
""            vim.call('complete_info', completions)
""
""vim.command('inoremap <silent> <C-Space> <C-r>=show_completions()<CR>')
""EOF

""inoremap <F5> <C-R>=ShowCompletions()<CR>
inoremap <C-Space> <C-R>=ShowCompletions()<CR>
function! ShowCompletions()
  echom "start"
  ""let base = matchstr(getline("."), '\\k*\\%#\\k*')
  let base = escape(matchstr(getline("."), '\\k*\\%#\\k*'), '\\')
  echom "before if"
  echom base
  echom "inside if"
  let completions = getcompletion(base, 'buffer')
  if len(completions) > 0
    echom "has completions"
    echom completions
    ""call complete_info(completions)
    call complete(col('.'), completions)
  endif
  return ''
endfunction


function! DoSome()
  echom "LALALAL"
  echom "LALALAL"
  echom "LALALAL"
endfunction

