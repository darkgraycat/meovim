-- TODO:
-- backup current file [v]
-- Finish lazygit setup
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

--[[ ^w^ MeoVim ^w^ ]]----------------------------------------------------------
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
--[[ #colorscheme ]]------------------------------------------------------------
local colorscheme = "kanagawa-dragon"
local statusline_style = 1

--[[ #globals ]]----------------------------------------------------------------
local globals = {
    mapleader = " ",
    netrw_banner = 0, netrw_showhide = 1, netrw_liststyle = 3,
    netrw_altv = 1, netrw_winsize = 25, netrw_browse_split = 4,
}

--[[ #options ]]----------------------------------------------------------------
local options = {
    -- indent --
    autoindent = true, smartindent = true,
    shiftround = true, shiftwidth = 4,
    expandtab = true, tabstop = 4, softtabstop = 4,
    wrap = false, list = true,
    listchars = [[multispace:· ,tab:⬄  ,]],
    -- fold --
    foldenable = true, foldlevel = 99, foldlevelstart = 99,
    foldcolumn = "0", foldmethod = "indent",
    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
    -- look --
    termguicolors = true,
    number = true, relativenumber = true,
    showmode = false, showcmd = true,
    cursorline = true, showtabline = 2,
    cmdheight = 1, laststatus = 2, signcolumn = "yes",
    pumheight = 8, scrolloff = 8, sidescrolloff = 8,
    -- search --
    ignorecase = true, smartcase = true,
    hlsearch = false, incsearch = true,
    -- other --
    autowrite = true, autoread = true,
    backup = false, swapfile = false,
    splitright = true, splitbelow = true,
    mouse = "a", backspace = "indent,eol,start",
    completeopt = "menu,menuone,preview,noinsert",
}
--[[ #keymaps ]]----------------------------------------------------------------
vim.cmd[[
    let g:mapleader=" "
    inoremap jk <Esc>
    " keys@shortcuts
    vnoremap <Leader>y "+y
    vnoremap <Leader>p "_dP
    vnoremap <Leader>d "_d
    vnoremap <Leader>r "hy:%s/<C-r>h//gc<left><left><left>
    nnoremap <silent> <Leader>w :update<CR>
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '>-2<CR>gv=gv
    nnoremap <silent> X :s/\([\[{(]\|,\)\|\([\]})]\)/\1\r\2<CR>==
    " keys@autopair
    inoremap ( ()<Left>
    inoremap [ []<Left>
    inoremap { {}<Left>
    inoremap < <><Left>
    inoremap <expr> ) getline('.')[col('.')-1]==#')' ? '<Right>' : ')'
    inoremap <expr> ] getline('.')[col('.')-1]==#']' ? '<Right>' : ']'
    inoremap <expr> } getline('.')[col('.')-1]==#'}' ? '<Right>' : '}'
    inoremap <expr> > getline('.')[col('.')-1]==#'>' ? '<Right>' : '>'
    inoremap <expr> ' getline('.')[col('.')-1]==#"'" ? '<Right>' : "''<Left>"
    inoremap <expr> " getline('.')[col('.')-1]==#'"' ? '<Right>' : '""<Left>'
    " keys@surround
    vnoremap {} <Esc>`>a}<Esc>`<i{<Esc>gv
    vnoremap [] <Esc>`>a]<Esc>`<i[<Esc>gv
    vnoremap () <Esc>`>a)<Esc>`<i(<Esc>gv
    vnoremap "" <Esc>`>a"<Esc>`<i"<Esc>gv
    vnoremap '' <Esc>`>a'<Esc>`<i'<Esc>gv
    vnoremap `` <Esc>`>a`<Esc>`<i`<Esc>gv
    nnoremap <> "hyiw:s/<C-r>h/<<C-r>h><\/<C-r>h>/<CR>f>a
    " keys@navigation 
    noremap <C-d> <C-d>zz | noremap <C-j> 5j
    noremap <C-u> <C-u>zz | noremap <C-k> 5k
    nnoremap <silent> <A-Tab>   <C-w><C-w>
    nnoremap <silent> §         :bn<CR>
    nnoremap <silent> ±         :bp<CR>
    nnoremap <silent> d§        :<C-U>bp <bar> bd #<CR>
    nnoremap <silent> <A-=>     :tab sb<CR>
    nnoremap <silent> <A-]>     :tabn<CR>
    nnoremap <silent> <A-[>     :tabp<CR>
    nnoremap <silent> d=        :tabclose<CR>
    nnoremap <silent> <A-Left>  :vertical resize -4<CR>
    nnoremap <silent> <A-Down>  :horizontal resize -4<CR>
    nnoremap <silent> <A-Right> :vertical resize +4<CR>
    nnoremap <silent> <A-Up>    :horizontal resize +4<CR>
    " keys@lsp
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <A-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <Leader>cf     <cmd>lua vim.lsp.buf.format()<CR>
    nnoremap <Leader>cr     <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <Leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <Leader>ce     <cmd>lua vim.diagnostic.open_float()<CR>
    " keys@tools
    nnoremap <silent> <C-w>a        :Alpha<CR>
    nnoremap <silent> <C-w>e        :Lex 25<CR>
    nnoremap <silent> <C-e>         <cmd>lua require'oil'.toggle_float()<CR>
    nnoremap <silent> <C-p>         <cmd>lua require'telescope.builtin'.find_files()<CR>
    nnoremap <silent> <C-g>h        <cmd>lua require'gitsigns'.preview_hunk_inline()<CR>
    nnoremap <silent> <Leader>ee    <cmd>lefta 50vsplit\|lua require'oil'.open()<CR>
    nnoremap <silent> <Leader>er    <cmd>lua require'FTerm'.run'ranger'<CR>
    nnoremap <silent> <Leader>ff    <cmd>lua require'telescope.builtin'.find_files()<CR>
    nnoremap <silent> <Leader>fg    <cmd>lua require'telescope.builtin'.live_grep()<CR>
    nnoremap <silent> <Leader>fb    <cmd>lua require'telescope.builtin'.buffers()<CR>
    nnoremap <silent> <Leader>fe    <cmd>lua require'telescope.builtin'.diagnostics()<CR>
    nnoremap <silent> <Leader>fr    <cmd>lua require'telescope.builtin'.lsp_references()<CR>
    nnoremap <silent> <Leader>fd    <cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
    nnoremap <silent> <Leader>fs    <cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>
    nnoremap <silent> <Leader>fR    <cmd>lua require'telescope.builtin'.resume()<CR>
    nnoremap <silent> <Leader>gg    <cmd>lua require'FTerm'.run'lazygit'<CR>
    nnoremap <silent> <Leader>gd    <cmd>lua require'gitsigns'.diffthis()<CR>
    nnoremap <silent> <Leader>gb    <cmd>lua require'gitsigns'.blame_line()<CR>
    nnoremap <silent> <Leader>gbt   <cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>
    nnoremap <silent> <Leader>gh    <cmd>lua require'gitsigns'.preview_hunk()<CR>
    nnoremap <silent> <Leader>ghr   <cmd>lua require'gitsigns'.reset_hunk()<CR>
    nnoremap <silent> <Leader>ghn   <cmd>lua require'gitsigns'.next_hunk()<CR>
    nnoremap <silent> <Leader>ghp   <cmd>lua require'gitsigns'.prev_hunk()<CR>
    " keys@terminal
    nnoremap <silent> <C-\> <cmd>lua require'FTerm'.toggle()<CR>
    tnoremap <silent> <C-\> <cmd>lua require'FTerm'.toggle()<CR>
    nnoremap <silent> <A-\> <cmd>term zsh<CR>:setlocal nonumber nornu<CR>:startinsert!<CR>
    tnoremap <silent> <A-\> <C-\><C-n>:bd!<CR>
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
    " keys@other
    inoremap <A-CR> <CR><Esc>O
    inoremap <A-BS> <Right><BS>
    inoremap <expr> <CR> getline('.')[col('.')-2]=~'[\(\{\[]' ? '<CR><Esc>O' : '<CR>'
    nnoremap <expr> gcc getline('.')[match(getline('.'),'\S'):match(getline('.'),'\S')+2]==#'// ' ? '^df ' : '^i// <Esc>'
    map <C-z> <Nop>
    map q: <Nop>
]]

--[[ #lsp configurations ]]-----------------------------------------------------
local lsp_configurations = {
    servers = { "lua_ls", "clangd", "tsserver", "rust_analyzer", "html", "gopls", "hls", "intelephense" },
    -- cmpkeys = { Next="<Tab>", Prev="<S-Tab>", Abort="<C-c>", Confirm="<CR>" },
    cmpkeys = { Next="<C-n>", Prev="<C-p>", Abort="<C-c>", Confirm="<C-y>" },
    lspkeys = {
        Hover="K",
        Definition="gd",
        Declaration="gD",
        References="gr",
        Signature="<A-k>",
        CodeAction="<leader>ca",
        Format="<leader>cf",
        Rename="<leader>cr",
    },
}

--[[ #icons ]]------------------------------------------------------------------
local icons = {
    autocomplete = {
        Text = "󰦨 ", Method = "󰅲 ", Function = "󰊕 ", Constructor = " ", Field = " ",
        Variable = "󰫧 ", Class = "󰠱 ", Interface = " ", Module = " ", Property = " ",
        Unit = " ", Value = "󰎠 ", Enum = " ", Keyword = "󰌋 ", Snippet = " ",
        Color = "󰏘 ", File = "󰈙 ", Reference = "", Folder = "󰉋", EnumMember = " ",
        Constant = "󰏿 ", Struct = " ", Event = " ", Operator = "󰆕 ", TypeParameter = " ",
    },
    diagnostics = { DiagnosticSignError = "", DiagnosticSignWarn = "", DiagnosticSignInfo = "", DiagnosticSignHint = "󰌵 " },
    dashboard = { NewFile = "󰝒", FindFile = "󰱼", FindText = "󱎸", RestoreSession = "󰁯", Terminal = "󰚺", Colors = "", Settings = "", Quit = "󰄛" },
    statusline = {
        { "", "", "", "" },
        { "", "", "╲", "╱" },
        { "", "", "", "" },
        { "", "", "╏", "╏" },
        { "▓▒░", "░▒▓", "", "" },
        { " ", " ", " ", " " },
        { " ", " ", " ", " " },
        { " ", " ", " ", " " },
        { " ", "" , " ", " " },
        { " ", " ", " ", " " },
    },
}

--[[ #highlights ]]-------------------------------------------------------------
local highlights = {
    NormalNC = "Normal",
    NormalFloat = "Normal",
    FloatTitle = "Title",
    FloatBorder = "Function",
    TelescopeTitle = "FloatTitle",   TelescopeResultsTitle  = "TelescopeTitle",  TelescopePreviewTitle  = "TelescopeTitle",  TelescopePromptTitle  = "TelescopeTitle",
    TelescopeNormal = "NormalFloat", TelescopeResultsNormal = "TelescopeNormal", TelescopePreviewNormal = "TelescopeNormal", TelescopePromptNormal = "TelescopeNormal",
    TelescopeBorder = "FloatBorder", TelescopeResultsBorder = "TelescopeBorder", TelescopePreviewBorder = "TelescopeBorder", TelescopePromptBorder = "TelescopeBorder",
}

--[[ #functions ]]----------------------------------------------------------------
function SessionLoad(prefix)
    local dir = vim.fn.stdpath("config") .. "/.sessions"
    local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
    if vim.fn.filereadable(filename) == 1 then vim.cmd("source " .. filename)
    else vim.notify("No sessions to load") end
end
function SessionSave(prefix)
    prefix = prefix or "";
    local dir = vim.fn.stdpath("config") .. "/.sessions"
    local filename = dir .. "/" .. vim.fn.getcwd():gsub("/", "_") .. (prefix or "") .. ".vim"
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p"); vim.cmd("redraw!") end
    vim.cmd("mksession! " .. filename)
end
function Highlights()
    -- TODO: using own colorscheme gen in next config iteration we can have correct style
    for hi, link in pairs(highlights) do vim.cmd("hi clear " .. hi) vim.cmd("hi link " .. hi .. " " ..link) end
end
function NoneBg()
    local bg_higroups = {
        "Normal", "SignColumn", "SignColumnSB", "CursorLineNr", "LineNr", "LineNrAbove", "LineNrBelow",
        "DiagnosticSignHint", "DiagnosticSignInfo", "DiagnosticSignWarn", "DiagnosticSignError",
        "GitSignsAdd", "GitSignsAddPreview", "GitSignsStagedAdd",
        "GitSignsChange", "GitSignsChangePreview", "GitSignsStagedChange",
        "GitSignsDelete", "GitSignsDeletePreview", "GitSignsStagedDelete",
        "GitSignsStagedTopdelete", "GitSignsStagedChangedelete",
    }
    for _, higroup in pairs(bg_higroups) do vim.cmd("hi " .. higroup .. " guibg=none") end
end

--[[ #plugins configutaions ]]--------------------------------------------------
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

require"lazy".setup {
    -- plugins@telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function ()
        require"telescope".setup {
            defaults = {
                wrap_results          = false,
                path_display          = { "smart" },
                file_ignore_patterns  = { "node_modules/.*", "build/.*", "dist/.*" },
                sorting_strategy      = 'ascending',
                selection_caret       = "> ",
            },
            pickers = {
                find_files            = { layout_strategy = "horizontal", theme = "ivy" },
                live_grep             = { layout_strategy = "horizontal", theme = "ivy" },
                git_status            = { layout_strategy = "horizontal", theme = "ivy" },
                buffers               = { layout_strategy = "horizontal", theme = "ivy" },
                diagnostics           = { layout_strategy = "vertical", theme = "ivy", wrap_results = true, path_display = { "hidden" } },
                lsp_document_symbols  = { layout_strategy = "vertical", theme = "ivy" },
                lsp_references        = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
                lsp_definitions       = { theme = "cursor", jump_type = "never", path_display = { "tail" } },
                colorscheme           = { enable_preview = true },
            },
        }
    end },
    -- plugins@lualine
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function ()
        require"lualine".setup {
            options = {
                component_separators = { left = icons.statusline[statusline_style][3], right = icons.statusline[statusline_style][4]},
                section_separators   = { left = icons.statusline[statusline_style][1], right = icons.statusline[statusline_style][2]},
            },
            tabline = {
                lualine_a = { { "buffers", max_length = vim.o.columns * 0.9 } },
                lualine_x = { "branch" }, lualine_z = { "tabs" },
            },
            sections = {
                lualine_a = { "mode" }, lualine_b = { "diagnostics", "diff" }, lualine_c = { { "filename", path = 4 } },
                lualine_x = { "encoding" }, lualine_y = { "filetype", "selectioncount" }, lualine_z = { "location", "progress" },
            },
            inactive_sections = {
                lualine_c = { { "filename", path = 1, shorting_target = 0, use_mode_colors = true } },
                lualine_b = { { "windows", mode = 1, use_mode_colors = true } }
            },
        }
    end },
    -- plugins@oil
    { "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function ()
        require"oil".setup {
            columns = {
                { "mtime", highlight = "Comment" },
                { "size",  highlight = "Label" },
                { "icon",  highlight = "Normal" },
            },
            float = { border = "rounded", max_width = 120, max_height = 40 },
            win_options = { number = false, relativenumber = false, conceallevel = 3, concealcursor = "nvic" },
            view_options = { show_hidden = true },
            default_file_explorer = true,
        }
    end },
    -- plugins@fterm
    { "numToStr/FTerm.nvim", config = function ()
        require"FTerm".setup {
            border = "rounded",
            hl = "Function",
        }
    end },
    -- plugins@gitsigns
    { "lewis6991/gitsigns.nvim", config = function ()
        require"gitsigns".setup {
            auto_attach = true,
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            preview_config = { border = "rounded" },
        }
    end },
    -- plugins@treesitter
    { "nvim-treesitter/nvim-treesitter", config = function ()
        require'nvim-treesitter.configs'.setup {
            highlight = { enable = true },
            indent = { enable = true },
        }
    end },
    -- plugins@mason
    { "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim" }, config = function ()
        require"mason".setup {}
        require"mason-lspconfig".setup { ensure_installed = lsp_configurations.servers }
    end },
    -- plugins@lspconfig
    { "neovim/nvim-lspconfig", dependencies = { "hrsh7th/cmp-nvim-lsp" }, config = function ()
        local lspconfig = require"lspconfig"
        local on_attach = function (client, bufn)
            local opts = { buffer = bufn, noremap = true, silent = true }
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Hover, vim.lsp.buf.hover, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Format, vim.lsp.buf.format, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Rename, vim.lsp.buf.rename, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Signature, vim.lsp.buf.signature_help, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.CodeAction, vim.lsp.buf.code_action, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Definition, vim.lsp.buf.definition, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.Declaration, vim.lsp.buf.declaration, opts)
            -- vim.keymap.set("n", lsp_configurations.lspkeys.References, vim.lsp.buf.references, opts)
            -- vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, opts)
            vim.notify("LSP attached: " .. client.name)
        end
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        for _, lsp in ipairs(lsp_configurations.servers) do lspconfig[lsp].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                diagnostics = { enable = true },
                inlay_hint = { enable = true },
                inlay_hints = { enable = true },
            },
        }) end
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    end },
    -- plugins@cmp
    { "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip" }, config = function ()
        local cmp = require"cmp"
        cmp.setup {
            sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" } },
            snippet = { expand = function(args) require"luasnip".lsp_expand(args.body) end },
            formatting = { format = function(_, i) local kind = i.kind i.kind = (icons.autocomplete[kind] or "?") i.menu = "" .. kind return i end },
            completion = { completeopt = "menu,menuone,preview,noinsert" },
            window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
            mapping = {
                [lsp_configurations.cmpkeys.Next] = cmp.mapping.select_next_item(),
                [lsp_configurations.cmpkeys.Prev] = cmp.mapping.select_prev_item(),
                [lsp_configurations.cmpkeys.Abort] = cmp.mapping.abort(),
                [lsp_configurations.cmpkeys.Confirm] = cmp.mapping.confirm({ select = false }),
            },
        }
    end },
    -- plugins@alpha
    { "goolord/alpha-nvim", config = function ()
        local alpha_th = require"alpha.themes.theta"
        local alpha_db = require"alpha.themes.dashboard"
        local alpha_time = tostring(os.date("%A %I:%M %p"))
        alpha_th.header.val = meovim
        alpha_th.header.opts.hl = "Title"
        alpha_th.buttons.val = {
            { type = "text", val = "╭"..string.rep("─", 47 - string.len(alpha_time))..alpha_time.."─╮", opts = { hl = "FloatBorder", position = "center" } },
            alpha_db.button("e", icons.dashboard.NewFile        .. "  New file",        ":ene <BAR> startinsert <CR>"),
            alpha_db.button("f", icons.dashboard.FindFile       .. "  Find file",       ":Telescope find_files <CR>"),
            alpha_db.button("g", icons.dashboard.FindText       .. "  Find text",       ":Telescope live_grep <CR>"),
            alpha_db.button("r", icons.dashboard.RestoreSession .. "  Restore session", ":lua SessionLoad() <CR>"),
            alpha_db.button("s", icons.dashboard.Settings       .. "  Settings",        ":e ~/.config/nvim/init.lua<CR>"),
            alpha_db.button("t", icons.dashboard.Terminal       .. "  Terminal",        ":lua require'FTerm'.toggle()<CR>"),
            alpha_db.button("c", icons.dashboard.Colors         .. "  Colorscheme",     ":Telescope colorscheme<CR>"),
            alpha_db.button("q", icons.dashboard.Quit           .. "  Quit",            ":qa<CR>"),
            { type = "text", val = "╰"..string.rep("─", 48).."╯", opts = { hl = "FloatBorder", position = "center" } },
        }
        require"alpha".setup(alpha_th.config)
    end },
    -- plugins@colorschemes
    { "folke/tokyonight.nvim", name = "tokyonight" },
    { "akinsho/horizon.nvim", name = "horizon" },
    { "rose-pine/neovim", name = "rosepine" },
    { "AlexvZyl/nordic.nvim", name = "nordic" },
    { "catppuccin/nvim", name = "catppuccin" },
    { "rebelot/kanagawa.nvim", name = "kanagawa" },
    { "michaeldyrynda/carbon.vim", name = "carbon" },
}

--[[ #apply config ]]-----------------------------------------------------------
-- TODO: refactor
for global, value in pairs(globals) do vim.g[global] = value end
for option, value in pairs(options) do vim.opt[option] = value end
for hl, icon in pairs(icons.diagnostics) do vim.fn.sign_define(hl, { text = icon, texthl = hl }) end

vim.cmd[[
    set path+=**
    set wildmenu
    set sessionoptions+=options
]]
vim.cmd[[
    augroup MeoVim
    autocmd!
    autocmd VimResized  * wincmd =
    autocmd VimLeave    * lua if vim.fn.confirm("Save session?", "&Yes\n&No", 2) == 1 then SessionSave() end
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd FileType netrw au BufEnter <buffer> if winnr('$')==1|q|endif
    autocmd ColorScheme * lua Highlights()
    augroup END
]]
--function BuffersByType(filetype)
--  local ids = {}
--  for _, id in ipairs(vim.api.nvim_list_bufs()) do
--    if vim.api.nvim_buf_is_valid(id) and
--      vim.api.nvim_buf_get_option(id, 'filetype') == filetype
--    then table.insert(ids, id);
--    end
--  end
--  print("Ids found "..table.concat(ids, ', '))
--  return ids
--end
-- map <expr> <Leader>e getline('.')[col('.')-1]==#'a' ? ':lua Test(1)<CR>' : ':lua Test(2)<CR>'
-- function Test(arg)
--   print("TEST "..arg)
--   print("TEST "..arg)
--   print("TEST "..arg)
-- end

vim.cmd[[
    command! -nargs=0 MVRefresh         :so ~/.config/nvim/init.lua
    command! -nargs=1 MVYankCmdOutput   :let @+=system('<args>')
    command! -nargs=? MVSessionLoad     :lua SessionLoad('<args>')
    command! -nargs=? MVSessionSave     :lua SessionSave('<args>')
    command! -nargs=0 MVNoneBg          :lua NoneBg()
]]

vim.cmd("colorscheme " .. colorscheme)
NoneBg()
