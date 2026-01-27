local function get_root_dir()
	local workspace_folder = vim.lsp.buf.list_workspace_folders()
	if workspace_folder and #workspace_folder > 0 then
		return workspace_folder[1]
	end
	return nil
end

vim.keymap.set('n', '<C-p><C-p>', function()
	local worspace_dir = get_root_dir()
	local bufName = vim.fn.bufname('%')
	os.execute("tmux split-window 'python3 " .. bufName .. "; read'")
end, { silent = true, buffer = true })
