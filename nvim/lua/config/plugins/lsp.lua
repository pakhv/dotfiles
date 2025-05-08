return {
  {
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'williamboman/mason-lspconfig.nvim',

        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        'folke/neodev.nvim',
        'saghen/blink.cmp',
      },
      config = function()
        local omnisharp_extended = require('omnisharp_extended')
        local border = 'rounded'

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
          callback = function(event)
            local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
            local client_name = client.name

            local nmap = function(keys, func, desc)
              if desc then
                desc = 'LSP: ' .. desc
              end

              vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
            end

            nmap('<F2>', vim.lsp.buf.rename, 'Rename')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- since omnisharp doesn't work as expected we extend handlers with another plugin
            if client_name == 'omnisharp' then
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
          omnisharp = {
            cmd = { "dotnet", "omnisharp" },
            enable_roslyn_analyzers = true,
            enable_import_completion = true
          }
        }

        require('neodev').setup()

        local capabilities = require('blink.cmp').get_lsp_capabilities({}, false)

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        local mason_lspconfig = require('mason-lspconfig')

        mason_lspconfig.setup {
          ensure_installed = {},
          automatic_enable = true,
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

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
    'Hoffs/omnisharp-extended-lsp.nvim',
  }
}
