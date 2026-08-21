vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/tpope/vim-surround' },
  { src = 'https://github.com/nvim-mini/mini.icons' },
  { src = 'https://github.com/stevearc/oil.nvim' },
})
vim.cmd.packadd('nvim.undotree');

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
vim.keymap.set("n", "<leader>e", ":Oil<cr>")

require('vim._core.ui2').enable({
  enable = true,
  msg = {
    target = 'cmd',
    timeout = 4000,
  },
})
