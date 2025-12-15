-- TODO:
-- ADD JSON USER CONFIG to be able to change settings. also make a menu using Alpha to switch/view them:
-- Alpha menu item to be like: indentSpaces 4 | colorScheme kanagawa | lualineStyle 2
-- -- or even show config near to cat picture
--
-- backup current file [v]
-- Finish lazygit setup
-- Learn how to integrate terminal tools (ranger, lazygit) with vim
--
-- I think we can have general serializable config for plugins as well
-- like I did for statusline style
-- Using .vimrc - enrich current with features [settings left]
-- Use vim.cmd to have elegant and flexible keymaps + reduce amount of code [v]
-- then we can use more complex keymaps (togglecomment as example)
-- also think about using it for settings too
-- actually we can have config with 3 parts:
--  vim.cmd for keymap and settings
--  serializable object for other settings (can be 2: vim builtin and plugin settings)
--  and one function to load this config (+helper functions)
--  ^ cons but this approach may increase startup time
--  ^ pros ex: i can have C-x,C-s keymaps in one place and use it for other
--  refactor autocmds as well [v]
--
-- add separate function to load and apply pluigins, and call it after all setup

--[[ ^w^ MeoVim ^w^ ]] ----------------------------------------------------------
--·
local meovim = {
	[[                    ░░░░░░  ░░░░░░               ]],
	[[                  ░░▒▒██░░░░▒▒██░░               ]],
	[[                ░░▒▒▓▓██░░░░░░░░░░░░             ]],
	[[                ░░▒▒░░░░▓▓▓▓████▓▓▓▓░░           ]],
	[[                ░░▒▒▒▒▓▓▓▓▓▓▓▓████▓▓▓▓░░         ]],
	[[              ░░░░▒▒▓▓▓▓▓▓░░▓▓▓▓▓▓░░▓▓░░         ]],
	[[            ░░▓▓░░▒▒▒▒▓▓▓▓░░▓▓▓▓▓▓░░▓▓░░         ]],
	[[          ░░▒▒░░░░▒▒▓▓▓▓▓▓▓▓████░░██▓▓░░         ]],
	[[          ░░▓▓░░░░▒▒▒▒▓▓▓▓▓▓████████▓▓░░         ]],
	[[            ░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░           ]],
	[[            ░░▓▓░░░░░░░░░░░░░░░░░░░░             ]],
	[[              ░░▓▓▓▓▓▓▓▓▓▓██████░░               ]],
	[[              ░░▓▓▓▓▓▓▓▓▓▓██████░░               ]],
	[[              ░░▒▒▓▓▓▓▒▒▒▒▓▓██▓▓░░               ]],
	[[              ░░▒▒▒▒░░░░▒▒▒▒░░▒▒░░               ]],
}
local config_path = vim.fn.stdpath('config')
local vcmd = vim.cmd
local vfn = vim.fn

