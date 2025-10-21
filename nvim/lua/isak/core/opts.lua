vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.swapfile = false
vim.o.shiftwidth = 2
vim.o.winborder = "rounded"
vim.g.mapleader = " "
vim.o.smartindent = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function()
		vim.keymap.set('n', 'q', ':q<CR>', { silent = true, buffer = true })
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufname = vim.fn.bufname('%')
		if string.find(bufname, "diffview") then
			vim.keymap.set('n', 'q', ':DiffviewClose<CR>', { silent = true, buffer = true })
		end
	end
})
