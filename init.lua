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
-- Use "windows" for inactive sections [v]
-- Using .vimrc enrich current with features [settings left]
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
local cmd, fn = vim.cmd, vim.fn

--[[ #colorscheme ]] ------------------------------------------------------------
local colorscheme = "kanagawa-dragon"
-- local colorscheme = "rose-pine-moon"
-- local colorscheme = "tokyonight-storm"
-- local colorscheme = "rose-pine-moon"
-- local colorscheme = "nordic"
local statusline_style = 4
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
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    autoindent = true,
    smartindent = true,
    shiftround = true,
    expandtab = true,
    --smarttab = true,
    wrap = false,
    list = true,
    listchars = [[multispace:· ,tab:▎  ,]],
    -- fold --
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    foldcolumn = "0",
    foldmethod = "indent",
    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
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
    hlsearch = false,
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
cmd [[
    " keys@shortcuts
    let g:mapleader=" "
    inoremap jk <Esc>
     noremap <C-j> 5j
     noremap <C-k> 5k
     noremap <C-d> <C-d>zz
     noremap <C-u> <C-u>zz
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '>-2<CR>gv=gv
    nnoremap <silent> X f,a<CR><Esc>
    vnoremap <Leader>y "+y
    vnoremap <Leader>p "_dP
    nnoremap <Leader>r "hyiw:s/<C-r>h//g<Left><Left>
    vnoremap <Leader>r "hy:%s/<C-r>h//gc<left><left><left>
    nnoremap <silent> <Leader>w :update<CR>
    inoremap ;; <Esc>==A;<Esc>
    vnoremap ;; :s/\v
        nmap vv va%
    nnoremap <expr> gcc getline('.')[match(getline('.'),'\S'):match(getline('.'),'\S')+2]==#'// ' ? '^df gv==' : '^i// <Esc>'
    vnoremap gcc :normal gcc<CR>
    " keys@remap
         map <C-z> <Nop>
         map q: <Nop>
    " keys@autopair
    inoremap ( ()<Left>
    inoremap [ []<Left>
    inoremap { {}<Left>
    inoremap <expr> ) getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
    inoremap <expr> ] getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
    inoremap <expr> } getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
    inoremap <expr> ' getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
    inoremap <expr> " getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
    inoremap <expr> <CR> (getline('.')[col('.')-2:col('.')-1]=~#'\v(\<\>\|[]\|\{\}\|\(\))') ? '<CR><Esc>O' : '<CR>'
    inoremap <expr> <BS> (getline('.')[col('.')-2:col('.')-1]=~#'\v(''''\|""\|[]\|\{\}\|\(\))') ? '<BS><Del>' : '<BS>'
    " keys@surround
    vnoremap {} <Esc>`>a}<Esc>`<i{<Esc>gvolol
    vnoremap [] <Esc>`>a]<Esc>`<i[<Esc>gvolol
    vnoremap () <Esc>`>a)<Esc>`<i(<Esc>gvolol
    vnoremap "" <Esc>`>a"<Esc>`<i"<Esc>gvolol
    vnoremap '' <Esc>`>a'<Esc>`<i'<Esc>gvolol
    vnoremap `` <Esc>`>a`<Esc>`<i`<Esc>gvolol
    nnoremap <> "hyiw:s/<C-r>h/<<C-r>h><\/<C-r>h>/<CR>f>a
    " keys@navigation
    nnoremap <silent> <C-w>n        :bn<CR>
    nnoremap <silent> <C-w>p        :bp<CR>
    nnoremap <silent> <C-w>d        :<C-U>bp <bar> bd #<CR>
    nnoremap <silent> <C-w><C-n>    :tabn<CR>
    nnoremap <silent> <C-w><C-p>    :tabp<CR>
    nnoremap <silent> <C-w><C-d>    :tabclose<CR>
    nnoremap <silent> <C-w><C-t>    :tab sb<CR>
    nnoremap <silent> <A-Left>      :vertical resize -4<CR>
    nnoremap <silent> <A-Down>      :horizontal resize -4<CR>
    nnoremap <silent> <A-Right>     :vertical resize +4<CR>
    nnoremap <silent> <A-Up>        :horizontal resize +4<CR>
    " keys@terminal
    nnoremap <silent> <C-\> <cmd>lua require'FTerm'.toggle()<CR>
    tnoremap <silent> <C-\> <cmd>lua require'FTerm'.toggle()<CR>
    nnoremap <silent> <A-\> <cmd>term zsh<CR>:setlocal nonumber nornu<CR>:startinsert!<CR>
    tnoremap <silent> <A-\> <C-\><C-n>:bd!<CR>
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
    " keys@lsp
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    inoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <Leader>cf     <cmd>lua vim.lsp.buf.format()<CR>
    nnoremap <Leader>cr     <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <Leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <Leader>ce     <cmd>lua vim.diagnostic.open_float()<CR>
    " keys@tools
    nnoremap <silent> <C-e>         <cmd>lua require'oil'.toggle_float()<CR>
    nnoremap <silent> <C-p>         <cmd>lua require'telescope.builtin'.find_files()<CR>
    nnoremap <silent> <a-p>         <cmd>lua require'telescope.builtin'.commands()<CR>
    nnoremap <silent> <C-g>h        <cmd>lua require'gitsigns'.preview_hunk_inline()<CR>
    nnoremap <silent> <Leader>er    <cmd>lua require'FTerm'.run'ranger'<CR>
    nnoremap <silent> <Leader>ee    <cmd>lua require'oil'.open()<CR>
    nnoremap <silent> <Leader>fz    <cmd>term fzf<CR>:startinsert!<CR>
    nnoremap <silent> <Leader>ff    <cmd>lua require'telescope.builtin'.find_files()<CR>
    nnoremap <silent> <Leader>fg    <cmd>lua require'telescope.builtin'.live_grep()<CR>
    nnoremap <silent> <Leader>fb    <cmd>lua require'telescope.builtin'.buffers()<CR>
    nnoremap <silent> <Leader>fe    <cmd>lua require'telescope.builtin'.diagnostics()<CR>
    nnoremap <silent> <Leader>fr    <cmd>lua require'telescope.builtin'.lsp_references()<CR>
    nnoremap <silent> <Leader>fd    <cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
    nnoremap <silent> <Leader>fs    <cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>
    nnoremap <silent> <Leader>fp    <cmd>lua require'telescope.builtin'.registers()<CR>
    nnoremap <silent> <Leader>fm    <cmd>lua require'telescope.builtin'.marks()<CR>
    nnoremap <silent> <Leader>fR    <cmd>lua require'telescope.builtin'.resume()<CR>
    nnoremap <silent> <Leader>gg    <cmd>lua require'FTerm'.run'lazygit'<CR>
    nnoremap <silent> <Leader>gdt   <cmd>lua require'gitsigns'.diffthis()<CR>
    nnoremap <silent> <Leader>gbl   <cmd>lua require'gitsigns'.blame_line()<CR>
    nnoremap <silent> <Leader>gbt   <cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>
    nnoremap <silent> <Leader>ghh   <cmd>lua require'gitsigns'.preview_hunk()<CR>
    nnoremap <silent> <Leader>ghr   <cmd>lua require'gitsigns'.reset_hunk()<CR>
    nnoremap <silent> <Leader>ghn   <cmd>lua require'gitsigns'.next_hunk()<CR>
    nnoremap <silent> <Leader>ghp   <cmd>lua require'gitsigns'.prev_hunk()<CR>
]]

--[ #lsp configurations ]]-----------------------------------------------------
local lsp_configurations = {
    servers = {
        "vimls", "lua_ls",
        "clangd",
        "bashls",
        "jqls", "jsonls",
        "html", "emmet_ls",
        "tsserver", "intelephense",
        "rust_analyzer", "gopls",
    },
    -- cmpkeys = { Next="<Tab>", Prev="<S-Tab>", Abort="<Esc>", Confirm="<CR>" },
    cmpkeys = { Next = "<C-n>", Prev = "<C-p>", Abort = "<C-c>", Confirm = "<C-y>" },
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
    dashboard = { NewFile = "󰝒", FindFile = "󰱼", FindText = "󱎸", RestoreSession = "󰁯", Terminal = "󰚺", Colors = "", Settings = "", Cat = "󰄛", Calendar = "󰸗" },
    statusline = {
        { "", "", "", "" },
        { "", "", "╲", "╱" },
        { "", "", "", "" },
        { "", "", "╲", "" },
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
    local dir = fn.stdpath("config") .. "/.sessions"
    local filename = dir .. "/" .. fn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
    if fn.filereadable(filename) == 1 then
        cmd("source " .. filename)
    else
        vim.notify("No sessions to load")
    end
end

function SessionSave(prefix)
    prefix = prefix or "";
    local dir = fn.stdpath("config") .. "/.sessions"
    local filename = dir .. "/" .. fn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
    if fn.isdirectory(dir) == 0 then
        fn.mkdir(dir, "p"); cmd("redraw!")
    end
    cmd("mksession! " .. filename)
end

function FixHighlights()
    local link_higroups = {
        NormalNC = "Normal",
        FloatBorder = "NormalFloat",
        TelescopeNormal = "NormalFloat",
        TelescopeBorder = "FloatBorder",
    }
    for hi, link in pairs(link_higroups) do
        cmd("hi clear " .. hi)
        cmd("hi link " .. hi .. " " .. link)
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
        "lualine_c_normal", "lualine_c_inactive",
    }
    for _, higroup in pairs(bg_higroups) do cmd("hi " .. higroup .. " guibg=none") end
end

function GitLineLink()
    local remote = fn.system('git remote get-url origin'):gsub("\n", "")
    local branch = fn.system('git rev-parse --abbrev-ref HEAD'):gsub("\n", "")
    local owner, repo = remote:match(":(.-)/(.-)%.git")
    local url = string.format("https://github.com/%s/%s/blob/%s/%s#L%d", owner, repo, branch, fn.expand('%:.'),
        fn.line('.'))
    return url
end

--[[ #plugins configutaions ]] --------------------------------------------------
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
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
                borderchars          = { "", " ", " ", " ", "", "", "", "" },
                path_display         = { "smart" },
                file_ignore_patterns = { "node_modules/.*", "build/.*", "dist/.*" },
                sorting_strategy     = 'ascending',
                selection_caret      = "󰚺 ",
                selection_strategy   = 'reset',
                layout_strategy      = 'horizontal',
                layout_config        = {
                    horizontal = { prompt_position = 'top', mirror = true },
                    vertical   = { prompt_position = 'top', mirror = true },
                },
            },
            pickers = {
                find_files           = { layout_strategy = "horizontal" },
                git_status           = { layout_strategy = "horizontal" },
                buffers              = { layout_strategy = "horizontal" },
                diagnostics          = { layout_strategy = "vertical", wrap_results = true, path_display = { "hidden" } },
                live_grep            = { layout_strategy = "vertical" },
                lsp_document_symbols = { layout_strategy = "vertical" },
                lsp_references       = { theme = "cursor", jump_type = "never", path_display = { "tail" }, border = false },
                lsp_definitions      = { theme = "cursor", jump_type = "never", path_display = { "tail" }, border = false },
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
            tabline = {
                lualine_a = { { "buffers", max_length = vim.o.columns * 0.9 } },
                lualine_x = { "branch" }, lualine_z = { "tabs" },
            },
            sections = {
                lualine_a = { "mode" }, lualine_b = { "diff", "diagnostics" }, lualine_c = { { "filename", path = 1, shorting_target = 0 } },
                lualine_x = { "encoding" }, lualine_y = { "filetype", "selectioncount" }, lualine_z = { "location", "progress" },
            },
            inactive_sections = {
                lualine_c = { { "filename", path = 1, shorting_target = 0, use_mode_colors = true } },
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
    { "nvim-treesitter/nvim-treesitter", config = function()
        require 'nvim-treesitter.configs'.setup {
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
    { "neovim/nvim-lspconfig", dependencies = { "hrsh7th/cmp-nvim-lsp" }, config = function()
        local lspconfig = require "lspconfig"
        local on_attach = function(client, bufn)
            local opts = { buffer = bufn, noremap = true, silent = true }
            vim.notify("LSP attached: " .. client.name)
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
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, { border = "solid" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, { border = "solid" })
    end },
    -- plugins@cmp
    { "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip" }, config = function()
        local cmp = require "cmp"
        cmp.setup {
            sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" } },
            snippet = { expand = function(args) require "luasnip".lsp_expand(args.body) end },
            formatting = { format = function(_, i)
                local kind = i.kind
                i.kind = (icons.autocomplete[kind] or "?")
                i.menu = "" .. kind
                return i
            end },
            completion = { completeopt = "menu,menuone,preview,noinsert" },
            window = {
                completion = { border = "" },
                documentation = { border = "solid" },
            },
            mapping = {
                [lsp_configurations.cmpkeys.Next] = cmp.mapping.select_next_item(),
                [lsp_configurations.cmpkeys.Prev] = cmp.mapping.select_prev_item(),
                [lsp_configurations.cmpkeys.Abort] = cmp.mapping.abort(),
                [lsp_configurations.cmpkeys.Confirm] = cmp.mapping.confirm({ select = false }),
            },
        }
    end },
    -- plugins@alpha
    { "goolord/alpha-nvim", config = function()
        local theta = require "alpha.themes.theta"
        local dashboard = require "alpha.themes.dashboard"
        local section_mru = theta.config.layout[4];
        local timestr = os.date("󰸗 %a %d %b") .. string.rep(' ', 31) .. os.date("%I:%M ") .. (os.date("%p") == 'am' and "" or "");
        theta.header.val = meovim
        theta.buttons.val = {
            { type = "text", val = timestr, opts = { position = "center", hl = "Constant" } },
            { type = "padding", val = 1 },
            dashboard.button("e", icons.dashboard.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", icons.dashboard.FindFile .. "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("g", icons.dashboard.FindText .. "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("r", icons.dashboard.RestoreSession .. "  Restore session", ":lua SessionLoad() <CR>"),
            dashboard.button("s", icons.dashboard.Settings .. "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
            dashboard.button("t", icons.dashboard.Terminal .. "  Terminal", ":lua require'FTerm'.toggle()<CR>"),
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
    -- plugins@venn
    { "jbyuki/venn.nvim", config = function()
    end },

    -- plugins@colorschemes
    { "folke/tokyonight.nvim",     name = "tokyonight" },
    { "akinsho/horizon.nvim",      name = "horizon" },
    { "rose-pine/neovim",          name = "rosepine" },
    { "AlexvZyl/nordic.nvim",      name = "nordic" },
    { "catppuccin/nvim",           name = "catppuccin" },
    { "rebelot/kanagawa.nvim",     name = "kanagawa" },
    { "michaeldyrynda/carbon.vim", name = "carbon" },
}

--[[ #apply config ]] -----------------------------------------------------------
for global, value in pairs(globals) do vim.g[global] = value end
for option, value in pairs(options) do vim.opt[option] = value end
for hl, icon in pairs(icons.diagnostics) do fn.sign_define(hl, { text = icon, texthl = hl }) end

cmd [[
    set path+=**
    set wildmenu
    set updatetime=2000
    set timeoutlen=2000
    set sessionoptions+=options
]]
cmd [[
    augroup MeoVim
    autocmd!
    autocmd VimResized  * wincmd =
    autocmd VimLeave    * lua if vim.fn.confirm("Save session?", "&Yes\n&No", 2) == 1 then SessionSave() end
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd FileType netrw au BufEnter <buffer> if winnr('$')==1|q|endif
    autocmd ColorScheme * lua FixHighlights()
    augroup END
]]
cmd [[
    command! -nargs=0 MVSourceConfig    :so ~/.config/nvim/init.lua
    command! -nargs=1 MVYankCmdOutput   :let @+=system('<args>')
    command! -nargs=? MVSessionLoad     :lua SessionLoad('<args>')
    command! -nargs=? MVSessionSave     :lua SessionSave('<args>')
    command! -nargs=0 MVNoneBg          :lua NoneBg()
    command! -nargs=0 MVGitLineLink     call setreg('+', luaeval('GitLineLink()'))
]]

cmd("colorscheme " .. colorscheme)
--NoneBg()

-- cmd[[
--     let @C = 'gcc0'
--     nnoremap \\ @C
--     vnoremap \\ :normal @C<CR>
-- ]]
