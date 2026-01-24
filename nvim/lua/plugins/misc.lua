vim.pack.add({
  { src = 'https://github.com/tpope/vim-sleuth' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/nvim-mini/mini.statusline' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/tpope/vim-surround' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' }
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

require('ibl').setup({
  indent = { char = "╎" },
})

vim.pack.add({
  { src = 'https://github.com/echasnovski/mini.icons' },
  { src = 'https://github.com/stevearc/oil.nvim' },
})

require('oil').setup({
  view_options = {
    show_hidden = true
  }
})
