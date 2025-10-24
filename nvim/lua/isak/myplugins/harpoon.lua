local harpoon_files = {
	" ", " ", " ", " "
}

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
