local M = {}

-- M.nvdash = {
-- 	load_on_startup = true, -- <--- This is the key line
-- }

M.base46 = {
	theme = "onedark",
	transparent = false,
	hl_override = {
		CursorLineNr = { fg = "green" },
	},
}

M.ui = {
	tabufline = {
		enabled = false,
		lazyload = false,
		order = { "treeOffset", "buffers", "tabs" },
		buftype_exclude = { "nofile", "terminal", "help" },
		filetype_exclude = { "minifiles", "lazy", "neo-tree", "NvimTree", "help" },
	},

	statusline = {
		theme = "minimal",
	},

	cmp = {
		lspkind_text = true,
		style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
		format_colors = {
			tailwind = true,
		},
	},
}

return M
