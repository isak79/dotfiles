require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			search_down = {
				view = "cmdline",
			},
			search_up = {
				view = "cmdline",
			},
		},
		hover = {
			silent = true,
		}
	},
})
