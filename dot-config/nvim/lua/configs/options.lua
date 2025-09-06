vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Execute .nvim.lua in project dir
vim.opt.exrc = true
vim.opt.secure = true -- Restrict to safe commands

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.showmode = false

vim.opt.cursorline = true
vim.opt.inccommand = 'split'

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.textwidth = 80
vim.opt.autoindent = false  -- use treesitter indent
vim.opt.smartindent = false -- use treesitter indent
vim.opt.breakindent = true

vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.signcolumn = 'yes'

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.completeopt = 'menu,menuone,noselect'

vim.opt.termguicolors = true

vim.api.nvim_command('set fillchars=eob:\\ ')

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
