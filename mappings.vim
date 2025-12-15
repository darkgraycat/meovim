" keys@shortcuts
let g:mapleader=" "
inoremap jk                     <Esc>
inoremap <S-Enter>              <CR><Esc>O
 noremap <C-j>                  5j
 noremap <C-k>                  5k
 noremap <A-j>                  zj
 noremap <A-k>                  zk
 noremap <C-d>                  <C-d>zz
 noremap <C-u>                  <C-u>zz
vnoremap <silent> J             :m '>+1<CR>gv=gv
vnoremap <silent> K             :m '>-2<CR>gv=gv
nnoremap <silent> X             wbi<CR><Esc>f<space>l
vnoremap <Leader>y              "+y
vnoremap <Leader>p              "_dP
nnoremap <Leader>r              "hyiw:s/<C-r>h//g<Left><Left>
vnoremap <Leader>r              "hy:%s/<C-r>h//gc<left><left><left>
nnoremap <silent> <Leader>w     :update<CR>

inoremap ;;                     <Esc>==A;<Esc>
vnoremap ;;                     :s/\v
    nmap vv                     va%
nnoremap <expr> gcc             getline('.')[match(getline('.'),'\S'):match(getline('.'),'\S')+2]==#'// ' ? '^df gv==' : '^i// <Esc>'
vnoremap gcc                    :normal gcc<CR>
""TODO: move to commands
nnoremap <Leader>csl            :s/\([a-z]\)\([A-Z]\)/\1_\l\2/g<CR>
nnoremap <Leader>csw            viw:s/\C\%V\([a-z]\)\([A-Z]\)/\1_\l\2/g<CR>
nnoremap <Leader>ccl            :s/\(_\)\([a-z]\)/\U\2/g<CR>
nnoremap <Leader>ccw            viw:s/\C\%V\(_\)\([a-z]\)/\U\2/g<CR>
nnoremap <Leader>jq             :%!jq ''<left>
vnoremap <Leader>jq             :!jq ''<left>

nnoremap <C-c><C-c> vi
nnoremap <C-y><C-y> viw"+y
vnoremap <C-c><C-q> "qy

""TODO: move to commands
xnoremap <Leader>cts            :!column -ts ''<left>
xnoremap <Leader>ctr            :s/\,/\r/gc<Left><Left><Left><Left><Left><Left>

" keys@remap
     map <C-z> <Nop>
     map q: <Nop>
