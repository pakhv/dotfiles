vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/nvim-mini/mini.statusline' },
  { src = 'https://github.com/tpope/vim-surround' },
  { src = 'https://github.com/nvim-mini/mini.icons' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/RRethy/vim-illuminate' },
})

require('catppuccin').setup({
  transparent_background = true,
  float = { transparent = true, solid = false }
})
vim.cmd.colorscheme 'catppuccin-macchiato'

local statusline = require('mini.statusline')
statusline.setup()
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end

require('mini.icons').setup()
require('oil').setup({
  view_options = {
    show_hidden = true
  }
})
