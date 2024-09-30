return {
    {
        'simrat39/rust-tools.nvim',
        event = 'BufEnter',
        ft = {
            'rs',
        },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'mfussenegger/nvim-dap',
        },
        config = function()
            local extension_path = vim.env.HOME
                .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb'

            liblldb_path = liblldb_path .. '.dylib'

            local rt = require('rust-tools')
            local opts = {
                server = {
                    on_attach = function(_, bufnr)
                        vim.keymap.set(
                            'n',
                            'K',
                            rt.hover_actions.hover_actions,
                            { buffer = bufnr, desc = 'Rust: Hover actions' }
                        )
                        vim.keymap.set(
                            'n',
                            '<leader>ca',
                            rt.code_action_group.code_action_group,
                            { buffer = bufnr, desc = 'Rust: Code Action' }
                        )
                        vim.keymap.set(
                            'n',
                            '<leader>cR<space>',
                            rt.runnables.runnables,
                            { buffer = bufnr, desc = 'Rust: Runnables' }
                        )
                        vim.keymap.set(
                            'n',
                            '<leader>cRd',
                            rt.debuggables.debuggables,
                            { buffer = bufnr, desc = 'Rust: Debuggables' }
                        )
                    end,
                },
                dap = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(
                        codelldb_path,
                        liblldb_path
                    ),
                },
            }

            require('rust-tools').setup(opts)
        end,
    },
    {
        'folke/which-key.nvim',
        optional = true,
        opts = {
            defaults = {
                ['<leader>cR'] = { name = '+Rust' },
            },
        },
    },
}
