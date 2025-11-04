return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	enabled = false,

	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
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
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },
			-- documentation = { auto_show = false },

			documentation = {
				auto_show = false,
				auto_show_delay_ms = 500,
				treesitter_highlighting = true,
				window = {
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpMenuBorder,",
				},
			},

			ghost_text = { enabled = true },

			menu = {
				-- border = "rounded",
				scrollbar = false,

				winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",

				-- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpMenuBorder,CursorLine:PmenuSel,Search:None",

				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},

					components = {
						kind_icon = {
							text = function(item)
								local kind = require("lspkind").symbol_map[item.kind] or ""
								return kind .. " "
							end,
							highlight = "CmpItemKind",
						},
						label = {
							text = function(item)
								return item.label
							end,
							highlight = "CmpItemAbbr",
						},
						kind = {
							text = function(item)
								return item.kind .. " "
							end,
							highlight = "CmpItemKind",
						},
					},
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
}
