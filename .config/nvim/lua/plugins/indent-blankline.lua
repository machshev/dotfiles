return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',
    opts = {},
    keys = {
        { '<leader>ui', '<cmd>IBLToggle<cr>', mode = 'n', desc = 'Toggle indent guides' },
    },
}
