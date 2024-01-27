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

-- lsp
local lsps = { "lua_ls", "tsserver", "rust_analyzer" }

-- install and config plugins
require"lazy".setup({
  { "nvim-lua/plenary.nvim" },
  { 
    "nvim-telescope/telescope.nvim",
    config = function()
      require"telescope".setup({
				defaults = {
					wrap_results = false,
					path_display = { "smart" },
					file_ignore_patterns = { "node_modules/.*", "build/.*", "dist/.*" },
				},
        pickers = {
          find_files            = { layout_strategy = "horizontal" },
          live_grep             = { layout_strategy = "horizontal" },
          buffers               = { layout_strategy = "vertical" },
          diagnostics           = { layout_strategy = "vertical", theme = "ivy" },
          git_status            = { layout_strategy = "vertical" }, 
    			lsp_references        = { theme = "cursor", jump_type = "never" },
					lsp_definitions       = { theme = "cursor", jump_type = "never" },
					lsp_document_symbols  = { theme = "dropdown" },
        },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require"nvim-treesitter.configs".setup({
        sync_install = false,
        ensure_installed = { "lua", "vimdoc", "javascript", "typescript", "rust" },
        highlight = { enable = true },
        autopairs = { enable = true },
        autotag = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/nvim-cmp"},
  {"L3MON4D3/LuaSnip"},
  {
   "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      for _, lsp in ipairs(lsps) do
        lspconfig[server].setup{ capabilities = require("cmp_nvim_lsp").default_capabilities() }
      end
    end,
  },
  { "folke/tokyonight.nvim",    name = "tokyonight" },
}, {})

-- setup colorscheme
vim.cmd.colorscheme("tokyonight-night")

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
  { "n", "<leader>E", ":Ex<CR>" },
  { "i", "<C-c>", "<Esc>" },
  { "n", "Q", "<nop>" },
  { { "n", "v", "i" }, "<C-S-Z>", "<Esc>" },
  { { "n", "v", "i" }, "<C-Z>", "<Esc>" },
  { { "n", "v", "i" }, "<C-z>", "<Esc>" }
)

-- setup telescope keymaps
meov.keymap(
	{ "n", "<C-p>",           ":Telescope find_files<CR>",                "Find files" },
	{ "n", "<leader>fs",      ":Telescope live_grep<CR>",                 "Search files" },
  { "n", "<leader><space>", ":Telescope buffers<CR>",                   "Opened buffers" },
	{ "n", "<leader>de",      ":Telescope diagnostics<CR>",               "Show diagnostics" },
	{ "n", "<leader>gs",      ":Telescope git_status<CR>",                "Git status" },
	{ "n", "<leader>gd",      ":Telescope lsp_definitions<CR>",           "Goto definition" },
	{ "n", "<leader>gr",      ":Telescope lsp_references<CR>",            "Goto references" },
	{ "n", "<leader>gs",      ":Telescope lsp_document_symbols<CR>",      "Goto symbols" }
)

        --{ "n", "K", vim.lsp.buf.hover, "Hover doc" },
        --{ "n", "<leader>gd", vim.lsp.buf.definition, "Go to definition" },
        --{ "n", "<leader>gr", vim.lsp.buf.references, "Go to references" },
        --{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action" }