" keys@autopair
inoremap (                      ()<Left>
inoremap [                      []<Left>
inoremap {                      {}<Left>
inoremap <expr> )               getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
inoremap <expr> ]               getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
inoremap <expr> }               getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
inoremap <expr> '               getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
inoremap <expr> "               getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
inoremap <expr> <CR>            (getline('.')[col('.')-2:col('.')-1]=~#'\v(\<\>\|[]\|\{\}\|\(\))') ? '<CR><Esc>O' : '<CR>'
inoremap <expr> <BS>            (getline('.')[col('.')-2:col('.')-1]=~#'\v(''''\|""\|[]\|\{\}\|\(\))') ? '<BS><Del>' : '<BS>'

" keys@surround
vnoremap {}                     <Esc>`>a}<Esc>`<i{<Esc>gvolol
vnoremap []                     <Esc>`>a]<Esc>`<i[<Esc>gvolol
vnoremap ()                     <Esc>`>a)<Esc>`<i(<Esc>gvolol
vnoremap ""                     <Esc>`>a"<Esc>`<i"<Esc>gvolol
vnoremap ''                     <Esc>`>a'<Esc>`<i'<Esc>gvolol
vnoremap ``                     <Esc>`>a`<Esc>`<i`<Esc>gvolol
nnoremap <>                     "hyiwi<<C-r>h></<Esc>ea><Esc>F>a
inoremap >.                     <Esc>h"hyiwea></<C-r>h><Esc>F>a

" keys@navigation
nnoremap <silent> <C-w>n        :bn<CR>
nnoremap <silent> <C-w>p        :bp<CR>
nnoremap <silent> <C-w>d        :<C-U>bp <bar> bd #<CR>
nnoremap <silent> <C-w><C-n>    :tabn<CR>
nnoremap <silent> <C-w><C-p>    :tabp<CR>
nnoremap <silent> <C-w><C-d>    :tabclose<CR>
nnoremap <silent> <C-w><C-t>    :tab sb<CR>
nnoremap <silent> <A-Left>      :vertical resize -4<CR>
nnoremap <silent> <A-Down>      :horizontal resize -4<CR>
nnoremap <silent> <A-Right>     :vertical resize +4<CR>
nnoremap <silent> <A-Up>        :horizontal resize +4<CR>

" keys@terminal
nnoremap <silent> <C-\>         <cmd>lua require'FTerm'.toggle()<CR>
tnoremap <silent> <C-\>         <cmd>lua require'FTerm'.toggle()<CR>
nnoremap <silent> <A-\>         <cmd>term zsh<CR>:setlocal nonumber nornu<CR>:startinsert!<CR>
tnoremap <silent> <A-\>         <C-\><C-n>:bd!<CR>
tnoremap <silent> <C-w>         <C-\><C-n><C-w>

" keys@lsp
nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <C-k>         <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>cf             <cmd>lua vim.lsp.buf.format()<CR>
nnoremap <Leader>cr             <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>ca             <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>ce             <cmd>lua vim.diagnostic.open_float()<CR>

" keys@tools
nnoremap <silent> <C-e>         <cmd>lua require'oil'.toggle_float()<CR>
nnoremap <silent> <C-p>         <cmd>lua require'telescope.builtin'.find_files()<CR>
nnoremap <silent> <a-p>         <cmd>lua require'telescope.builtin'.commands()<CR>
nnoremap <silent> <C-g><C-h>    <cmd>lua require'gitsigns'.preview_hunk_inline()<CR>
nnoremap <silent> <C-g><C-b>    <cmd>lua require'gitsigns'.blame_line()<CR>
nnoremap <silent> <Leader>er    <cmd>lua require'FTerm'.run'ranger'<CR>
nnoremap <silent> <Leader>ee    <cmd>lua require'oil'.open()<CR>
nnoremap <silent> <Leader>fz    <cmd>term fzf<CR>:startinsert!<CR>
nnoremap <silent> <Leader>ft    <cmd>lua require'telescope.builtin'.builtin()<CR>
nnoremap <silent> <Leader>ff    <cmd>lua require'telescope.builtin'.find_files()<CR>
nnoremap <silent> <Leader>fg    <cmd>lua require'telescope.builtin'.live_grep()<CR>
nnoremap <silent> <Leader>fb    <cmd>lua require'telescope.builtin'.buffers()<CR>
nnoremap <silent> <Leader>fe    <cmd>lua require'telescope.builtin'.diagnostics()<CR>
nnoremap <silent> <Leader>fr    <cmd>lua require'telescope.builtin'.lsp_references()<CR>
nnoremap <silent> <Leader>fd    <cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
nnoremap <silent> <Leader>fS    <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>
nnoremap <silent> <Leader>fs    <cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>
nnoremap <silent> <Leader>fp    <cmd>lua require'telescope.builtin'.registers()<CR>
nnoremap <silent> <Leader>fm    <cmd>lua require'telescope.builtin'.marks()<CR>
nnoremap <silent> <Leader>fF    <cmd>lua require'telescope.builtin'.resume()<CR>
nnoremap <silent> <Leader>gg    <cmd>lua require'FTerm'.run'lazygit'<CR>
nnoremap <silent> <Leader>gdt   <cmd>lua require'gitsigns'.diffthis()<CR>
nnoremap <silent> <Leader>gbl   <cmd>lua require'gitsigns'.blame_line()<CR>
nnoremap <silent> <Leader>gbt   <cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>
nnoremap <silent> <Leader>ghh   <cmd>lua require'gitsigns'.preview_hunk()<CR>
nnoremap <silent> <Leader>ghr   <cmd>lua require'gitsigns'.reset_hunk()<CR>
nnoremap <silent> <Leader>ghn   <cmd>lua require'gitsigns'.next_hunk()<CR>
nnoremap <silent> <Leader>ghp   <cmd>lua require'gitsigns'.prev_hunk()<CR>
