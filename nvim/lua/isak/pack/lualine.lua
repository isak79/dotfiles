require("lualine").setup({
	options = {
		icons_enabled = true,
	 	theme = "16color",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = { 'buffers' },
	},
})
