return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            dependencies = {
                "nvim-neotest/nvim-nio",
                'mfussenegger/nvim-dap',
            },
            opts = {},
            config = function(_, opts)
                local dap, dapui = require('dap'), require('dapui')
                dapui.setup(opts)
                dap.listeners.after.event_initialized['dapui_config'] = function()
                    dapui.open()
                end
            end,
            keys = {
                {
                    '<Leader>du',
                    function()
                        require('dapui').toggle()
                    end,
                    mode = 'n',
                    desc = 'DAP: Toggle UI',
                },
                {
                    '<Leader>df',
                    function()
                        require('dapui').float_element()
                    end,
                    mode = 'n',
                    desc = 'DAP: Float element',
                },
                {
                    '<Leader>de',
                    function()
                        require('dapui').float_element()
                    end,
                    mode = 'n',
                    desc = 'DAP: Evaluate expression',
                },
            },
        },
        config = function() end,
        keys = {
            {
                '<leader>db',
                function()
                    require('dap').toggle_breakpoint()
                end,
                mode = 'n',
                desc = 'DAP: Toggle breakpoint',
            },
            {
                '<leader>d<space>',
                function()
                    require('dap').continue()
                end,
                mode = 'n',
                desc = 'DAP: Continue',
            },
            {
                '<leader>dt',
                function()
                    require('dap').terminate()
                end,
                desc = 'DAP: Terminate',
            },
            {
                '<leader>do',
                function()
                    require('dap').step_over()
                end,
                mode = 'n',
                desc = 'DAP: Step over',
            },
            {
                '<leader>di',
                function()
                    require('dap').step_into()
                end,
                mode = 'n',
                desc = 'DAP: Step into',
            },
            {
                '<leader>dx',
                function()
                    require('dap').step_out()
                end,
                mode = 'n',
                desc = 'DAP: Step out',
            },
            {
                '<Leader>dr',
                function()
                    require('dap').repl.open()
                end,
                mode = 'n',
                desc = 'DAP: REPL',
            },
            {
                '<Leader>dl',
                function()
                    require('dap').run_last()
                end,
                mode = 'n',
                desc = 'DAP: Run last',
            },
        },
    },
    {
        'folke/which-key.nvim',
        optional = true,
        opts = {
            defaults = {
                ['<leader>d'] = { name = '+Debug' },
            },
        },
    },
}
