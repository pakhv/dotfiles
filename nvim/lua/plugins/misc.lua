vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
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

require('mini.icons').setup()
require('oil').setup({
  view_options = {
    show_hidden = true
  }
})

require('vim._extui').enable({
  enable = true, -- Whether to enable or disable the UI.
  msg = {        -- Options related to the message module.
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    ---cmdline or in a separate ephemeral message window.
    target = 'msg',
    timeout = 4000, -- Time a message is visible in the message window.
  },
})
