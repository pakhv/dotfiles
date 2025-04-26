return {
  {
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        'folke/neodev.nvim',
        'saghen/blink.cmp',
      },
      config = function()
        local omnisharp_extended = require('omnisharp_extended')
        local border = 'rounded'

        local on_attach = function(_, bufnr, server_name)
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<F2>', vim.lsp.buf.rename, 'Rename')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- since omnisharp doesn't work as expected we extend handlers with another plugin
          if server_name == 'omnisharp' then
            nmap('gd', omnisharp_extended.lsp_definition, '[G]oto [D]efinition')
            nmap('<leader>r', omnisharp_extended.lsp_references, 'Add lsp [R]eferences to quickfix list')
            nmap('gI', omnisharp_extended.lsp_implementation, '[G]oto [I]mplementation')
            nmap('gr', omnisharp_extended.telescope_lsp_references, '[G]oto [R]eferences')
          else
            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('<leader>r', vim.lsp.buf.references, 'Add lsp [R]eferences to quickfix list')
            nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          end

          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          nmap('K', function() vim.lsp.buf.hover { border = border } end, 'Hover Documentation')
          vim.keymap.set({ 'i' }, '<C-s>', function() vim.lsp.buf.signature_help { border = border } end,
            { desc = 'Signature Documentation', buffer = bufnr })

          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
          ts_ls = {},
          lua_ls = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
          omnisharp = {
            cmd = { "dotnet", "omnisharp" },
            enable_roslyn_analyzers = true,
            enable_import_completion = true
          }
        }

        require('neodev').setup()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
        --capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
          ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                on_attach(client, bufnr, server_name)
              end,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end
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
    'Hoffs/omnisharp-extended-lsp.nvim',
  }
}
