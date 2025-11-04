return {
	-- HACK: LSPs config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,

		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", enabled = true },
		},

		config = function()
			-- lspconfig plugin
			-- local lspconfig = require("lspconfig")

			-- cmp-nvim-lsp plugin
			-- local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Autocompletion
			-- local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Blink cmp plugin
			-- local blink = require("blink.cmp")
			-- local capabilities = blink.get_lsp_capabilities()

			-- HACK: LSPs

			-- INFO: LSPs configs

			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			-- INFO: LSPs activation
			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"emmet_ls",
				"rust_analyzer",
			})
		end,
	},

	-- HACK: Diagnostic config
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				transparent_bg = false,
				transparent_cursorline = false,
				signs = {
					diag = "󱓻",
				},
				hi = {
					mixing_color = "CursorColumn",
				},
				options = {
					use_icons_from_diagnostic = true,

					multilines = {
						enabled = true,
						always_show = false,
					},
				},
				disabled_ft = {}, -- List of filetypes to disable the plugin
			})

			-- Change the Diagnostic symbols
			vim.diagnostic.config({
				underline = false,
				virtual_text = false,
				update_in_insert = false,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			})
		end,
	},
}
