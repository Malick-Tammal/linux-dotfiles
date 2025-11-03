return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "lua",
			"python",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"toml",
			"json",
			"gitignore",
			"yaml",
			"markdown",
			"markdown_inline",
			"bash",
			"tsx",
			"css",
			"scss",
			"html",
			"regex",

			sync_install = false,

			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true, disable = { "ruby" } },
		})

		vim.filetype.add({
			pattern = { ["config"] = "config" },
		})
	end,
}
