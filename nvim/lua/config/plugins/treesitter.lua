return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    config = function()
      require('nvim-treesitter.configs').setup {

        ensure_installed = { 'lua', 'c_sharp', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

        auto_install = true,

        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      }
    end
  }
}
