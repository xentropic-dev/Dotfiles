vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4

vim.opt.colorcolumn = "80"
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.g.lazyvim_picker = "telescope"

-- remap
vim.api.nvim_set_keymap("n", "j", "jzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "kzz", { noremap = true, silent = true })
-- Map leader+vv to edit Neovim config directory
vim.keymap.set("n", "<leader>vv", ":e ~/.config/nvim/<CR>", { silent = true, desc = "Edit Neovim config" })

-- Map leader+vr to source the config files
vim.keymap.set(
	"n",
	"<leader>vr",
	":source ~/.config/nvim/init.lua<CR>",
	{ silent = true, desc = "Source Neovim config" }
)
-- vim.api.nvim_create_augroup('FileTypeSetup', { clear = true })

--vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
--  group = 'FileTypeSetup',
--  pattern = '*.html',
--  command = 'setlocal filetype=htmldjango',
--})
