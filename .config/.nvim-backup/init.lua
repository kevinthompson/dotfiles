require('config.lazy')

-- alias to match nvim settings
local set = vim.opt

vim.g.have_nerd_font = true

-- map global leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- use system clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- enable line numbers
set.number = true

-- enable mouse
set.mouse = 'a'

-- display mode in status bar
set.showmode = false

-- show sign column
set.signcolumn = 'yes'

----------

-- setup lazy.nvim
require("lazy").setup({
  'tpope/vim-sleuth',

  spec = {
    { import = "custom.plugins" }
  },

  -- plugin installation theme
  install = { colorscheme = { "tokyonight-night" } },

  -- automatically check for plugin updates
  checker = { 
    enabled = true,
    notify = false
  },
})
