vim.pack.add({
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/L3MON4D3/LuaSnip',            version = vim.version.range("^2") },
  { src = 'https://github.com/saghen/blink.cmp',            version = vim.version.range("^1") }
})

require('luasnip.loaders.from_vscode').lazy_load()

require('blink-cmp').setup({
  snippets = { preset = 'luasnip' },
  keymap = {
    preset = 'default',
    ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
    ['<Tab>'] = {},
    ['<S-Tab>'] = {},
  },

  appearance = {
    nerd_font_variant = 'mono'
  },
  cmdline = { enabled = false },

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
})
