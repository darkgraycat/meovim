--[[ ^w^ MeoVim ^w^ ]]--
local meovim = {
  [[                       ░░░ ░░░                    ]],
  [[                      ░▒█░░▒█░                    ]],
  [[                     ░▒▓█░░░░░░                   ]],
  [[                     ░▒░░▓▓██▓▓░                  ]],
  [[                     ░▒▒▓▓▓▓██▓▓░                 ]],
  [[                    ░░▒▓▓▓░▓▓▓░▓░                 ]],
  [[                   ░▓░▒▒▓▓░▓▓▓░▓░                 ]],
  [[                  ░▒░░▒▓▓▓▓██░█▓░                 ]],
  [[                  ░▓░░▒▒▓▓▓████▓░                 ]],
  [[                   ░▒░░▒▒▒▒▒▒▒▒░                  ]],
  [[                   ░▓░░░░░░░░░░                   ]],
  [[                    ░▓▓▓▓▓███░                    ]],
  [[                    ░▓▓▓▓▓███░                    ]],
  [[                    ░▒▓▓▒▒▓█▓░                    ]],
  [[                    ░▒▒░░▒▒░▒░                    ]],
}

--[[ #keymaps ]]--
local keymaps = {
  -- control
  { { "i", "c" }, "jk", "<Esc>" },
  { "i", "<C-c>", "<Esc>" },
  { { "n", "v" }, "<C-d>", "<C-d>zz" },
  { { "n", "v" }, "<C-u>", "<C-u>zz" },
  { { "n", "v" }, "<C-j>", "5jzz" },
  { { "n", "v" }, "<C-k>", "5kzz" },
  { "v", "<leader>y", [["+y]] },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  { { "n", "v" }, "<C-/>", ":Lex<CR>" },
  -- move line
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- parenthesis
  { "i", "[", "[]<left>" }, { "v", "[[", "<Esc>`>a]<Esc>`<i[" },
  { "i", "(", "()<left>" }, { "v", "((", "<Esc>`>a)<Esc>`<i(" },
  { "i", "{", "{}<left>" }, { "v", "{{", "<Esc>`>a}<Esc>`<i{" },
  { "i", "'", "''<left>" }, { "v", "''", "<Esc>`>a'<Esc>`<i'" },
  { "i", '"', '""<left>' }, { "v", '""', '<Esc>`>a"<Esc>`<i"' },
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
  { "n", "<leader>G", ":Telescope git_", "Git commands" },
  { "n", "<leader>gd", ":Telescope lsp_definitions<CR>", "LSP definitions" },
  { "n", "<leader>gr", ":Telescope lsp_references<CR>", "LSP references" },
  { "n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", "LSP symbols" },
  -- lsp
  { { "n" }, "K", vim.lsp.buf.hover },
  { { "n", "v" }, "<C-Space>", vim.lsp.buf.code_action }
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
  showmode = false,
  showcmd = false,
  cmdheight = 1,
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
  listchars = [[multispace:. ]],
  list = true,
}

--[[ #helpers ]]--
local helpers = {
  apply_settings = function (globals, options)
    for global, value in pairs(globals) do vim.g[global] = value end
    for option, value in pairs(options) do vim.opt[option] = value end
  end,
  apply_keymaps = function (keymaps)
    for _, m in pairs(keymaps) do vim.keymap.set(m[1], m[2], m[3], { noremap = true, silent = false, desc = m[4] } ) end
  end,
  apply_signs = function (signs)
    for _, s in pairs(signs) do vim.fn.sign_define(s[1], { text = s[2], texthl = s[1] }) end
  end
}

--[[ #plugins install ]]--
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
  -- ui
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "akinsho/toggleterm.nvim" },
  -- content
  { "nvim-treesitter/nvim-treesitter" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  -- misc & themes
  { "goolord/alpha-nvim" },
  { "folke/tokyonight.nvim" },
  { "akinsho/horizon.nvim" },
  { "sainnhe/gruvbox-material" },
}, {})

--[[ #plugins config ]]--
do
  require"telescope".setup {
    defaults = {
      wrap_results = false,
      path_display = { "smart" },
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      file_ignore_patterns = { "node_modules/.*", "build/.*", "dist/.*" },
    },
    pickers = {
      find_files = { layout_strategy = "horizontal" },
      live_grep = { layout_strategy = "horizontal" },
      buffers = { layout_strategy = "vertical" },
      diagnostics = { layout_strategy = "vertical", theme = "ivy" },
      git_status = { layout_strategy = "vertical" },
      lsp_references = { theme = "cursor", jump_type = "never", path_display = { "short" } },
      lsp_definitions = { theme = "cursor", jump_type = "never", path_display = { "short" } },
      lsp_document_symbols = { theme = "dropdown" },
    },
  }
  require"toggleterm".setup {
    open_mapping = [[<c-\>]],
    size = 20,
    direction = "float",
    float_opts = { border = "solid" },
    highlights = { NormalFloat = { guibg = "" }},
  }
  require"lualine".setup {
    options = {
      --component_separators = { left = '╲', right = '╱'},
      --section_separators = { left = '', right = ''},
      component_separators = { left = '╲╲', right = '╱╱'},
      section_separators = { left = " ", right = " "},
    },
    sections = {
      lualine_a = { "mode", "branch" },
      lualine_b = { "diff", "diagnostics" },
      lualine_c = { { "filename", path = 4 } },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "selectioncount", "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_b = { "buffers" },
      lualine_a = { "tabs" },
    },
  }
  require"mason".setup {}
  require"mason-lspconfig".setup {}
  local lspconfig = require"lspconfig"
  local cmp = require"cmp"
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local lsps = { "lua_ls", "tsserver", "rust_analyzer" }
  for _, lsp in ipairs(lsps) do lspconfig[lsp].setup({ capabilities = capabilities }) end
  cmp.setup {
    sources = { {name = 'nvim_lsp' }, {name = 'buffer' } },
    mapping = cmp.mapping.preset.insert {
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
  }
  local alpha_th = require"alpha.themes.theta"
  alpha_th.header.val = meovim
  require"alpha".setup(alpha_th.config)
end

--[[ #apply ]]--
helpers.apply_settings(globals, options)
helpers.apply_keymaps(keymaps)
helpers.apply_signs({
  { "DiagnosticSignError"," " },
  { "DiagnosticSignWarn", " " },
  { "DiagnosticSignInfo", " " },
  { "DiagnosticSignHint", "󰌵" },
})
vim.cmd[[set path+=**]]
vim.cmd[[autocmd VimResized * :wincmd =]]
vim.cmd[[autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif]]
vim.cmd[[set wildmenu]]
vim.cmd[[colorscheme gruvbox-material]]
