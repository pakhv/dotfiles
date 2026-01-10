return {
  {
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        {
          'mason-org/mason.nvim',
          opts = {
            registries = {
              "github:mason-org/mason-registry",
              "github:Crashdummyy/mason-registry",
            },
          }
        },
        { 'j-hui/fidget.nvim', opts = {} },
      },
    },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
    { "seblyng/roslyn.nvim" },
  }
}
