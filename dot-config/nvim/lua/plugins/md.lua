return {
    'jakewvincent/mkdnflow.nvim',
    dependencies = {
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function() vim.fn["mkdp#util#install"]() end,
        },
    },
    config = function()
        require('mkdnflow').setup({
            -- Config goes here; leave blank for defaults
        })
    end
}
