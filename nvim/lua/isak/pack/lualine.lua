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
				cond = function()
					if not require("noice").api.statusline.mode.has() then
						return false
					end
					local text = require("noice").api.statusline.mode.get()
					return string.find(text, "record") ~= nil
				end,
				color = { fg = "#ff9e64" },
			}

		},
	},
})
