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
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'mason-org/mason-lspconfig.nvim',
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

        local servers = {
          ts_ls = {},
          lua_ls = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        }

        local capabilities = require('blink.cmp').get_lsp_capabilities({}, false)

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        local mason_lspconfig = require('mason-lspconfig')

        mason_lspconfig.setup {
          ensure_installed = {},
          automatic_installation = false,
          automatic_enable = true,
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend('force', {},
                capabilities, server.capabilities or {})

              require('lspconfig')[server_name].setup(server)
            end
          }
        }

        local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
          callback = function()
            vim.lsp.buf.format()
          end,
          group = format_group,
          pattern = '*',
        })

        vim.diagnostic.config {
          float = { border = border },
          virtual_text = true,
        }
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
-- vim: sw=2 et
