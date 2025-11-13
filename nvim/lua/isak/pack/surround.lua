require('mini.surround').setup({
	custom_surroundings = {
		B = {
			output = {
				left = '{', right = '}'
			},
		},
	},
	mappings = {
		add = 'ma',      -- Add surrounding in Normal and Visual modes
		delete = 'md',   -- Delete surrounding
		find = 'mf',     -- Find surrounding (to the right)
		find_left = 'mF', -- Find surrounding (to the left)
		highlight = 'mh', -- Highlight surrounding
		replace = 'mr',  -- Replace surrounding

		suffix_last = 'l', -- Suffix to search with "prev" method
		suffix_next = 'n', -- Suffix to search with "next" method
	},
	silent = true,
})
