return {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    keys = function()
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        return {
            { '<C-e>',     ui.toggle_quick_menu,           mode = 'n', desc = 'Harpoon: Show marks' },
            { '<leader>a', mark.add_file,                  mode = 'n', desc = 'Harpoon: Mark file' },
            { "<F37>",     function() ui.nav_file(1) end,  mode = 'n' },
            { "<F38>",     function() ui.nav_file(2) end,  mode = 'n' },
            { "<F39>",     function() ui.nav_file(3) end,  mode = 'n' },
            { "<F40>",     function() ui.nav_file(4) end,  mode = 'n' },
            { "<F41>",     function() ui.nav_file(5) end,  mode = 'n' },
            { "<F42>",     function() ui.nav_file(6) end,  mode = 'n' },
            { "<F43>",     function() ui.nav_file(7) end,  mode = 'n' },
            { "<F44>",     function() ui.nav_file(8) end,  mode = 'n' },
            { "<F45>",     function() ui.nav_file(9) end,  mode = 'n' },
            { "<F46>",     function() ui.nav_file(10) end, mode = 'n' },
        }
    end,
}
