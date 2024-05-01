local M = {}

local go_handler = function(buf)
    local test_file = string.gsub(buf, "(.+)%.go$", "%1_test.go")
    vim.cmd('vsplit ' .. test_file)
end

local handlers = {
    ['go'] = go_handler,
}

function M.open_test_file()
    -- get the file path for the current buffer
    local buf = vim.api.nvim_buf_get_name(
        vim.api.nvim_get_current_buf()
    )

    if buf == "" then
        vim.print("No active buffer")
        return
    end

    local ext = buf:match "[^.]+$"
    local h = handlers[ext]

    if h then return h(buf) end

    vim.print('Extension ' .. ext .. ' not yet supported')
end

return M
