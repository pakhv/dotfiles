vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = "master" },
})

require('nvim-treesitter.configs').setup(
  {
    ensure_installed = { 'lua', 'c_sharp', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'rust' },

    auto_install = false,

    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
  })
