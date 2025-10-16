require "blink.cmp".setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	signature = { enabled = true },
	completion = { documentation = { auto_show = false } },
	fuzzy = { implementation = "prefer_rust_with_warning" }
})
