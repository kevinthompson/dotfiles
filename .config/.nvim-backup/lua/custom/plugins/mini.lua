return { 
  'echasnovski/mini.nvim', 
  config = function()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = true }

    require('mini.ai').setup { n_lines = 500 }
    require('mini.icons').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
  end
}
