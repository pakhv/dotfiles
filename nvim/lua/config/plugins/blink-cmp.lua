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
        accept = { auto_brackets = { enabled = false }, },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          snippets = {
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= 'trigger_character'
            end
          }
        }
      },

      fuzzy = { implementation = 'lua' },
    }
  }
}
