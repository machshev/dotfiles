return {
    {
        'folke/which-key.nvim',
        optional = true,
        opts = {
            defaults = {
                ['<leader>gw'] = { name = '+Worktree' },
            },
        },
    },
    {
        'ThePrimeagen/git-worktree.nvim',
        config = function()
            require('telescope').load_extension('git_worktree')
        end,
        keys = {
            {
                '<leader>gw<space>',
                function()
                    require('telescope').extensions.git_worktree.git_worktrees()
                end,
                mode = 'n',
                desc = 'Worktree: Show all',
                silent = true,
            },
            {
                '<leader>gwc',
                function()
                    require('telescope').extensions.git_worktree.create_git_worktree()
                end,
                mode = 'n',
                desc = 'Worktree: Create tree',
                silent = true,
            },
        },
    },
}
