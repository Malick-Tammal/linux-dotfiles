return {
	"saghen/blink.cmp",
	-- version = "1.*",
	event = "InsertEnter",
	enabled = true,

	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },

			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },

			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {

			accept = { auto_brackets = { enabled = true } },
			-- documentation = { auto_show = false },

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				treesitter_highlighting = true,
				window = {
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					scrollbar = false,
				},
			},

			ghost_text = { enabled = true },

			menu = {
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = false,

				draw = {
					columns = {
						{ "kind_icon", "label", gap = 2 },
						{ "kind" },
					},

					components = {
						kind_icon = {
							text = function(ctx)
								local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
								return icon .. ctx.icon_gap
							end,
						},
						label = {
							text = function(item)
								return item.label
							end,
						},
						kind = {
							text = function(item)
								return "  " .. item.kind .. " "
							end,
						},
					},
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "lua" },
	},
	-- require("lspkind").init({
	--
	-- })
}
