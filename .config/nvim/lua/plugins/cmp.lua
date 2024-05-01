return {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                'rafamadriz/friendly-snippets',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                end,
            },
            opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        },
    },
    opts = function()
        ---@diagnostic disable-next-line: different-requires
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local defaults = require('cmp.config.default')()
        luasnip.config.setup({})

        local cmp_icons = true
        local lspkind_text = true

        local utils = require('utils').cmp
        local formatting_style = {
            fields = { 'kind', 'abbr', 'menu' },

            format = function(_, item)
                local icon = (cmp_icons and utils.icons[item.kind]) or ''
                icon = ' ' .. icon .. ' '
                item.menu = lspkind_text and '   (' .. item.kind .. ')' or ''
                item.kind = icon

                return item
            end,
        }

        local border = utils.border
        return {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            window = {
                documentation = {
                    border = border('CmpDocBorder'),
                    winhighlight = 'Normal:CmpDoc',
                },
            },
            formatting = formatting_style,
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'orgmode' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'neorg' },
                { name = 'mkdnflow' },
            }, {
                { name = 'buffer' },
            }),
            experimental = {
                ghost_text = {
                    hl_group = 'CmpGhostText',
                },
            },
            sorting = defaults.sorting,
        }
    end,
    config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        require('cmp').setup(opts)
    end,
}
