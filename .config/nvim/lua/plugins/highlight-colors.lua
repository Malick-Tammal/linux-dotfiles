return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		-- Ensure termguicolors is enabled if not already

		require("nvim-highlight-colors").setup({
			render = "virtual",
			virtual_symbol = "󱓻",
			virtual_symbol_position = "inline",
		})
	end,
}
