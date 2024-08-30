return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
        format = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
        },
        format_on_save = function(bufnr)
            -- Disable autoformat on certain filetypes
            local ignore_filetypes = { "sql", "java", "c", "cpp" }

            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end

            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end

            -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("/node_modules/") then
                return
            end
            -- ...additional logic...
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        formatters_by_ft = {
            go = { 'goimports', 'gofmt' },
            lua = { 'stylua' },
            sh = { 'shfmt' },
            rust = { 'rustfmt' },
            css = { 'biome' },
            html = { 'biome' },
            json = { 'biome' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
            graphql = { 'prettier' },
            python = { 'ruff_format' },
            javascript = { 'biome', 'eslint_d' },
            typescript = { 'biome', 'eslint_d' },
            javascriptreact = { 'biome', 'eslint_d' },
            typescriptreact = { 'biome', 'eslint_d' },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
        },
    },
    config = function(_, opts)
        require('conform').setup(opts)

        require('conform').formatters.prettier = {
            prepend_args = { '--prose-wrap', 'always' },
        }

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = 'n',
            desc = 'LSP: [C]ode [F]ormat Buffer',
        },
    },
}
