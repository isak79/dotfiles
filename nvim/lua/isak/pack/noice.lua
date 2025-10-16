local noice = require("noice")
noice.setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			cmdline = { pattern = "^:", icon = " ", lang = "vim" },
			search_down = {
				view = "cmdline",
			},
			search_up = {
				view = "cmdline",
			},
		},
		hover = {
			silent = true,
		},
	},
	routes = {
		filter = {
			any = {
				{ cond = function(_) return true end }
			},
		},
	},
})
