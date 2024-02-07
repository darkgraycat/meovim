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
  { { "n", "v" }, "<C-j>", "5j" },
  { { "n", "v" }, "<C-k>", "5k" },
  { { "n", "v" }, "<C-h>", "^" },
  { { "n", "v" }, "<C-l>", "$" },
  -- buffer helpers
  { "i", "{", "{}<left>" }, { "i", "{}", "{}" }, { "i", "{<CR>", "{<CR>}<Esc>O" }, { "v", "{}", "<Esc>`>a}<Esc>`<i{<Esc>gv" },
  { "i", "[", "[]<left>" }, { "i", "[]", "[]" }, { "i", "[<CR>", "[<CR>]<Esc>O" }, { "v", "[]", "<Esc>`>a]<Esc>`<i[<Esc>gv" },
  { "i", "(", "()<left>" }, { "i", "()", "()" }, { "i", "(<CR>", "(<CR>)<Esc>O" }, { "v", "()", "<Esc>`>a)<Esc>`<i(<Esc>gv" },
  { "i", "`", "``<left>" }, { "i", "``", "``" }, { "i", "`<CR>", "`<CR>`<Esc>O" }, { "v", "``", "<Esc>`>a`<Esc>`<i`<Esc>gv" },
  { "i", "'", "''<left>" }, { "i", "''", "''" }, { "v", "''", "<Esc>`>a'<Esc>`<i'<Esc>gv" },
  { "i", '"', '""<left>' }, { "i", '""', '""' }, { "v", '""', '<Esc>`>a"<Esc>`<i"<Esc>gv' },
  { "i", "/*", "/**/<left><left>" }, { "v", "/*", "<Esc>`>a*/<Esc>`<i/*" },
  { "i", ";;", "<Esc>A;<CR>"}, { "i", "<C-,>", "<Esc>bi"}, { "i", "<C-.>", "<Esc>ea" },
  { "v", "<leader>y", [["+y]] },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  { "v", "J", ":m '>+1<CR>gv=gv" },
  { "v", "K", ":m '<-2<CR>gv=gv" },
  -- lsp helpers
  { { "n" }, "K", vim.lsp.buf.hover },
  { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action },
  -- window control
  { "n", "<A-Left>",  ":vertical resize +4<CR>"},
  { "n", "<A-Right>", ":vertical resize -4<CR>"},
  { "n", "<A-Down>",  ":horizontal resize +4<CR>"},
  { "n", "<A-Up>",    ":horizontal resize -4<CR>"},
  -- tabline control
  { "n", "§",   ":bnext <CR>"},
  { "n", "±", ":bprevious <CR>"},
  { "n", "d§", ":<C-U>bprevious <bar> bdelete #<CR>" },
  -- tabs control
  { "n", "<A-=>", ":tabnew<CR>"},
  { "n", "<A-[>", ":tabprevious<CR>"},
  { "n", "<A-]>", ":tabnext<CR>"},
  { "n", "d=", ":tabclose<CR>"},
  -- gui control
  { { "n", "v" }, "<C-/>", [[<cmd>Lex!<CR>]] },
  { { "n", "t" }, "<C-\\>", [[<cmd>lua require('FTerm').toggle()<CR>]] },
  { "t", "<C-c><C-c>", [[<cmd>lua require('FTerm').close()<CR>]] },
  { "n", "<C-o>", [[<cmd>lua require('oil').toggle_float()<CR>]]},
  { { "n", "t" }, "<C-|>", [[<cmd>vsplit term://zsh<CR>i]] },
  { "t", "<Esc>", [[<C-\><C-n>]] },
  { "n", "<C-w>a", [[<cmd>Alpha<CR>]] },
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
    Text = "󰦨 ", Method = "󰅲 ", Function = "󰊕 ", Constructor = " ", Field = " ",
    Variable = "󰫧 ", Class = "󰠱 ", Interface = " ", Module = " ", Property = " ",
    Unit = " ", Value = "󰎠 ", Enum = " ", Keyword = "󰌋 ", Snippet = " ",
    Color = "󰏘 ", File = "󰈙 ", Reference = "", Folder = "󰉋", EnumMember = " ",
    Constant = "󰏿 ", Struct = " ", Event = " ", Operator = "󰆕 ", TypeParameter = " ",
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
  end,
  session = {
    sessions_dir = vim.fn.stdpath("config") .. "/.sessions",
    filename = function () return helpers.session.sessions_dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. ".vim" end,
    save = function () 
      local filename = helpers.session.filename()
      vim.cmd("mksession! " .. filename)
    end,
    load = function () 
      local filename = helpers.session.filename()
      if vim.fn.filereadable(filename) == 1 then vim.cmd("source " .. filename)
      else print("No sessions to load") end
    end,
  },
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
  { "folke/tokyonight.nvim" },
  { "akinsho/horizon.nvim" },
  { "rose-pine/neovim" },
  { "AlexvZyl/nordic.nvim" },
  { "Koalhack/koalight.nvim" },
}, {})

--[[ #plugins config ]]--
do
  require"telescope".setup {
    defaults = {
      wrap_results          = false,
      path_display          = { "smart" },
      file_ignore_patterns  = { "node_modules/.*", "build/.*", "dist/.*" },
      layout_config         = { prompt_position = "top" },
      sorting_strategy      = 'ascending',
      selection_caret       = "> ",
    },
    pickers = {
      find_files            = { layout_strategy = "horizontal" },
      live_grep             = { layout_strategy = "horizontal" },
      git_status            = { layout_strategy = "horizontal" },
      buffers               = { layout_strategy = "horizontal", theme = "dropdown" },
      diagnostics           = { layout_strategy = "vertical", theme = "ivy", wrap_results = true, path_display = { "hidden" } },
      lsp_document_symbols  = { layout_strategy = "vertical", theme = "ivy" },
      lsp_references        = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
      lsp_definitions       = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
      colorscheme           = { enable_preview = true },
    },
  }
  require"lualine".setup {
    options = {
      --component_separators = { left = '╲', right = '╱'},
      --section_separators   = { left = '', right = ''},
      component_separators = { left = '╲╲', right = '╲╲'},
      section_separators   = { left = "", right = ""},
      --component_separators = { left = "░", right = "░" },
      --section_separators   = { left = "▓▒░", right = "░▒▓" },
    },
    sections = {
      lualine_a = { "mode", "location" },
      lualine_b = { "diagnostics", "diff" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "encoding" },
      lualine_y = { "filetype" },
      lualine_z = { "selectioncount", "progress" },
    },
    tabline = {
      lualine_a = { { "buffers", max_length = vim.o.columns * 0.8 } },
      lualine_x = { "branch" },
      lualine_z = { "tabs" },
    },
    extensions = { "oil" },
  }
  require"FTerm".setup { border = "rounded" }
  require"oil".setup {
    columns = {
      { "mtime", highlight = "Comment" },
      { "size",  highlight = "Label" },
      { "icon",  highlight = "Normal" },
    },
    default_file_explorer = false,
    win_options = { number = false, relativenumber = false, conceallevel = 3, concealcursor = "nvic" },
    float = { border = "rounded", padding = 2, max_width = 120, max_height = 40 },
  }
  local language_servers = { "lua_ls", "tsserver", "rust_analyzer", "intelephense" }
  require"mason".setup {}
  require"mason-lspconfig".setup { ensure_installed = language_servers }
  local lspconfig = require"lspconfig"
  local cmp = require"cmp"
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  for _, lsp in ipairs(language_servers) do lspconfig[lsp].setup({ capabilities = capabilities }) end
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  cmp.setup {
    sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" } },
    snippet = { expand = function(args) require"luasnip".lsp_expand(args.body) end },
    formatting = { format = function(_, i) local kind = i.kind i.kind = (icons.autocomplete[kind] or "?") i.menu = "" .. kind return i end },
    window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
    mapping = {
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<C-c>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
  }
  local alpha_th = require"alpha.themes.theta"
  local alpha_db = require"alpha.themes.dashboard"
  local alpha_time = tostring(os.date("%A %I:%M %p"))
  alpha_th.header.val = meovim
  alpha_th.buttons.val = {
    { type = "text", val = "╭"..string.rep("─", 48 - string.len(alpha_time))..alpha_time.."╮", opts = { hl = "TelescopeBorder", position = "center" } },
    alpha_db.button("e", "󰝒   New file",        ":ene <BAR> startinsert <CR>"),
    alpha_db.button("f", "󰱼   Find file",       ":Telescope find_files <CR>"),
    alpha_db.button("g", "󱎸   Find text",       ":Telescope live_grep <CR>"),
    alpha_db.button("r", "󰁯   Restore session", ":lua SessionLoad() <CR>"),
    alpha_db.button("s", "   Settings",        ":e ~/.config/nvim/init.lua<CR>"),
    alpha_db.button("q", "󰄛   Quit",            ":qa<CR>"),
    { type = "text", val = "╰"..string.rep("─", 48).."╯", opts = { hl = "TelescopeBorder", position = "center" } },
  }
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

--[[ #sessions ]]--
function SessionSave()
  local dir = vim.fn.stdpath("config") .. "/.sessions"
  local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. ".vim"
  if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p"); vim.cmd("redraw!") end
  vim.cmd("mksession! " .. filename)
end
function SessionLoad()
  local dir = vim.fn.stdpath("config") .. "/.sessions"
  local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. ".vim"
  if vim.fn.filereadable(filename) == 1 then vim.cmd("source " .. filename)
  else vim.notify("No sessions to load") end
end
vim.cmd[[autocmd VimLeave *        lua if vim.fn.confirm("Save session?", "&Yes\n&No", 2) == 1 then SessionSave() end]]

--[[ #colorscheme ]]--
function Colorscheme(colorscheme)
  vim.cmd("colorscheme " .. colorscheme)
  helpers.apply_highlights {
    FloatTitle = "Title",
    NormalFloat = "Normal",
    FloatBorder = "Function",
    TelescopeTitle = "FloatTitle",   TelescopeResultsTitle  = "TelescopeTitle",  TelescopePreviewTitle  = "TelescopeTitle",  TelescopePromptTitle  = "TelescopeTitle",
    TelescopeNormal = "NormalFloat", TelescopeResultsNormal = "TelescopeNormal", TelescopePreviewNormal = "TelescopeNormal", TelescopePromptNormal = "TelescopeNormal",
    TelescopeBorder = "FloatBorder", TelescopeResultsBorder = "TelescopeBorder", TelescopePreviewBorder = "TelescopeBorder", TelescopePromptBorder = "TelescopeBorder",
  }
end
Colorscheme(colors)
