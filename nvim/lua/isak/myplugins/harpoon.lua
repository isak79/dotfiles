local harpoon_files = {
	"", "", "", ""
}

local function set_files_auto()
	for index, value in ipairs(harpoon_files) do
		local bufName = vim.fn.bufname('%')
		if value == bufName then
			harpoon_files[index] = ""
			break
		end
		if value == "" then
			harpoon_files[index] = bufName
			break
		end
	end
end

vim.keymap.set('n', '<leader>h', function()
	set_files_auto()
end, { desc = "Harpoon set" })

vim.keymap.set('n', '<leader>H', function()
	local output = ""
	for i, v in ipairs(harpoon_files) do
		output = output .. (i .. " " .. v .. (i == 4 and "" or "\n"))
	end
	vim.notify(output)
end)

local function main_fn(nr)
	if harpoon_files[nr] == "" then
		harpoon_files[nr] = vim.fn.bufname('%')
	elseif harpoon_files[nr] == vim.fn.bufname('%') then
		harpoon_files[nr] = ""
	else
		vim.cmd("buffer " .. harpoon_files[nr])
	end
end

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function(args)
		for index,value in pairs(harpoon_files) do
			if value == vim.fn.bufname(args.buf) then
				harpoon_files[index] = ""
			end
		end
	end
})

vim.keymap.set('n', '<leader>1', function()
	main_fn(1)
end)

vim.keymap.set('n', '<leader>2', function()
	main_fn(2)
end)

vim.keymap.set('n', '<leader>3', function()
	main_fn(3)
end)

vim.keymap.set('n', '<leader>4', function()
	main_fn(4)
end)

return harpoon_files
