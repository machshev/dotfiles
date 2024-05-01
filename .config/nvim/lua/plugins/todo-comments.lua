return {
    {
        'folke/todo-comments.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        keys = {
            { '<leader>st', '<cmd>TodoTelescope<cr>', mode = 'n', desc = 'Find Todo-Comments' },
            {
                '<leader>qt',
                '<cmd>TodoQuickFix<cr>',
                mode = 'n',
                desc = 'Quickfix: Todo-Comments',
            },
        },
    },
}
