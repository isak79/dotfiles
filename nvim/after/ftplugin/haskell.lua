vim.api.nvim_command("TSBufEnable highlight")

vim.keymap.set('n', '<leader>Pp', function()
	local filename = vim.fn.bufname('%')
	os.execute("tmux split-window 'ghci " .. filename .. "; read'")
end, { silent = true, buffer = true })


vim.keymap.set('n', '<leader>PP', function()
	os.execute("tmux split-window 'ghci *; read'")
end, { silent = true, buffer = true })
