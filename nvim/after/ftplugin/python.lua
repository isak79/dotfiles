vim.keymap.set('n', '<C-p><C-p>', function()
	local bufName = vim.fn.bufname('%')
	os.execute("tmux split-window 'python3 " .. bufName .. "; read'")
end, { silent = true, buffer = true })
