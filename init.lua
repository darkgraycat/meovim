-- MeoVim --
print("Meov!")

-- helper functions
local meov = {
  keymap = function(...)
    for _, k in ipairs({...}) do
      vim.keymap.set(k[1], k[2], k[3], { noremap = true, silent = true, desc = k[4] } )
    end
  end,
}
-- define globals
vim.g.mapleader = " "
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
-- define options
local settings = {
  termguicolors = true,
  showmode = false,
  showcmd = false,
  backspace = "indent,eol,start",
  completeopt = "menu,menuone,noselect",

  splitright = true,
  splitbelow = true,
  scrolloff = 12,
  sidescrolloff = 8,

  wrap = false,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,

  signcolumn = "yes",
  number = true,
  relativenumber = true,

  hlsearch = false,
  incsearch = true,

  foldenable = true,
  foldcolumn = "0",
  foldlevel = 99,
  foldlevelstart = 99,
  foldmethod = "indent",
  fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]],
}
for option, value in pairs(settings) do
  if vim.fn.exists("+" .. option) == 1 then vim.opt[option] = value
  else vim.notify("Option " .. option .. " is not exist", vim.log.levels.WARN) end
end
-- setup diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
-- setup general keymaps
meov.keymap(
  -- yank to global
  { "v", "<leader>y", [["+y]] },
  -- return to normal mode
  { { "i", "c" }, "jk", "<Esc>" },
  -- insert mode navigation
  { "i", "<M-j>", "<Left>" },
  { "i", "<M-k>", "<Right>" },
  -- buffer navigation
  { { "n", "v" }, "<C-j>", "10jzz" },
  { { "n", "v" }, "<C-k>", "10kzz" },
  -- move and reindent the line
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- remap some common stuff
  { "i", "<C-c>", "<Esc>" },
  { "n", "Q", "<nop>" },
  { { "n", "v", "i" }, "<C-S-Z>", "<Esc>" },
  { { "n", "v", "i" }, "<C-Z>", "<Esc>" },
  { { "n", "v", "i" }, "<C-z>", "<Esc>" }
)
-- bootstrap package manager
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
require("lazy").setup({}, {})
-- setup colorscheme
vim.cmd.colorscheme("habamax")
