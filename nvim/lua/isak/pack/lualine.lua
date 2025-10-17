require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "mycatppuccin",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = {
			{
				'buffers',
				max_length = 40,
				symbols = {
					alternate_file = '',
				},
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
