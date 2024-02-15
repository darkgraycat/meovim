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
--[[ #colorscheme ]]--
local colorscheme = "nordic"

--[[ #keymaps ]]--
local keymaps = {
  -- buffer control
  { { "i", "c" }, "jk", "<Esc>" },
  { { "i", "c" }, "<C-BS>", "<right><BS>" },
  { { "n", "v" }, "<C-d>", "<C-d>zz" }, { { "n", "v" }, "<C-u>", "<C-u>zz" },
  { { "n", "v" }, "<C-j>", "5j" }, { { "n", "v" }, "<C-k>", "5k" },
  { { "n", "v" }, "<C-h>", "B" }, { { "n", "v" }, "<C-l>", "W" },
  { "i", ";;", "<Esc>A;<CR>"}, { "i", "..", "<Esc>Ea" }, { "i", ",,", "<Esc>Bi" },
  { "i", "<<",    "<Esc>I"  }, { "i", ">>",    "<Esc>A"  },
  { "i", "<C-,>", "<left>" },  { "i", "<C-.>", "<right>" },
  { "v", "<leader>y", [["+y]] },
  { "v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>" },
  { "v", "J", ":m '>+1<CR>gv=gv" }, { "v", "K", ":m '<-2<CR>gv=gv" },
  { "n", "X", [[:s/\([\[{(]\|,\)\|\([\]})]\)/\1\r\2<CR>==]] },
  -- autopairing symbols
  { "i", "{ ", "{  }<left><left>" }, { "i", "{<CR>", "{<CR>}<Esc>O" },
  { "i", "( ", "()<left>" },         { "i", "(<CR>", "(<CR>)<Esc>O" },
  { "i", "[ ", "[]<left>" },         { "i", "[<CR>", "[<CR>]<Esc>O" },
  { "i", '" ', '""<left>' },         { "i", "' ", "''<left>" },
  { "i", "/* ","/**/<left><left>" }, { "i", "` ", "``<left>" },
  -- surrounding symbols
  { "v", "{}", "<Esc>`>a }<Esc>`<i{ <Esc>gv" },
  { "v", "[]", "<Esc>`>a]<Esc>`<i[<Esc>gv" },
  { "v", "()", "<Esc>`>a)<Esc>`<i(<Esc>gv" },
  { "v", "``", "<Esc>`>a`<Esc>`<i`<Esc>gv" },
  { "v", "''", "<Esc>`>a'<Esc>`<i'<Esc>gv" },
  { "v", '""', '<Esc>`>a"<Esc>`<i"<Esc>gv' },
  -- window/buffers/tabs control
  { "n", "§",        ":bnext <CR>"},  { "n", "±",     ":bprevious <CR>"},
  { "n", "d§",       ":<C-U>bprevious <bar> bdelete #<CR>" },
  { "n", "<A-=>",    ":tabnew<CR>"},  { "n", "d=",    ":tabclose<CR>"},
  { "n", "<A-]>",    ":tabnext<CR>"}, { "n", "<A-[>", ":tabprevious<CR>"},
  { "n", "<A-Left>", ":vertical resize +4<CR>"},   { "n", "<A-Right>", ":vertical resize -4<CR>"},
  { "n", "<A-Down>", ":horizontal resize +4<CR>"}, { "n", "<A-Up>",    ":horizontal resize -4<CR>"},
  -- gui control
  { "n", "<C-w>a",     [[<cmd>Alpha<CR>]] },
  { "n", "<C-/>",      [[<cmd>Lex<CR>]] },
  { "n", "<C-o>",      [[<cmd>lua require('oil').toggle_float()<CR>]]},
  { { "n", "t" },      "<C-|>", [[<cmd>vsplit term://zsh<CR>i]] },
  { { "n", "t" },      "<C-\\>", [[<cmd>lua require('FTerm').toggle()<CR>]] },
  { "t", "<Esc>",      [[<C-\><C-n>]] },
  { "t", "<C-c><C-c>", [[<C-c>exit<CR>]] },
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
  { "n", "<leader>F",  ":Telescope resume<CR>", "Resume" },
}

--[[ #lsp configurations ]]
local lsp_configurations = {
  servers = { "lua_ls", "clangd", "tsserver", "rust_analyzer", "intelephense" },
  cmpkeys = { Next="<Tab>", Prev="<S-Tab>", Abort="<C-c>", Confirm="<CR>" },
  lspkeys = { Hover="K", Signature="<A-k>", CodeAction="<leader>ca", Format="<leader>cf" },
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
  listchars = [[multispace:· ,tab:⬄  ,]],
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
  diagnostics = { DiagnosticSignError = "", DiagnosticSignWarn = "", DiagnosticSignInfo = "", DiagnosticSignHint = "󰌵 " },
  dashboard = { NewFile = "󰝒", FindFile = "󰱼", FindText = "󱎸", RestoreSession = "󰁯", Settings = "", Quit = "󰄛" },
  statusline = { "", "", "╲", "╱" },
  -- statusline = { "", "", "╲╲", "╲╲" },
  -- statusline = { "▓▒░", "░▒▓", "░", "░" },
}

--[[ #highlights ]]--
local highlights = {
  NormalNC = "Normal",
  NormalFloat = "Normal",
  FloatTitle = "Title",
  FloatBorder = "Function",
  TelescopeTitle = "FloatTitle",   TelescopeResultsTitle  = "TelescopeTitle",  TelescopePreviewTitle  = "TelescopeTitle",  TelescopePromptTitle  = "TelescopeTitle",
  TelescopeNormal = "NormalFloat", TelescopeResultsNormal = "TelescopeNormal", TelescopePreviewNormal = "TelescopeNormal", TelescopePromptNormal = "TelescopeNormal",
  TelescopeBorder = "FloatBorder", TelescopeResultsBorder = "TelescopeBorder", TelescopePreviewBorder = "TelescopeBorder", TelescopePromptBorder = "TelescopeBorder",
}

--[[ #aliases ]]--
function SessionLoad()
  local dir = vim.fn.stdpath("config") .. "/.sessions"
  local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. ".vim"
  if vim.fn.filereadable(filename) == 1 then vim.cmd("source " .. filename)
  else vim.notify("No sessions to load") end
end
function SessionSave()
  local dir = vim.fn.stdpath("config") .. "/.sessions"
  local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. ".vim"
  if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p"); vim.cmd("redraw!") end
  vim.cmd("mksession! " .. filename)
end
function Highlights()
  for hi, link in pairs(highlights) do vim.cmd("hi clear " .. hi) vim.cmd("hi link " .. hi .. " " ..link) end
end

--[[ #plugins configutaions ]]--
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

require"lazy".setup({
  -- ui
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function ()
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
  end },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function ()
    require"lualine".setup {
      extensions = { "oil" },
      options = {
        component_separators = { left = icons.statusline[3], right = icons.statusline[4]},
        section_separators   = { left = icons.statusline[1], right = icons.statusline[2]},
      },
      sections = {
        lualine_a = { "mode", "location" }, lualine_b = { "diagnostics", "diff" }, lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding" },         lualine_y = { "filetype" },            lualine_z = { "selectioncount", "progress" },
      },
      tabline = {
        lualine_a = { { "buffers", max_length = vim.o.columns * 0.8 } },
        lualine_x = { "branch" }, lualine_z = { "tabs" },
      },
    }
  end },
  { "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function ()
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
  end },
  { "numToStr/FTerm.nvim", config = function ()
    require"FTerm".setup { border = "rounded" }
  end },
  -- content
  { "nvim-treesitter/nvim-treesitter" },
  { "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim" }, config = function ()
    require"mason".setup {}
    require"mason-lspconfig".setup { ensure_installed = lsp_configurations.servers }
  end },
  { "neovim/nvim-lspconfig", dependencies = { "hrsh7th/cmp-nvim-lsp" }, config = function ()
    local lspconfig = require"lspconfig"
    local on_attach = function (e, bufn)
      local opts = { buffer = bufn, noremap = true, silent = true }
      vim.keymap.set("n", lsp_configurations.lspkeys.Hover, vim.lsp.buf.hover, opts)
      vim.keymap.set("n", lsp_configurations.lspkeys.Format, vim.lsp.buf.format, opts)
      vim.keymap.set("n", lsp_configurations.lspkeys.Signature, vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", lsp_configurations.lspkeys.CodeAction, vim.lsp.buf.code_action, opts)
      vim.notify("LSP attached: " .. e.name)
    end
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    for _, lsp in ipairs(lsp_configurations.servers) do lspconfig[lsp].setup({ capabilities = capabilities, on_attach = on_attach }) end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  end },
  { "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip" }, config = function ()
    local cmp = require"cmp"
    cmp.setup {
      sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" } },
      snippet = { expand = function(args) require"luasnip".lsp_expand(args.body) end },
      formatting = { format = function(_, i) local kind = i.kind i.kind = (icons.autocomplete[kind] or "?") i.menu = "" .. kind return i end },
      window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
      mapping = {
        [lsp_configurations.cmpkeys.Next] = cmp.mapping.select_next_item(),
        [lsp_configurations.cmpkeys.Prev] = cmp.mapping.select_prev_item(),
        [lsp_configurations.cmpkeys.Abort] = cmp.mapping.abort(),
        [lsp_configurations.cmpkeys.Confirm] = cmp.mapping.confirm({ select = false }),
      },
    }
  end },
  -- dashboard
  { "goolord/alpha-nvim", config = function ()
    local alpha_th = require"alpha.themes.theta"
    local alpha_db = require"alpha.themes.dashboard"
    local alpha_time = tostring(os.date("%A %I:%M %p"))
    alpha_th.header.val = meovim
    alpha_th.buttons.val = {
      { type = "text", val = "╭"..string.rep("─", 48 - string.len(alpha_time))..alpha_time.."╮", opts = { hl = "FloatBorder", position = "center" } },
      alpha_db.button("e", icons.dashboard.NewFile        .. "  New file",        ":ene <BAR> startinsert <CR>"),
      alpha_db.button("f", icons.dashboard.FindFile       .. "  Find file",       ":Telescope find_files <CR>"),
      alpha_db.button("g", icons.dashboard.FindText       .. "  Find text",       ":Telescope live_grep <CR>"),
      alpha_db.button("r", icons.dashboard.RestoreSession .. "  Restore session", ":lua SessionLoad() <CR>"),
      alpha_db.button("s", icons.dashboard.Settings       .. "  Settings",        ":e ~/.config/nvim/init.lua<CR>"),
      alpha_db.button("q", icons.dashboard.Quit           .. "  Quit",            ":qa<CR>"),
      { type = "text", val = "╰"..string.rep("─", 48).."╯", opts = { hl = "FloatBorder", position = "center" } },
    }
    require"alpha".setup(alpha_th.config)
  end },
  -- colorschemes
  { "folke/tokyonight.nvim", name = "tokyonight" },
  { "akinsho/horizon.nvim", name = "horizon" },
  { "rose-pine/neovim", name = "rosepine" },
  { "AlexvZyl/nordic.nvim", name = "nordic" },
  { "catppuccin/nvim", name = "catppuccin" },
}, {})

--[[ #apply config ]]--
for global, value in pairs(globals) do vim.g[global] = value end
for option, value in pairs(options) do vim.opt[option] = value end
for _, km in pairs(keymaps) do vim.keymap.set(km[1], km[2], km[3], { noremap = true, silent = false, desc = km[4] } ) end
for hl, icon in pairs(icons.diagnostics) do vim.fn.sign_define(hl, { text = icon, texthl = hl }) end

vim.cmd[[set path+=**]]
vim.cmd[[set wildmenu]]
vim.cmd[[autocmd VimResized * :wincmd =]]
vim.cmd[[autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif]]
vim.cmd[[autocmd VimLeave * lua if vim.fn.confirm("Save session?", "&Yes\n&No", 2) == 1 then SessionSave() end]]
vim.cmd[[autocmd ColorScheme * lua Highlights()]]
vim.cmd("colorscheme " .. colorscheme)
