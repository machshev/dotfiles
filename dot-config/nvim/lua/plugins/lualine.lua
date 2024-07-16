return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                icons_enabled = true,
                section_separators = '',
                component_separators = '',
            }
        },
        config = function(_, opts)
            local custom_theme = require 'lualine.themes.tokyonight'
            custom_theme.inactive.c.bg = '#101010'
            custom_theme.normal.c.bg = '#101010'

            opts["options"]["theme"] = custom_theme
            require('lualine').setup(opts)
        end,
    },
}
