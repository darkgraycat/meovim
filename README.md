## Meovim
`Minimal Neovim configuration`

#### Target
1. As small as possible config file `< 400~ lines`
2. Painless work without plugins
3. Ease to customize
4. Structured and readable config

#### Features
* Usefull keymaps to allow fast typing and navigation
* Pluginless minimalistic indent guides and brackets autopair
* Pluginless session (confirmation on VimEnter, VimLeave events)
* Consistent highlights to make all floats match one style
* All commonly used opts in one place
* Icons (patched font required)

#### Plugins used
Total `20` plugins used, including `5` colorchemes
List of plugins:
```lua
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
```
