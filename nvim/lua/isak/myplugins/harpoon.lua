local harpoon_files = {
	" ", " ", " ", " "
}


local function get_root_dir()
	local workspace_folder = vim.lsp.buf.list_workspace_folders()
	if workspace_folder and #workspace_folder > 0 then
		return workspace_folder[1]
	end
	return nil
end


local function if_in_then_delete(bufName)
	local output = 0
	for index, value in pairs(harpoon_files) do
		if output == 0 and value == " " then
			output = index
		end
		if value == bufName then
			harpoon_files[index] = " "
			return 0
		end
	end
	return output
end


vim.keymap.set('n', '<leader>h', function()
	local bufName = vim.fn.bufname('%')
	local freeSpot = if_in_then_delete(bufName)
	if not (freeSpot == 0) then
			harpoon_files[freeSpot] = bufName
	end
end, { desc = "Harpoon set" })

vim.keymap.set('n', '<leader>H', function()
	local output = ""
	for i, v in ipairs(harpoon_files) do
		output = output .. (i .. " " .. v .. (i == 4 and "" or "\n"))
	end
	vim.notify(output)
end)

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function(args)
		for index, value in pairs(harpoon_files) do
			if value == vim.fn.bufname(args.buf) then
				harpoon_files[index] = " "
			end
		end
	end
})

-- vim.api.nvim_create_autocmd("DirChanged", {
-- 	callback = function ()
-- 		os.execute("mkdir -p ~/.cache/nvim/harpoon/")
-- 		local root_dir = get_root_dir()
-- 		local checksum, _ = os.execute("md5 -s " .. root_dir)
--
-- 		local buf = vim.api.nvim_create_buf(false, true)
-- 		vim.api.nvim_buf_set_name(buf, "~/.cache/nvim/harpoon/" .. checksum)
-- 		vim.cmd('edit ' .. "~/.cache/nvim/harpoon/" .. checksum)
--
-- 		local win_height = vim.api.nvim_win_get_height(0)
-- 		local win_width = vim.api.nvim_win_get_width(0)
--
-- 		local win = vim.api.nvim_open_win(buf, true, {
-- 			relative = 'editor',
-- 			width = 
-- 		})
-- 	end
-- })

vim.keymap.set('n', '<leader>1', function()
	vim.cmd("buffer " .. harpoon_files[1])
end)

vim.keymap.set('n', '<leader>2', function()
	vim.cmd("buffer " .. harpoon_files[2])
end)

vim.keymap.set('n', '<leader>3', function()
	vim.cmd("buffer " .. harpoon_files[3])
end)

vim.keymap.set('n', '<leader>4', function()
	vim.cmd("buffer " .. harpoon_files[4])
end)


return harpoon_files
