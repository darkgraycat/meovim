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
  -- telescope
  { "n", "<C-p>", ":Telescope find_files<CR>", "Find files" },
  { "n", "<leader>fg", ":Telescope live_grep<CR>", "File grep" },
  { "n", "<leader>fb", ":Telescope buffers<CR>", "Opened buffers" },
  { "n", "<leader>de", ":Telescope diagnostics<CR>", "Show diagnostics" },
  { "n", "<leader>fGs", ":Telescope git_status<CR>", "Git status" },
  { "n", "<leader>fGc", ":Telescope git_stash<CR>", "Git stash" },
  { "n", "<leader>fGc", ":Telescope git_commits<CR>", "Git commits" },
  { "n", "<leader>fGd", ":Telescope git_bcommits<CR>", "Git current diff" },
  { "n", "<leader>fGb", ":Telescope git_branches<CR>", "Git branches" },
  { "n", "<leader>fd", ":Telescope lsp_definitions<CR>", "LSP definitions" },
  { "n", "<leader>fr", ":Telescope lsp_references<CR>", "LSP references" },
  { "n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", "LSP symbols" }
}

--[[ #globals ]]--
local globals = {
  mapleader = " ",
  netrw_banner = 0,
  netrw_liststyle = 3,
  netrw_browse_split = 4,
  netrw_showhide = 1,
  netrw_altv = 1,
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
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "folke/tokyonight.nvim" },
}, {})
-- telescope
-- treesitter
-- lualine
-- lsp 
-- cmp
-- terminal
-- oil

--[[ #configure ]]--
helpers.apply_settings(globals, options)
helpers.apply_keymaps(keymaps)
vim.cmd[[set path+=**]]
vim.cmd[[autocmd VimResized * :wincmd =]]
vim.cmd[[autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif]]
vim.cmd[[set wildmenu]]
vim.cmd[[colorscheme tokyonight-night]]
