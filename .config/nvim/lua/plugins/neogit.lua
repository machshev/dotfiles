return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',         -- required
        'nvim-telescope/telescope.nvim', -- optional
        'sindrets/diffview.nvim',        -- optional
        'ibhagwan/fzf-lua',              -- optional
    },
    opts = {},
    keys = {
        {
            '<leader>g<space>',
            function()
                require('neogit').open()
            end,
            mode = 'n',
            desc = 'Git Open',
        },
        {
            '<leader>gc',
            function()
                require('neogit').open({ 'commit' })
            end,
            mode = 'n',
            desc = 'Git Commit',
        },
        {
            '<leader>gos',
            function()
                require('neogit').open({ kind = 'split' })
            end,
            mode = 'n',
            desc = '[G]it [O]pen (Split)',
        },
        {
            '<leader>gs',
            function()
               require('telescope.builtin').git_status()
            end,
            mode = 'n',
            desc = '[G]it [S]tatus',
        },
    },
}
