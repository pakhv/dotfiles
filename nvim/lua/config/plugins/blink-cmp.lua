return {
  {
    'saghen/blink.cmp',
    enabled = true,

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
    },
  }
}
