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

local function set_file(n)
	harpoon_files[n] = vim.fn.bufname('%')
end

vim.keymap.set('n', '<leader>h', function()
	set_files_auto()
end, { desc = "Harpoon set" })

vim.keymap.set('n', '<leader>H', function()
	local output = ""
	for i, v in ipairs(harpoon_files) do
		output = output .. (i .. " " .. v .. (i==4 and "" or "\n"))
	end
	vim.notify(output)
end)


-- vim.keymap.set('n', '<leader>H1', function()
-- 	set_file(1)
-- end)
-- vim.keymap.set('n', '<leader>H2', function()
-- 	set_file(2)
-- end)
-- vim.keymap.set('n', '<leader>H3', function()
-- 	set_file(3)
-- end)
-- vim.keymap.set('n', '<leader>H4', function()
-- 	set_file(4)
-- end)

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
