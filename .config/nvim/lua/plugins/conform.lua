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
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
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
