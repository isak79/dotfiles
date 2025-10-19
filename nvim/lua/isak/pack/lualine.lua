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
					local bufname_list = vim.split(vim.fn.bufname('%'), '/')
					return bufname_list[#bufname_list]
				end,
				cond = function ()
					return vim.bo.modified
				end,
				color = { fg = "#f5a97f" }
			},
			{
				function()
					local bufname_list = vim.split(vim.fn.bufname('%'), '/')
					return bufname_list[#bufname_list]
				end,
				cond = function ()
					return not vim.bo.modified
				end,
				color = { fg = "" }
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
