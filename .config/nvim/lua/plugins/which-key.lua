return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        plugins = { spelling = true },
        defaults = {
            ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
            ['<leader>n'] = { name = '[N]eovim', _ = 'which_key_ignore' },
            ['<leader>o'] = { name = '[O]rg', _ = 'which_key_ignore' },
            ['<leader>p'] = { name = '[P]ath Exp', _ = 'which_key_ignore' },
            ['<leader>q'] = { name = '[Q]uickfix', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
            ['<leader>u'] = { name = '[U]I', _ = 'which_key_ignore' },
            ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        },
    },
    config = function(_, opts)
        local wk = require('which-key')
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
