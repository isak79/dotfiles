vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set('n', '<C-p><C-p>', function()
	local filename = vim.fn.bufname('%')
	os.execute("tmux split-window 'ghci " .. filename .. "; read'")
end, { silent = true, buffer = true })


vim.keymap.set('n', '<C-p><C-o>', function()
	os.execute("tmux split-window 'ghci *; read'")
end, { silent = true, buffer = true })
