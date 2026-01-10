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
        'saghen/blink.cmp',
      },
      config = function()
        local border = 'rounded'

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
          callback = function(event)
            local nmap = function(keys, func, desc)
              if desc then
                desc = 'LSP: ' .. desc
              end

              vim.keymap.set('n', keys, func,
                { buffer = event.buf, desc = desc })
            end

            nmap('<F2>', vim.lsp.buf.rename, 'Rename')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('<leader>r', vim.lsp.buf.references,
              'Add lsp [R]eferences to quickfix list')
            nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gr', require('telescope.builtin').lsp_references,
              '[G]oto [R]eferences')

            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
              '[D]ocument [S]ymbols')

            nmap('K', function() vim.lsp.buf.hover { border = border } end,
              'Hover Documentation')
            vim.keymap.set({ 'i' }, '<C-s>',
              function() vim.lsp.buf.signature_help { border = border } end,
              { desc = 'Signature Documentation', buffer = event.buf })
          end
        })
      end
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
