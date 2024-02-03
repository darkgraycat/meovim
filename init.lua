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
local colors = "nordic"

--[[ #keymaps ]]--
local keymaps = {
  -- buffer control
  { { "i", "c" }, "jk", "<Esc>" },
  { "x", "<C-c>", "<Esc>" },
  { { "n", "v" }, "<C-d>", "<C-d>zz" },
  { { "n", "v" }, "<C-u>", "<C-u>zz" },
  { { "n", "v" }, "<C-j>", "5jzz" },
  { { "n", "v" }, "<C-k>", "5kzz" },
  -- buffer helpers
  { "i", "[", "[]<left>" }, { "v", "[[", "<Esc>`>a]<Esc>`<i[" },
  { "i", "(", "()<left>" }, { "v", "((", "<Esc>`>a)<Esc>`<i(" },
  { "i", "{", "{}<left>" }, { "v", "{{", "<Esc>`>a}<Esc>`<i{" },
  { "i", "'", "''<left>" }, { "v", "''", "<Esc>`>a'<Esc>`<i'" },
  { "i", '"', '""<left>' }, { "v", '""', '<Esc>`>a"<Esc>`<i"' },
  { "i", "/*", "/**/<left><left>" }, { "v", "/*", "<Esc>`>a*/<Esc>`<i/*" },
  { "v", "<leader>y", [["+y]] },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- lsp helpers
  { { "n" }, "K", vim.lsp.buf.hover },
  { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action },
  -- window control
  { "n", "<A-Left>",  ":vertical resize +3<CR>"},
  { "n", "<A-Right>", ":vertical resize -3<CR>"},
  { "n", "<A-Down>",  ":horizontal resize +3<CR>"},
  { "n", "<A-Up>",    ":horizontal resize -3<CR>"},
  -- tabline control
  { "n", "<BS>",   ":bnext <CR>"},
  { "n", "<S-BS>", ":bprevious <CR>"},
  { "n", "<C-BS>", ":bdelete! <CR>"},
  -- tabs control
  { "n", "<A-=>", ":tabnew<CR>"},
  { "n", "<A-->", ":tabclose<CR>"},
  { "n", "<A-[>", ":tabprevious<CR>"},
  { "n", "<A-]>", ":tabnext<CR>"},
  -- gui control
  { { "n", "v" }, "<C-/>", ":Lex<CR>" },
  { { "n", "t" }, "<C-\\>", [[<cmd>lua require('FTerm').toggle()<CR>]] },
  { "t", "<C-c><C-c>", [[<cmd>lua require('FTerm').close()<CR>]] },
  { "n", "<C-e>", [[<cmd>lua require('oil').open()<CR>]]},
  { "n", "<C-O>", [[<cmd>lua require('oil').toggle_float()<CR>]]},
  { "n", "<leader>A", ":Alpha<CR>" },
  -- telescope
  { "n", "<C-p>",      ":Telescope find_files theme=dropdown layout_config={mirror=true}<CR>", "Find files" },
  { "n", "<C-g>",      ":Telescope git_", "Git commands" },
  { "n", "<leader>fg", ":Telescope live_grep<CR>", "File grep" },
  { "n", "<leader>ff", ":Telescope find_files<CR>", "Find files" },
  { "n", "<leader>fb", ":Telescope buffers<CR>", "Opened buffers" },
  { "n", "<leader>fe", ":Telescope diagnostics<CR>", "Show diagnostics" },
  { "n", "<leader>fr", ":Telescope lsp_references<CR>", "LSP references" },
  { "n", "<leader>fd", ":Telescope lsp_definitions<CR>", "LSP definitions" },
  { "n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", "LSP symbols" },
  { "n", "<leader>fR", ":Telescope resume<CR>", "Resume" },
  { "n", "<leader>h", ":Telescope highlights<CR>", "Resume" },
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
  fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
  listchars = [[multispace:. ,tab:⬄  ,]],
  list = true,
}

--[[ #icons ]]--
local icons = {
  autocomplete = {
    Text = "󰦨", Method = "󰆧", Function = "󰊕", Constructor = "", Field = "󰇽",
    Variable = "󰫧", Class = "󰠱", Interface = "", Module = "", Property = "󰜢",
    Unit = "", Value = "󰎠", Enum = "", Keyword = "󰌋", Snippet = "",
    Color = "󰏘", File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
    Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕", TypeParameter = "󰅲",
  },
  diagnostics = {
    DiagnosticSignError = "",
    DiagnosticSignWarn = "",
    DiagnosticSignInfo = "",
    DiagnosticSignHint = "󰌵 ",
  }
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
  apply_highlights = function (highlights)
    for hi, link in pairs(highlights) do vim.cmd("hi clear " .. hi) vim.cmd("hi link " .. hi .. " " ..link) end
  end,
  apply_icons = function (icons)
    for hl, icon in pairs(icons) do vim.fn.sign_define(hl, { text = icon, texthl = hl }) end
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
  { "nvim-lualine/lualine.nvim",     dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "stevearc/oil.nvim",             dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "numToStr/FTerm.nvim" },
  -- content
  { "nvim-treesitter/nvim-treesitter" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim",       dependencies = { "williamboman/mason-lspconfig.nvim"} },
  { "hrsh7th/cmp-nvim-lsp",          dependencies = { "hrsh7th/nvim-cmp"} },
  { "L3MON4D3/LuaSnip" },
  -- misc & themes
  { "goolord/alpha-nvim" },
  { "folke/tokyonight.nvim",    name = "tokyonight" },
  { "akinsho/horizon.nvim",     name = "horizon" },
  { "sainnhe/gruvbox-material", name = "gruvbox" },
  { "rose-pine/neovim",         name = "rose-pine" },
  { "AlexvZyl/nordic.nvim",     name = "nordic" }
}, {})

--[[ #plugins config ]]--
do
  require"telescope".setup {
    defaults = {
      wrap_results          = false,
      path_display          = { "smart" },
      file_ignore_patterns  = { "node_modules/.*", "build/.*", "dist/.*" },
      layout_config           = { prompt_position = "top" },
      selection_caret = "   ",
      sorting_strategy = 'ascending',
    },
    pickers = {
      find_files            = { layout_strategy = "horizontal" },
      live_grep             = { layout_strategy = "horizontal" },
      git_status            = { layout_strategy = "horizontal" },
      buffers               = { layout_strategy = "horizontal", theme = "dropdown" },
      diagnostics           = { layout_strategy = "vertical", theme = "ivy" },
      lsp_document_symbols  = { layout_strategy = "vertical", theme = "ivy" },
      lsp_references        = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
      lsp_definitions       = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
    },
  }
  require"lualine".setup {
    options = {
      --component_separators = { left = '╲', right = '╱'},
      --section_separators = { left = '', right = ''},
      component_separators = { left = '╲╲', right = '╲╲'},
      section_separators = { left = " ", right = " "},
    },
    sections = {
      lualine_a = { "mode", "branch" },
      lualine_b = { "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "encoding" },
      lualine_y = { "selectioncount", "filetype" },
      lualine_z = { "location", "progress" },
    },
    tabline = {
      lualine_b = { { "buffers", max_length = vim.o.columns } },
      lualine_z = { { "tabs", use_mode_colors = true } },
    },
    extensions = { "oil" },
  }
  require"FTerm".setup { border = "rounded" }
  require"oil".setup {
    columns = {
      { "mtime", highlight = "Comment" },
      { "size", highlight = "Label" },
      { "icon", highlight = "Normal" },
    },
    default_file_explorer = false,
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      conceallevel = 3,
      concealcursor = "nvic",
    },
    float = {
      border = "rounded",
      padding = 2,
      max_width = 120,
      max_height = 40,
    },
  }
  require"mason".setup {}
  require"mason-lspconfig".setup {}
  local lspconfig = require"lspconfig"
  local cmp = require"cmp"
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = false
  local lsps = { "lua_ls", "tsserver", "rust_analyzer", "intelephense" }
  for _, lsp in ipairs(lsps) do lspconfig[lsp].setup({ capabilities = capabilities }) end
  cmp.setup {
    sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" } },
    snippet = { expand = function(args) require"luasnip".lsp_expand(args.body) end },
    formatting = { format = function(_, i) local kind = i.kind i.kind = (icons.autocomplete[kind] or "?") i.menu = "" .. kind return i end },
    mapping = {
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<C-c>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
  }
  local alpha_th = require"alpha.themes.theta"
  alpha_th.header.val = meovim
  require"alpha".setup(alpha_th.config)
end

--[[ #apply config ]]--
helpers.apply_settings(globals, options)
helpers.apply_keymaps(keymaps)
helpers.apply_icons(icons.diagnostics)
vim.cmd[[set path+=**]]
vim.cmd[[autocmd VimResized * :wincmd =]]
vim.cmd[[autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif]]
vim.cmd[[set wildmenu]]

--[[ #colorscheme ]]--
vim.cmd("colorscheme " .. colors)
helpers.apply_highlights {
  TelescopeTitle = "Title",        TelescopeResultsTitle  = "TelescopeTitle", TelescopePreviewTitle   = "TelescopeTitle", TelescopePromptTitle   = "TelescopeTitle",
  TelescopeNormal = "Normal",      TelescopeResultsNormal = "TelescopeNormal", TelescopePreviewNormal = "TelescopeNormal", TelescopePromptNormal = "TelescopeNormal",
  TelescopeBorder = "Conditional", TelescopeResultsBorder = "TelescopeBorder", TelescopePreviewBorder = "TelescopeBorder", TelescopePromptBorder = "TelescopeBorder",
  FloatBorder = "TelescopeBorder",
  NormalFloat = "TelescopeNormal",
  FloatTitle = "TelescopeTitle",
}
