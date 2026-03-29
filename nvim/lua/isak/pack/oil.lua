require("oil").setup({
	default_file_explorer = true,
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"permissions",
	},
	keymaps = {
		["q"] = { "actions.close", mode = "n" },
	},
})
