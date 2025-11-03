return {
	"petertriho/nvim-scrollbar",
	event = "VeryLazy",

	config = function()
		require("scrollbar").setup({
			handle = {
				text = " ",
				blend = 0, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
				color = nil,
				color_nr = nil, -- cterm
				highlight = "FloatTitle",
				hide_if_all_visible = false, -- Hides handle if all lines are visible
			},
			excluded_filetypes = {
				"notify",
			},
		})
	end,
}
