vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.tabstop = 4

vim.opt.colorcolumn = '80'
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.g.lazyvim_picker = "telescope"

-- vim.api.nvim_create_augroup('FileTypeSetup', { clear = true })

--vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
--  group = 'FileTypeSetup',
--  pattern = '*.html',
--  command = 'setlocal filetype=htmldjango',
--})
