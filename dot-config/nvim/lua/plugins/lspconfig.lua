return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        {
            'j-hui/fidget.nvim',
            opts = {
                notification = {
                    window = {
                        winblend = 0,
                    },
                },
                progress = {
                    display = {
                        progress_icon = { pattern = 'dots', period = 1 },
                    },
                },
            },
        },
        'hrsh7th/cmp-nvim-lsp',
        -- 'williamboman/mason.nvim',
        -- 'williamboman/mason-lspconfig.nvim',
        -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
        'rmagatti/goto-preview',
        { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
        local lsp_plugin = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lsp_plugin.typos_lsp.setup({ capabilities = capabilities })

        lsp_plugin.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        lsp_plugin.terraformls.setup({ capabilities = capabilities })

        lsp_plugin.ansiblels.setup({ capabilities = capabilities })

        lsp_plugin.bashls.setup({ capabilities = capabilities })
        lsp_plugin.yamlls.setup({ capabilities = capabilities })

        -- Nix
        lsp_plugin.nil_ls.setup({ capabilities = capabilities })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'nix',
            callback = function()
                vim.opt_local.shiftwidth = 2
                vim.opt_local.tabstop = 2
                vim.opt_local.softtabstop = 2
            end,
        })

        lsp_plugin.veridian.setup({ capabilities = capabilities })

        lsp_plugin.ruff.setup({ capabilities = capabilities })
        lsp_plugin.pyright.setup({ capabilities = capabilities })
        -- lsp_plugin.pylyzer.setup({ capabilities = capabilities })
        -- lsp_plugin.pylsp.setup({
        --     capabilities = capabilities,
        --     flags = {
        --         debounce_text_changes = 200,
        --     },
        --     settings = {
        --         pylsp = {
        --             plugins = {
        --                 -- formatter options
        --                 black = { enabled = false },
        --                 autopep8 = { enabled = false },
        --                 yapf = { enabled = false },
        --                 ruff = { enabled = false }, -- use ruff-lsp
        --                 -- linter options
        --                 pylint = { enabled = false, executable = 'pylint' },
        --                 pyflakes = { enabled = false },
        --                 pycodestyle = { enabled = false },
        --                 -- type checker
        --                 pylsp_mypy = { enabled = true },
        --                 -- auto-completion options
        --                 jedi_completion = { enabled = false, fuzzy = true },
        --                 -- import sorting
        --                 pyls_isort = { enabled = false, profile = 'black' },
        --             },
        --         },
        --     },
        -- })

        lsp_plugin.clangd.setup({
            capabilities = capabilities,
            filetypes = { 'c', 'cpp' },
        })
        lsp_plugin.rust_analyzer.setup({ capabilities = capabilities })

        lsp_plugin.bufls.setup({
            capabilities = capabilities,
            cmd = { 'bufls', 'serve' },
            filetypes = { 'proto' },
        })

        lsp_plugin.gopls.setup({
            capabilities = capabilities,
            filetypes = { 'go', 'gomod', 'tmpl', 'gotmpl' },
            root_dir = require('lspconfig/util').root_pattern(
                'go.work',
                'go.sum',
                'go.mod',
                '.git'
            ),
            cmd = { 'gopls' },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })

        lsp_plugin.cssls.setup({ capabilities = capabilities })
        lsp_plugin.phpactor.setup({ capabilities = capabilities })
        lsp_plugin.htmx.setup({
            filetypes = { 'html', 'php' },
        })

        local gtp = require('goto-preview')
        gtp.setup({
            width = 120, -- Width of the floating window
            height = 25, -- Height of the floating window
            default_mappings = false, -- Bind default mappings
            debug = false, -- Print debug information
            opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
            post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
            -- You can use "default_mappings = true" setup option
            -- Or explicitly set keybindings
            -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
            -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
            -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
        })

        local telescope = require('telescope.builtin')
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup(
                'UserLspConfig',
                { clear = true }
            ),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local map = function(keys, func, desc)
                    vim.keymap.set(
                        'n',
                        keys,
                        func,
                        { buffer = ev.buf, desc = 'LSP: ' .. desc }
                    )
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
                map(
                    'gpd',
                    gtp.goto_preview_definition,
                    '[G]oto [P]review [D]efinition'
                )
                map('gP', gtp.close_all_win, 'Close all [P]review windows')

                -- Find references for the word under your cursor.
                map('gr', telescope.lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map(
                    'gI',
                    telescope.lsp_implementations,
                    '[G]oto [I]mplementation'
                )
                map(
                    'gpI',
                    gtp.goto_preview_implementation,
                    '[G]oto [P]review [I]mplementation'
                )

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map(
                    '<leader>D',
                    telescope.lsp_type_definitions,
                    'Type [D]efinition'
                )

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map(
                    '<leader>sS',
                    telescope.lsp_document_symbols,
                    '[S]earch [S]ymbols'
                )

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map(
                    '<leader>ws',
                    telescope.lsp_dynamic_workspace_symbols,
                    '[W]orkspace [S]ymbols'
                )
                map(
                    '<leader>wa',
                    vim.lsp.buf.add_workspace_folder,
                    '[W]orkspace [A]dd Folder'
                )
                map(
                    '<leader>wr',
                    vim.lsp.buf.remove_workspace_folder,
                    '[W]orkspace [R]emove Folder'
                )
                map(
                    '<leader>wl',
                    vim.lsp.buf.list_workspace_folders,
                    '[W]orkspace [L]ist Folder'
                )

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap.
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                map('<space>e', vim.diagnostic.open_float, 'Hover diagnostic')
                map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
                map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
                map(
                    '<leader>q<space>',
                    vim.diagnostic.setqflist,
                    'Open diagnostics list'
                )
                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if
                    client
                    and client.server_capabilities.documentHighlightProvider
                then
                    vim.api.nvim_create_autocmd(
                        { 'CursorHold', 'CursorHoldI' },
                        {
                            buffer = ev.buf,
                            callback = vim.lsp.buf.document_highlight,
                        }
                    )

                    vim.api.nvim_create_autocmd(
                        { 'CursorMoved', 'CursorMovedI' },
                        {
                            buffer = ev.buf,
                            callback = vim.lsp.buf.clear_references,
                        }
                    )
                end
            end,
        })
    end,
}
