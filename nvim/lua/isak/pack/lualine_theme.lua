local C = {
	rosewater = "#f4dbd6",
	flamingo = "#f0c6c6",
	pink = "#f5bde6",
	mauve = "#c6a0f6",
	red = "#ed8796",
	maroon = "#ee99a0",
	peach = "#f5a97f",
	yellow = "#eed49f",
	green = "#a6da95",
	teal = "#8bd5ca",
	sky = "#91d7e3",
	sapphire = "#7dc4e4",
	blue = "#8aadf4",
	lavender = "#b7bdf8",
	text = "#cad3f5",
	subtext1 = "#b8c0e0",
	subtext0 = "#a5adcb",
	overlay2 = "#939ab7",
	overlay1 = "#8087a2",
	overlay0 = "#6e738d",
	surface2 = "#5b6078",
	surface1 = "#494d64",
	surface0 = "#363a4f",
	base = "#24273a",
	mantle = "#1e2030",
	crust = "#181926",
}

local transparent_bg = true and "NONE" or "#1E1E2D"

return {
	replace = {
		a = { bg = C.red, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.red },
	},
	inactive = {
		a = { bg = transparent_bg, fg = C.blue },
		b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
		c = { bg = transparent_bg, fg = C.overlay0 },
	},
	normal = {
		a = { bg = C.blue, fg = C.mantle, gui = "bold" },
		b = { bg = C.surface0, fg = C.blue },
		c = { bg = transparent_bg, fg = C.text },
	},
	insert = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	},
	terminal = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	},
	command = {
		a = { bg = C.peach, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.peach },
	},
	visual = {
		a = { bg = C.mauve, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.mauve },
	},
}
