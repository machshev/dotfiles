return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            on_colors = function(colors)
                colors.border = '#565f89'
            end,
            lualine_bold = true,
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            vim.cmd.colorscheme('tokyonight')
        end,
    },
}
