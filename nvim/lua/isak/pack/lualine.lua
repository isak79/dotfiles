require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "mycatppuccin",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = { 'buffers' },
		lualine_x = { 'encoding', 'fileformat', 'filetype',
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			}

		},
	},
})
