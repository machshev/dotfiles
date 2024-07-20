vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set(
    'n',
    '<C-f>',
    '<cmd>silent !tmux new tmux-sessionizer<CR>',
    { silent = true }
)
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { silent = true })

-- Moves selection up and down
vim.keymap.set(
    'v',
    'J',
    ":m '>+1<CR>gv=gv",
    { desc = 'Move selection one line down' }
)
vim.keymap.set(
    'v',
    'K',
    ":m '<-2<CR>gv=gv",
    { desc = 'Move selection one line up' }
)

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Yank to system clipboard
vim.keymap.set(
    { 'n', 'v' },
    '<leader>y',
    [["+y]],
    { desc = 'Yank selection to system clipboard' }
)
vim.keymap.set(
    'x',
    '<leader>Y',
    [["+Y]],
    { desc = 'Yank rest of line to system clipboard' }
)

-- Fix cursorline keybinding
vim.keymap.set(
    'n',
    'zv',
    '<cmd>set cursorline!<cr>',
    { desc = 'Show cursor line' }
)

-- Next occurrence, center view and show cursor line
vim.keymap.set('c', '<cr>', function()
    return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<cr>'
end, { expr = true })
vim.keymap.set(
    'n',
    'n',
    'nzz<cmd>set cursorline<cr>',
    { desc = 'Next occurrence and center view' }
)
vim.keymap.set(
    'n',
    'N',
    'Nzz<cmd>set cursorline<cr>',
    { desc = 'Next occurrence and center view' }
)

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- What is this doing?
-- vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Path Explorer
vim.keymap.set(
    'n',
    '<leader>pc',
    vim.cmd.Ex,
    { desc = '[P]ath Explorer [C]urrent' }
)
vim.keymap.set(
    'n',
    '<leader>pn',
    '<cmd>Ex ~/.config/nvim/lua/<CR>',
    { desc = '[P]ath Explorer [N]vim Config' }
)

-- Buffer ommands
vim.keymap.set(
    'n',
    '<leader>bD',
    '<cmd>bdelete<cr>',
    { desc = '[B]uffer [D]elete' }
)
vim.keymap.set('n', '<leader>bs', function()
    vim.cmd('w | so')
end, { desc = '[B]uffer [S]ource' })
vim.keymap.set(
    'n',
    '<leader>bx',
    '<cmd>!chmod +x %<CR>',
    { silent = true, desc = '[B]uffer E[X]ecutable' }
)

-- Admin
vim.keymap.set(
    'n',
    '<leader>nl',
    '<cmd>Lazy<cr>',
    { desc = '[N]eovim [L]azy UI' }
)

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Toggle wrap
local toggle_wrap = function()
    vim.cmd('set wrap!')
    vim.cmd('set nolist!')
    vim.cmd('set linebreak!')
end
vim.keymap.set('n', '<leader>uw', toggle_wrap, { desc = 'Toggle wrap' })

-- Remap for dealing with word wrap
vim.keymap.set(
    'n',
    'k',
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
)
vim.keymap.set(
    'n',
    'j',
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
)

-- Diagnostic keymaps
vim.keymap.set(
    'n',
    '[d',
    vim.diagnostic.goto_prev,
    { desc = 'Go to previous diagnostic message' }
)
vim.keymap.set(
    'n',
    ']d',
    vim.diagnostic.goto_next,
    { desc = 'Go to next diagnostic message' }
)
vim.keymap.set(
    'n',
    '<leader>e',
    vim.diagnostic.open_float,
    { desc = 'Open floating diagnostic message' }
)

-- Quicklist Keymaps
vim.keymap.set(
    'n',
    '<leader>qx',
    '<cmd>call setqflist([])<cr>',
    { desc = 'Quicklist: Clear' }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
    't',
    '<Esc><Esc>',
    '<C-\\><C-n>',
    { desc = 'Exit terminal mode' }
)
