--[[ ^w^ MeoVim ^w^ ]]--

print("MeoV!")

--[[ #keymaps ]]--
local keymaps = {
  -- control
  { { "i", "c" }, "jk", "<Esc>" },
  { "i", "<C-c>", "<Esc>" },
 	{ { "n", "v" }, "<C-d>", "<C-d>zz" },
	{ { "n", "v" }, "<C-u>", "<C-u>zz" },
  { "v", "<leader>y", [["+y]] },
  { "n", "<leader>e", ":25Lex<CR>" },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  { "v", "<leader>s", ":sort<CR>" },

  -- move line
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- parenthesis
  { "i", "[[", "[]<left>" }, { "v", "[[", "<Esc>`>a]<Esc>`<i[" },
  { "i", "((", "()<left>" }, { "v", "((", "<Esc>`>a)<Esc>`<i(" },
  { "i", "{{", "{}<left>" }, { "v", "((", "<Esc>`>a}<Esc>`<i{" },
  { "i", "''", "''<left>" }, { "v", "''", "<Esc>`>a'<Esc>`<i'" },
  { "i", '""', '""<left>' }, { "v", '""', '<Esc>`>a"<Esc>`<i"' },
  { "i", "/*", "/**/<left><left>" }, { "v", "/*", "<Esc>`>a*/<Esc>`<i/*" },
  -- split window control
  { "n", "<C-Left>", ":vertical resize +3<CR>"},
  { "n", "<C-Right>", ":vertical resize -3<CR>"},
  { "n", "<C-Up>", ":horizontal resize +3<CR>"},
  { "n", "<C-Down>", ":horizontal resize -3<CR>"},
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
  netrw_browse_split = 4,
  netrw_altv = 1,
  netrw_liststyle = 3,
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
  scrolloff = 12,
  sidescrolloff = 8,
  pumheight = 10,
  -- search
  ignorecase = true,
  smartcase = true,
  hlsearch = false,
  incsearch = true,
  -- other
  title = true,
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









--[[ #configure ]]--
helpers.apply_settings(globals, options)
helpers.apply_keymaps(keymaps)
vim.cmd('colorscheme habamax')
vim.cmd('set wildmenu')