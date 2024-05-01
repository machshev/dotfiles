return {
    "gbprod/yanky.nvim",
    enabled = true,
    keys = function()
        return {
            {"p", "<Plug>(YankyPutAfter)" , mode = {'n', "x"}},
            {"P", "<Plug>(YankyPutBefore)" , mode = {'n', "x"}},
            {"gp", "<Plug>(YankyGPutAfter)" , mode = {'n', "x"}},
            {"gP", "<Plug>(YankyGPutBefore)" , mode = {'n', "x"}},

            {"<c-p>", "<Plug>(YankyPreviousEntry)", mode = 'n'},
            {"<c-n>", "<Plug>(YankyNextEntry)", mode = 'n'},

			{"]p", "<Plug>(YankyPutIndentAfterLinewise)", mode = 'n'},
			{"[p", "<Plug>(YankyPutIndentBeforeLinewise)", mode = 'n'},
			{"]P", "<Plug>(YankyPutIndentAfterLinewise)", mode = 'n'},
			{"[P", "<Plug>(YankyPutIndentBeforeLinewise)", mode = 'n'},

			{">p", "<Plug>(YankyPutIndentAfterShiftRight)", mode = 'n'},
			{"<p", "<Plug>(YankyPutIndentAfterShiftLeft)", mode = 'n'},
			{">P", "<Plug>(YankyPutIndentBeforeShiftRight)", mode = 'n'},
			{"<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", mode = 'n'},

			{"=p", "<Plug>(YankyPutAfterFilter)", mode = 'n'},
			{"=P", "<Plug>(YankyPutBeforeFilter)", mode = 'n'},
        }
    end,
    opts = {
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 100,
        },
    },
}
