return {
    {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
    },
    {
        'scalameta/nvim-metals',
        ft = { 'scala', 'sbt', },
        dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
        config = function()
            local metals_config = require('metals').bare_config()
            metals_config.init_options.statusBarProvider = 'on'
            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
            }
            metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
            metals_config.on_attach = function(_, _)
                require('metals').setup_dap()
            end

            local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'scala', 'sbt', 'java' },
                callback = function()
                    require('metals').initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })

            -- Debug settings
            local dap = require('dap')
            dap.configurations.scala = {
                {
                    type = 'scala',
                    request = 'launch',
                    name = 'RunOrTest',
                    metals = {
                        runType = 'runOrTestFile',
                        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                    },
                },
                {
                    type = 'scala',
                    request = 'launch',
                    name = 'Test Target',
                    metals = {
                        runType = 'testTarget',
                    },
                },
            }
            vim.keymap.set('n', '<leader>csa', function()
                require('metals').new_scala_file()
            end, { desc = 'New Scala file' })
            vim.keymap.set('n', '<leader>csr', function()
                require('metals').restart_metals()
            end, { desc = 'Restart Metals' })
        end,
        keys = {
            {
                '<leader>cs<space>',
                function()
                    require('telescope').extensions.metals.commands()
                end,
                mode = 'n',
                desc = 'Commands',
            },
        },
    },
    {
        'folke/which-key.nvim',
        optional = true,
        opts = {
            defaults = {
                ['<leader>cs'] = { name = '+Scala' },
            },
        },
    },
}