--[[ #colorscheme ]] ------------------------------------------------------------
local colorscheme = "kanagawa"
-- local colorscheme = "kanagawa-dragon"
-- local colorscheme = "rose-pine-moon"
-- local colorscheme = "github_dark_dimmed"
-- local colorscheme = "tokyonight-storm"
-- local colorscheme = "tokyonight-night"
-- local colorscheme = "nordic"
-- local colorscheme = "everforest"
-- local colorscheme = "catppuccin-frappe"
-- local colorscheme = "horizon"

local statusline_style = 1
local indent_spaces = 4

--[[ #globals ]] ----------------------------------------------------------------
local globals = {
	mapleader = " ",
	netrw_banner = 0,
	netrw_showhide = 1,
	netrw_liststyle = 3,
	netrw_altv = 1,
	netrw_winsize = 25,
	netrw_browse_split = 4,
}

--[[ #options ]] ----------------------------------------------------------------
local options = {
	-- indent --
	shiftwidth = indent_spaces,
	tabstop = indent_spaces,
	softtabstop = indent_spaces,
	autoindent = true,
	smartindent = true,
	shiftround = true,
	expandtab = false,
	smarttab = true,
	wrap = false,
	list = true,
	-- listchars = [[multispace:‧ ,tab:╎  ,]],
	listchars = [[multispace:  ,tab:▎  ,]],
	-- listchars = [[multispace:‧ ,tab:▎  ,]],
	-- listchars = [[multispace:․ ,tab:▎  ,]],
	-- listchars = [[multispace:· ,tab:▎  ,]],
	-- fold --
	foldenable = true,
	foldlevel = 99,
	foldlevelstart = 99,
	foldcolumn = "0",
	foldmethod = "indent",
	fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,stl: ,stlnc: ]],
	-- look --
	termguicolors = true,
	number = true,
	relativenumber = true,
	showmode = false,
	showcmd = true,
	cursorline = true,
	showtabline = 0,
	cmdheight = 1,
	laststatus = 2,
	signcolumn = "yes",
	pumheight = 8,
	scrolloff = 8,
	sidescrolloff = 8,
	-- search --
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	incsearch = true,
	-- other --
	autowrite = true,
	autoread = true,
	backup = false,
	swapfile = false,
	splitright = true,
	splitbelow = true,
	mouse = "a",
	backspace = "indent,eol,start",
	completeopt = "menu,menuone,preview,noinsert",
}
--[[ #keymaps ]] ----------------------------------------------------------------
vim.cmd("source " .. config_path .. "/mappings.vim")

--[ #lsp configurations ]]-----------------------------------------------------
local lsp_configurations = {
	servers = {
		"vimls",
		-- "lua_ls",
		"clangd",
		"bashls",
		-- "jqls",
		"jsonls",
		"html",
		"emmet_ls",
		"cssls",
		"tsserver",
		"intelephense",
		"rust_analyzer",
		"gopls",
		"sqls"
	},
	-- cmpkeys = { Next="<Tab>", Prev="<S-Tab>", Abort="<Esc>", Confirm="<CR>" },
	cmpkeys = { Next = "<C-n>", Prev = "<C-p>", Abort = "<C-c>", Confirm = "<C-y>", Show = "<C-Space>" },
	lspkeys = {
		Hover = "K",
		Definition = "gd",
		Declaration = "gD",
		References = "gr",
		Signature = "<A-k>",
		CodeAction = "<leader>ca",
		Format = "<leader>cf",
		Rename = "<leader>cr",
	},
}

--[[ #icons ]] ------------------------------------------------------------------
local icons = {
	autocomplete = {
		Text = "󰦨 ",
		Method = "󰅲 ",
		Function = "󰊕 ",
		Constructor = " ",
		Field = " ",
		Variable = "󰫧 ",
		Class = "󰠱 ",
		Interface = " ",
		Module = " ",
		Property = " ",
		Unit = " ",
		Value = "󰎠 ",
		Enum = " ",
		Keyword = "󰌋 ",
		Snippet = " ",
		Color = "󰏘 ",
		File = "󰈙 ",
		Reference = "",
		Folder = "󰉋",
		EnumMember = " ",
		Constant = "󰏿 ",
		Struct = " ",
		Event = " ",
		Operator = "󰆕 ",
		TypeParameter = " ",
	},
	diagnostics = { DiagnosticSignError = " ", DiagnosticSignWarn = " ", DiagnosticSignInfo = " ", DiagnosticSignHint = "󰌵 " },
	dashboard = { NewFile = "󰝒", FindFile = "󰱼", FindText = "󱎸", RestoreSession = "󰁯", Command = "󰞷", Colors = "", Settings = "", Cat = "󰄛", Calendar = "󰸗", Git = "󰊢" },
	statusline = {
		{ "", "", "", "" },
		{ "", "", "╲", "╱" },
		{ "", "", "", "" },
		{ "", "", "╲", "" },
		{ "", "", "╱", "╱" },
		{ "", "", "╏", "╏" },
		{ "▓▒░", "░▒▓", "", "" },
		{ " ", " ", " ", " " },
		{ " ", " ", " ", " " },
		{ " ", " ", " ", " " },
		{ " ", "", " ", " " },
		{ " ", " ", " ", " " },
	},
}

--[[ #functions ]] ----------------------------------------------------------------
function SessionLoad(prefix)
	local dir = vfn.stdpath("config") .. "/.sessions"
	local filename = dir .. "/" .. vfn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
	if vfn.filereadable(filename) == 1 then
		vcmd("source " .. filename)
	else
		vim.notify("No sessions to load")
	end
end

function SessionSave(prefix)
	prefix = prefix or "";
	local dir = vfn.stdpath("config") .. "/.sessions"
	local filename = dir .. "/" .. vfn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
	if vfn.isdirectory(dir) == 0 then
		vfn.mkdir(dir, "p"); vcmd("redraw!")
	end
	vcmd("mksession! " .. filename)
end

function FixHighlights()
	local link_higroups = {
		NormalNC = "Normal",
		FloatBorder = "NormalFloat",
		TelescopeNormal = "NormalFloat",
		TelescopeBorder = "FloatBorder",
	}
	for hi, link in pairs(link_higroups) do
		vcmd("hi clear " .. hi)
		vcmd("hi link " .. hi .. " " .. link)
	end
end

function NoneBg()
	local bg_higroups = {
		"Normal", "NormalFloat", "SignColumn", "SignColumnSB", "CursorLineNr", "LineNr", "LineNrAbove", "LineNrBelow",
		"DiagnosticSignHint", "DiagnosticSignInfo", "DiagnosticSignWarn", "DiagnosticSignError",
		"GitSignsAdd", "GitSignsAddPreview", "GitSignsStagedAdd",
		"GitSignsChange", "GitSignsChangePreview", "GitSignsStagedChange",
		"GitSignsDelete", "GitSignsDeletePreview", "GitSignsStagedDelete",
		"GitSignsStagedTopdelete", "GitSignsStagedChangedelete",
		"WinBarNC", "WinSeparator",
		"lualine_c_normal", "lualine_c_inactive",
		"lualine_b_windown_inactive",
	}
	for _, higroup in pairs(bg_higroups) do vcmd("hi " .. higroup .. " guibg=none") end
end

function RepositoryLink()
	local remote = vfn.system('git remote get-url origin'):gsub("\n", "")
	local branch = vfn.system('git rev-parse --abbrev-ref HEAD'):gsub("\n", "")
	local owner, repo = remote:match(":(.-)/(.-)%.git")
	local url = string.format("https://github.com/%s/%s/blob/%s/%s#L%d", owner, repo, branch, vfn.expand('%:.'),
		vfn.line('.'))
	return url
end

--[[ #plugins configutaions ]] --------------------------------------------------
local lazypath = vfn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vfn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
	-- plugins@telescope
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
		require "telescope".setup {
			defaults = {
				wrap_results         = false,
				borderchars          = { " ", " ", " ", " ", " ", " ", " ", " " },
				path_display         = { "smart" },
				file_ignore_patterns = {
					".git/.*",                         -- common
					"node_modules/.*", "build/.*", "dist/.*", -- JS/TS
					".godot/.*", "addons/.*",          -- Godot
					"%.tscn$", "%.gd.uid$", "%.png$", "%.png.import$" -- Godot
				},
				sorting_strategy     = 'ascending',
				selection_caret      = "> ",
				-- selection_caret      = "  ",
				--selection_caret      = "󰚺 ",
				selection_strategy   = 'reset',
				layout_strategy      = 'horizontal',
				layout_config        = {
					horizontal = { prompt_position = 'top', mirror = false },
					vertical   = { prompt_position = 'top', mirror = false },
				},
			},
			pickers = {
				find_files           = { layout_strategy = "horizontal", path_display = { "truncate " }, hidden = true },
				git_status           = { layout_strategy = "horizontal", path_display = { "truncate" } },
				buffers              = { layout_strategy = "horizontal", path_display = { "truncate" } },
				diagnostics          = { layout_strategy = "vertical", wrap_results = true, path_display = { "hidden" } },
				live_grep            = { layout_strategy = "vertical" },
				lsp_document_symbols = { layout_strategy = "vertical" },
				lsp_references       = { theme = "dropdown", jump_type = "never", path_display = { "truncate" }, border = false },
				lsp_definitions      = { theme = "dropdown", jump_type = "never", path_display = { "truncate" }, border = false },
				colorscheme          = { enable_preview = true },
			},
		}
	end },
	-- plugins@lualine
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
		require "lualine".setup {
			options = {
				component_separators = { left = icons.statusline[statusline_style][3], right = icons.statusline[statusline_style][4] },
				section_separators   = { left = icons.statusline[statusline_style][1], right = icons.statusline[statusline_style][2] },
			},
			winbar = {
				lualine_b = {
					{ function()
						return vim.fn.reg_recording() ~= '' and
							'%#DiffDelete#%=  Recording @' .. vim.fn.reg_recording() .. '%='
							or '%=%f%='
					end, use_mode_colors = true },
				},
			},
			inactive_winbar = {
				lualine_c = { '%=%f%=' },
			},
			tabline = {
				lualine_a = { { "buffers", max_length = vim.o.columns * 0.9 } },
				lualine_x = { "branch" }, lualine_z = { "tabs" },
			},
			sections = {
				lualine_a = { "mode" }, lualine_b = { "diff", "diagnostics" }, lualine_c = { { "filename", path = 0, shorting_target = 0 } },
				lualine_x = { "filetype", "selectioncount" }, lualine_y = { "encoding", "filesize" }, lualine_z = { "location", "progress" },
			},
			inactive_sections = {
				lualine_c = { { "filename", path = 0, shorting_target = 0, use_mode_colors = true } },
				lualine_b = { { "windows", mode = 1, use_mode_colors = true } }
			},
		}
	end },
	-- plugins@oil
	{ "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
		require "oil".setup {
			columns = {
				{ "mtime", highlight = "Comment" },
				{ "size",  highlight = "Label" },
				{ "icon",  highlight = "Normal" },
			},
			float = { border = "solid", max_width = 120, max_height = 40 },
			win_options = { number = false, relativenumber = false, conceallevel = 3, concealcursor = "nvic" },
			view_options = { show_hidden = true },
			default_file_explorer = true,
		}
	end },
	-- plugins@fterm
	{ "numToStr/FTerm.nvim", config = function()
		require "FTerm".setup {
			border = "solid",
			hl = "NormalFloat",
		}
	end },
	-- plugins@gitsigns
	{ "lewis6991/gitsigns.nvim", config = function()
		require "gitsigns".setup {
			auto_attach = true,
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			preview_config = { border = "solid" },
		}
	end },
	-- plugins@treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
		require 'nvim-treesitter.configs'.setup {
			auto_instal = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
	end },
	-- plugins@mason
	{ "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim" }, config = function()
		require "mason".setup {}
		require "mason-lspconfig".setup { ensure_installed = lsp_configurations.servers }
	end },
	-- plugins@lspconfig
	{ "neovim/nvim-lspconfig", dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim" }, config = function()
		local lspconfig = require "lspconfig"
		local on_attach = function(client, bufn)
			local opts = { buffer = bufn, noremap = true, silent = true }
			-- vim.notify("LSP attached: " .. client.name)
		end
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		for _, lsp in ipairs(lsp_configurations.servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					diagnostics = { enable = true },
					inlay_hint = { enable = true },
					inlay_hints = { enable = true },
				},
			})
		end

		lspconfig.eslint.setup {
			name = 'eslint',
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function() return vim.fn.getcwd() end,
			settings = {
				useFlatConfig = true,
				experimental = { useFlatConfig = true },
			}
		}

		-- Godot setup
		-- --server /tmp/godot.pipe --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"
		lspconfig.gdscript.setup {
			name = 'gdscript',
			capabilities = capabilities,
			-- on_attach = on_attach,
			on_attach = function(client, bufn)
				vim.fn.serverstart "/tmp/godot.pipe"; on_attach(client, bufn)
			end,
			cmd = vim.lsp.rpc.connect('127.0.0.1', '6005'),
			filetypes = { "gd", "gdscript" },
			root_dir = require("lspconfig").util.root_pattern("project.godot"),
		}

		lspconfig.lua_ls.setup {
			name = 'lua_ls',
			capabilities = capabilities,
			filetypes = { "lua", "script" },
			on_attach = on_attach,
			root_dir = function() return vim.fn.getcwd() end,
			-- settings = {
			-- 	Lua = {
			-- 		diagnostics = { globals = { 'go', 'msg', 'vmath', 'hash' } },
			-- 		workspace = {
			-- 			-- library = {
			-- 			-- 	vim.fn.expand('~/path/to/defold_stubs')
			-- 			-- },
			-- 			checkThirdParty = false,
			-- 		},
			-- 	},
			-- },
		}

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover, { border = "solid" })
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help, { border = "solid" })
	end },
	-- plugins@snippets
	{ "L3MON4D3/LuaSnip", lazy = false, config = function()
		local vscode_snippet_path = vim.fn.expand("~/Library/Application Support/VSCodium/User/snippets")
		require "luasnip.loaders.from_vscode".load { paths = { vscode_snippet_path } }
		--print(vscode_snippet_path)
		--print(vim.inspect(require("luasnip").snippets))
	end },
	-- plugins@cmp
	{ "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip" }, config = function()
		local cmp = require "cmp"
		local luasnip = require "luasnip"
		cmp.setup {
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer",  keyword_length = 4 },
			},
			snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
			formatting = { format = function(_, i)
				local kind = i.kind
				i.kind = (icons.autocomplete[kind] or "?")
				i.menu = "" .. kind
				return i
			end },
			completion = { completeopt = "menu,menuone,noinsert" },
			-- completion = { completeopt = "menu,menuone,preview,noinsert" },
			window = {
				completion = { border = "" },
				documentation = { border = "solid" },
			},
			mapping = {
				[lsp_configurations.cmpkeys.Next]    = cmp.mapping.select_next_item(),
				[lsp_configurations.cmpkeys.Prev]    = cmp.mapping.select_prev_item(),
				[lsp_configurations.cmpkeys.Abort]   = cmp.mapping.abort(),
				[lsp_configurations.cmpkeys.Confirm] = cmp.mapping.confirm({ select = false }),
				[lsp_configurations.cmpkeys.Show]    = cmp.mapping.complete(),
			},
		}
	end },
	-- plugins@alpha
	{ "goolord/alpha-nvim", config = function()
		local theta = require "alpha.themes.theta"
		local dashboard = require "alpha.themes.dashboard"
		local section_mru = theta.config.layout[4];
		local timestr = os.date("󰸗 %a %d %b") ..
			string.rep(' ', 31) .. os.date("%I:%M ") .. (os.date("%p") == 'am' and "" or "");
		theta.header.val = meovim
		theta.buttons.val = {
			{ type = "text",    val = timestr, opts = { position = "center", hl = "Constant" } },
			{ type = "padding", val = 1 },
			dashboard.button("e", icons.dashboard.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", icons.dashboard.FindFile .. "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("t", icons.dashboard.FindText .. "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("r", icons.dashboard.RestoreSession .. "  Restore session", ":lua SessionLoad() <CR>"),
			dashboard.button("s", icons.dashboard.Settings .. "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("g", icons.dashboard.Git .. "  Git", ":lua require'FTerm'.run'lazygit'<CR>"),
			dashboard.button("c", icons.dashboard.Colors .. "  Colorscheme", ":Telescope colorscheme<CR>"),
			dashboard.button("q", icons.dashboard.Cat .. "  Quit", ":qa<CR>"),
		}
		section_mru.val[1] = { type = "text", val = string.rep("▁", 50), opts = { position = "center", hl = "Constant" } };
		theta.config.layout = {
			{ type = "padding", val = 1 },
			theta.header,
			{ type = "padding", val = 1 },
			theta.buttons,
			section_mru,
		}
		require "alpha".setup(theta.config)
	end },
	-- plugins@flash
	{ "folke/flash.nvim", config = function()
		require "flash".setup {
		}
	end },
	-- plugins@colorschemes
	{ "rebelot/kanagawa.nvim",       name = "kanagawa" },
	{ "folke/tokyonight.nvim",       name = "tokyonight" },
	{ "catppuccin/nvim",             name = "catppuccin" },
	{ "rose-pine/neovim",            name = "rosepine" },
	{ "akinsho/horizon.nvim",        name = "horizon" },
	{ "AlexvZyl/nordic.nvim",        name = "nordic" },
	{ "neanias/everforest-nvim",     name = "everforest" },
	{ "projekt0n/github-nvim-theme", name = "github" },
}

--[[ #apply config ]] -----------------------------------------------------------
for global, value in pairs(globals) do vim.g[global] = value end
for option, value in pairs(options) do vim.opt[option] = value end
for hl, icon in pairs(icons.diagnostics) do vfn.sign_define(hl, { text = icon, texthl = hl }) end

vcmd [[
    set path+=**
    set wildmenu
    set updatetime=1000
    set timeoutlen=2000
    set sessionoptions+=options
]]
vcmd [[
    augroup MeoVim
    autocmd!
    autocmd VimResized  * wincmd =
    autocmd VimLeave    * lua if vim.fn.confirm("Save session?", "&Yes\n&No", 2) == 1 then SessionSave() end
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd FileType netrw au BufEnter <buffer> if winnr('$')==1|q|endif
    autocmd ColorScheme * lua FixHighlights()
    augroup END
]]
vcmd [[
    command! -nargs=0 MVSourceConfig        :so ~/.config/nvim/init.lua
    command! -nargs=1 MVYankCmdOutput       :let @+=system('<args>')
    command! -nargs=? MVSessionLoad         :lua SessionLoad('<args>')
    command! -nargs=? MVSessionSave         :lua SessionSave('<args>')
    command! -nargs=0 MVNoneBg              :lua NoneBg()
    command! -nargs=0 MVRepositoryLink      call setreg('+', luaeval('RepositoryLink()'))
]]

vcmd("colorscheme " .. colorscheme)

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.script",
    command = "set filetype=lua"
})

