local function filename()
	local bufname_list = vim.split(vim.fn.bufname('%'), '/')
	return bufname_list[#bufname_list]
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = require("isak.pack.lualine_theme"),
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = {
			{
				function()
					return filename()
				end,
				cond = function()
					return vim.bo.modified
				end,
				color = { fg = "#f5a97f" }
			},
			{
				function()
					return filename()
				end,
				cond = function()
					return not vim.bo.modified
				end,
				color = { fg = "" }
			},
			{
				"1",
				color = { fg = "#f5a97f" },
				cond = function()
					return vim.fn.bufname('%') == require("isak.myplugins.harpoon")[1]
				end
			},
			{
				function()
					return ((require("isak.myplugins.harpoon")[1] ~= "") and "1" or "_")
				end,
				cond = function()
					return vim.fn.bufname('%') ~= require("isak.myplugins.harpoon")[1]
				end
			},
			{
				"2",
				color = { fg = "#f5a97f" },
				cond = function()
					return vim.fn.bufname('%') == require("isak.myplugins.harpoon")[2]
				end
			},
			{
				function()
					return ((require("isak.myplugins.harpoon")[2] ~= "") and "2" or "_")
				end,
				cond = function()
					return vim.fn.bufname('%') ~= require("isak.myplugins.harpoon")[2]
				end
			},
			{
				"3",
				color = { fg = "#f5a97f" },
				cond = function()
					return vim.fn.bufname('%') == require("isak.myplugins.harpoon")[3]
				end
			},
			{
				function()
					return ((require("isak.myplugins.harpoon")[3] ~= "") and "3" or "_")
				end,
				cond = function()
					return vim.fn.bufname('%') ~= require("isak.myplugins.harpoon")[3]
				end
			},
			{
				"4",
				color = { fg = "#f5a97f" },
				cond = function()
					return vim.fn.bufname('%') == require("isak.myplugins.harpoon")[4]
				end
			},
			{
				function()
					return ((require("isak.myplugins.harpoon")[4] ~= "") and "4" or "_")
				end,
				cond = function()
					return vim.fn.bufname('%') ~= require("isak.myplugins.harpoon")[4]
				end
			},
		},
		lualine_x = { 'filetype',
			{
				function()
					local output = SysCB and " " or " "
					return output
				end
			},
		},
		lualine_y = { 'lsp_status' },
	},
	extensions = {},
})
