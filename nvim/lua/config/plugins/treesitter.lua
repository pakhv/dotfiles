return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    config = function()
      require('nvim-treesitter.configs').setup {

        ensure_installed = { 'lua', 'vimdoc', 'vim', 'rust' },

        auto_install = false,

        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      }
    end
  }
}
