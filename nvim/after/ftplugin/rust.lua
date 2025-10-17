local function get_root_dir()
	local workspace_folder = vim.lsp.buf.list_workspace_folders()
	if workspace_folder and #workspace_folder > 0 then
		return workspace_folder[1]
	end
	return nil
end

vim.keymap.set('n', '<leader>P', function ()
	local worspace_dir = get_root_dir()
	os.execute("tmux display-popup 'cd " .. worspace_dir .. " && cargo run'")
end, { silent = true, buffer = true })
