return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    config = function()
      require('nvim-treesitter.configs').setup {

        ensure_installed = { 'lua', 'c_sharp', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

        auto_install = false,

        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "]s",
            node_decremental = "[s",
          },
        },
      }
    end
  }
}
