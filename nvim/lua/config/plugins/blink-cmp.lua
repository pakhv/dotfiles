return {
  {
    'saghen/blink.cmp',
    enabled = true,

    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = 'luasnip' },
      keymap = {
        preset = 'default',
        ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-k>'] = { 'snippet_forward', 'fallback' },
        ['<C-j>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = {
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
          window = { border = 'rounded' }
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = 'lua' },
    }
  }
}
