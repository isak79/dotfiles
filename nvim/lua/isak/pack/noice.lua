local noice = require("noice")
noice.setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
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
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true, -- enables the Noice messages UI
    view = "notify", -- default view for messages
    view_error = "notify", -- view for errors
    view_warn = "notify", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },

	routes = {
		filter = {
			any = {
				{ cond = function(_) return true end }
			},
		},
	},
})
