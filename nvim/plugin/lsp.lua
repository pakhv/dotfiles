vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/seblyng/roslyn.nvim' }
})

require('mason').setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

vim.lsp.config("roslyn", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true
      }
    },
  }
})

vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.setqflist({ severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } })
end)
