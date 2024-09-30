return {
    'folke/which-key.nvim',
    dependencies = {
        { 'echasnovski/mini.nvim', version = false },
    },
    event = 'VeryLazy',
    opts = {
        plugins = { spelling = true },
        spec = {
            { '<leader>b', group = '[B]uffer' },
            { '<leader>c', group = '[C]ode' },
            { '<leader>cR', group = 'Rust' },
            { '<leader>cs', group = 'Scala' },
            { '<leader>d', group = '[D]ebug' },
            { '<leader>g', group = '[G]it' },
            { '<leader>gw', group = 'Worktree' },
            { '<leader>n', group = '[N]eovim' },
            { '<leader>o', group = '[O]rg' },
            { '<leader>p', group = '[P]ath Exp' },
            { '<leader>q', group = '[Q]uickfix' },
            { '<leader>r', group = '[R]ename' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>t', group = '[T]est' },
            { '<leader>u', group = '[U]I' },
            { '<leader>w', group = '[W]orkspace' },
        },
    },
    config = function(_, opts)
        require('mini.icons').setup()

        local wk = require('which-key')

        wk.setup(opts)
    end,
}
