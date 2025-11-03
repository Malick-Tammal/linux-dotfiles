return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },

	-- TODO: configure it
	-- NOTE: Options
	opts = {
		keywords = {
			INFO = { icon = " ", color = "info" },
			TIP = { icon = " ", color = "tip" },
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			HACK = { icon = " ", color = "warning" },
			PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = {} },
			TODO = { icon = " ", color = "info" },
			TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		},

		highlight = {
			multiline = false,
		},

		colors = {
			tip = { "LineNr" },
		},
	},
}
