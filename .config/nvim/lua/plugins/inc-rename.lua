return {
	"smjonas/inc-rename.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		cmd_name = "Renamer",
	},
}
