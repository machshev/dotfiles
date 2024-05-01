local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local trailing_whitespaces_group =
    vim.api.nvim_create_augroup('TrailingWhitespaces', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    group = trailing_whitespaces_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

local conf_ft_colorscheme = vim.api.nvim_create_augroup('ConfFtColorscheme', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = conf_ft_colorscheme,
    pattern = '*.conf',
    command = [[setf config]],
})
