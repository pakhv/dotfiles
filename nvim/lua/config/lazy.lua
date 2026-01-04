local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'NMAC427/guess-indent.nvim',
  'tpope/vim-fugitive',
  { 'folke/which-key.nvim',   opts = {} },
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })

      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  {
    'nvim-mini/mini.statusline',
    version = false,
    config = function()
      local statusline = require('mini.statusline')
      statusline.setup()

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end
  },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = 'onedark',
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --   },
  -- },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      indent = { char = "╎" },
    },
  },
  'tpope/vim-surround',
  'nvim-neotest/nvim-nio',
  { import = "config.plugins" },
}, {})

-- vim: sw=2 et
