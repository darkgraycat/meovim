--[[ ^w^ MeoVim ^w^ ]]--

--[[ #keymaps ]]--
local keymaps = {
  -- control
  { { "i", "c" }, "jk", "<Esc>" },
  { "i", "<C-c>", "<Esc>" },
  { "i", "<C-Space>", "<C-N>" },
  { { "n", "v" }, "<C-d>", "<C-d>zz" },
  { { "n", "v" }, "<C-u>", "<C-u>zz" },
  { { "n", "v" }, "<C-j>", "5jzz" },
  { { "n", "v" }, "<C-k>", "5kzz" },
  { "v", "<leader>y", [["+y]] },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  -- menus
  { { "n", "v" }, "<C-\\>", ":Lex<CR>" },
  { { "n", "v" }, "<C-/>", ":Lex!<CR>" },
  -- move line
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- parenthesis
  { "i", "[[", "[]<left>" }, { "v", "[[", "<Esc>`>a]<Esc>`<i[" },
  { "i", "((", "()<left>" }, { "v", "((", "<Esc>`>a)<Esc>`<i(" },
  { "i", "{{", "{}<left>" }, { "v", "{{", "<Esc>`>a}<Esc>`<i{" },
  { "i", "''", "''<left>" }, { "v", "''", "<Esc>`>a'<Esc>`<i'" },
  { "i", '""', '""<left>' }, { "v", '""', '<Esc>`>a"<Esc>`<i"' },
  { "i", "/*", "/**/<left><left>" }, { "v", "/*", "<Esc>`>a*/<Esc>`<i/*" },
  -- split window control
  { "n", "<A-Right>", ":vertical resize +3<CR>"},
  { "n", "<A-Left>", ":vertical resize -3<CR>"},
  { "n", "<A-Down>", ":horizontal resize +3<CR>"},
  { "n", "<A-Up>", ":horizontal resize -3<CR>"},
  -- tabs control
  {"n", "<A-=>", ":tabnew<CR>"},
  {"n", "<A-->", ":tabclose<CR>"},
  {"n", "<A-[>", ":tabprevious<CR>"},
  {"n", "<A-]>", ":tabnext<CR>"},
  -- buffer control
  {"n", "<Tab>", ":bnext <CR>"},
  {"n", "<S-Tab>", ":bprevious <CR>"},
  {"n", "<A-Tab>", ":bdelete! <CR>"},
}

--[[ #globals ]]--
local globals = {
  mapleader = " ",
  netrw_banner = 0,
  netrw_liststyle = 3,
  netrw_browse_split = 4,
  netrw_showhide = 1,
  netrw_winsize = 25,
}

--[[ #options ]]--
local options = {
  -- indent
  wrap = false,
  autoindent = true,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  shiftround = true,
  expandtab = true,
  -- fold
  foldenable = true,
  foldcolumn = "0",
  foldlevel = 99,
  foldlevelstart = 99,
  foldmethod = "indent",
  -- look
  background = "dark",
  termguicolors = true,
  number = true,
  relativenumber = true,
  showmode = true,
  showcmd = true,
  cmdheight = 2,
  showtabline = 2,
  laststatus = 2,
  signcolumn = "yes",
  scrolloff = 8,
  sidescrolloff = 8,
  pumheight = 8,
  cursorline = true,
  -- search
  ignorecase = true,
  smartcase = true,
  hlsearch = false,
  incsearch = true,
  -- other
  autowrite = true,
  backup = false,
  title = true,
  swapfile = false,
  syntax = "ON",
  mouse = "a",
  backspace = "indent,eol,start",
  completeopt = "menu,menuone,noselect",
  splitright = true,
  splitbelow = true,
  fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]],
}

--[[ #helpers ]]--
local helpers = {
  apply_settings = function (globals, options)
    for global, value in pairs(globals) do vim.g[global] = value end
    for option, value in pairs(options) do vim.opt[option] = value end
  end,
  apply_keymaps = function (keymaps)
    for _, m in pairs(keymaps) do
      vim.keymap.set(m[1], m[2], m[3], { noremap = true, silent = true, desc = m[4] } )
    end
  end
}

--[[ #plugins ]]--
-- lazy
-- telescope
-- treesitter
-- lualine
-- lsp 
-- cmp
-- terminal
-- oil

--[[ #configure ]]--
vim.cmd[[set path+=**]]
vim.cmd[[autocmd VimResized * :wincmd =]]
vim.cmd[[autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif]]
vim.cmd[[colorscheme slate]]
vim.cmd[[set wildmenu]]

helpers.apply_settings(globals, options)
helpers.apply_keymaps(keymaps)
