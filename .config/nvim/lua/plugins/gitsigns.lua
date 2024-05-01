return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            vim.keymap.set(
                'n',
                '<leader>gp',
                require('gitsigns').preview_hunk,
                { buffer = bufnr, desc = 'Git: Preview hunk' }
            )
            vim.keymap.set(
                'n',
                '<leader>gs',
                require('gitsigns').stage_buffer,
                { buffer = bufnr, desc = 'Git: Stage buffer' }
            )
            vim.keymap.set(
                'n',
                '<leader>gh',
                require('gitsigns').stage_hunk,
                { buffer = bufnr, desc = 'Git: Stage Hunk' }
            )

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then
                    return ']c'
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then
                    return '[c'
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
        end,
    },
}
