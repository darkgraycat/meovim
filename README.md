## Meovim
`Minimal Neovim configuration`
----
#### Target
1. As small as possible config file `< 400~ lines`
2. Painless work even without plugins
3. Ease to customize
4. Structured and readable config
----
#### Features
* Usefull keymaps to allow fast typing and navigation
* Pluginless minimalistic indent guides and brackets autopair
* Pluginless session (confirmation on VimEnter, VimLeave events)
* Consistent highlights to make all floats match one style
* All commonly used opts in one place
* Icons (patched font required)
----
#### Config structure
Config has special structure to allow making fast changes:
1. meovim dashboard art
2. colorscheme
3. keymaps
4. globals and options
5. used icons
6. highlights customization
7. local helper functions and global aliases
8. plugins
9. apply configuration and setup autocmd's
----
#### Plugins used
Total `20` plugins used, including `5` colorchemes:
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
  { "folke/tokyonight.nvim", name = "tokyonight" },
  { "akinsho/horizon.nvim", name = "horizon" },
  { "rose-pine/neovim", name = "rosepine" },
  { "AlexvZyl/nordic.nvim", name = "nordic" },
  { "catppuccin/nvim", name = "catppuccin" },
```
----
#### Useful keymaps
Autopairing & surrounding symbols
```
In insert mode:
Press one of { ( [ " ' ` /* followed by
  <space> - to autopair in line
  <enter> - to opern autopair (only for { ( [ )
In visual mode:
Select range of characters followed by open and closed bracket
  or double tap for strings
```
Surrounding symbols
LSP stuff:
```
<Tab> / <S-Tab> - cycle autocomplete suggestions
<C-n> / <C-p>   - cycle autocomplete(native) suggestions
L               - hover documentation
<leader>ca      - code actions
```
Window/Tabs/Buffers:
```
<A-"arrows"> - change size of current window
<A-=>        - open new tab
<A-]> <A-[>  - next/previos tab
§ ±          - next/previos buffer
d=           - close current tab
d§           - close current buffer
```
Telescope:
```
Press <leader>f then use mnemonic character
Available chars: f, g, b, e, r, d, s
Use <leader>fR to resume
```
GUI:
```
<C-p>       - find files using Telescope
<C-g>       - git wildmenu using Telescope
<C-o>       - edit files using Oil
<C-w>a      - start screen
<C-/>       - Netrw split window
<C-\>       - Floating terminal
<C-|>       - Native split terminal
```
For very lazy me:
```
jk - exit Insert or Command mode
<C-j>, <C-k> - scroll up/down 5 lines
<C-h>, <C-l> - scroll left/right by word
;;          - add ; at the end in Insert mode
,, ..       - move left/right by word in Insert mode
<C-,> <C-.> - move left/right by char in Insert mode
<< >>       - start/end of line in Insert mode

```
And more...
