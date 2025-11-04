return {
	"folke/snacks.nvim",
	event = "UIEnter",
	priority = 1000,
	-- HACK: Keymaps
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen Mode",
			mode = "n",
		},

		{
			"<leader>gl",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
			mode = "n",
		},

		{
			"<leader>cd",
			function()
				Snacks.dim()
			end,
			desc = "Dim",
			mode = "n",
		},

		{
			"<leader>cD",
			function()
				Snacks.dim.disable()
			end,
			desc = "UnDim",
			mode = "n",
		},

		{
			"<leader>t",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal",
			mode = "n",
		},

		-- {
		-- 	"<leader>E",
		-- 	function()
		-- 		Snacks.explorer()
		-- 	end,
		-- 	desc = "Snacks explorer",
		-- 	mode = "n",
		-- },
	},

	-- HACK: Config

	---@type snacks.Config
	opts = {
		-- INFO: Animation
		animate = {
			fps = 240,
			easing = "linear",
			duration = {
				step = 20,
				total = 500,
			},
		},

		-- INFO: Smooth scroll
		scroll = { enabled = true },

		-- INFO: Dimming
		dim = {
			enabled = true,
		},

		-- INFO: Indent
		indent = {
			enabled = true,
			priority = 1,
			scope = {
				enabled = true,
				-- char = "┃",
				char = "│",
			},
		},

		-- INFO: Word highlight
		words = { enabled = false },

		explorer = {
			-- layout = {
			-- 	position = "right",
			-- 	box = "vertical",
			-- 	width = 40,
			-- 	{
			-- 		win = "input",
			-- 		height = 1,
			-- 		border = "rounded",
			-- 		title = "Snacks Picker",
			-- 		wo = {
			-- 			winhighlight = "FloatBorder:SnacksExplorerBorder,NormalFloat:SnacksExplorerNormal,SnacksPickerPrompt:SnacksPickerPromptTransparent",
			-- 		},
			-- 	},
			-- 	{
			-- 		win = "list",
			-- 		border = "none",
			-- 		wo = {
			-- 			winhighlight = "FloatBorder:SnacksExplorerBorder,NormalFloat:SnacksExplorerNormal",
			-- 		},
			-- 	},
			-- },
			-- hidden = true,
			-- auto_close = true,
		},

		-- INFO: Picker (Buffers / Smart file picker)
		picker = {
			enabled = true,
			sources = {
				explorer = {
					layout = {
						layout = {
							position = "right",
							box = "vertical",
							width = 40,
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "Snacks Picker",
								wo = {
									winhighlight = "FloatBorder:SnacksExplorerBorder,NormalFloat:SnacksExplorerNormal,SnacksPickerPrompt:SnacksPickerPromptTransparent,Title:SnacksPickerInputTitle",
								},
							},
							{
								win = "list",
								border = "none",
								wo = {
									winhighlight = "FloatBorder:SnacksExplorerBorder,NormalFloat:SnacksExplorerNormal",
								},
							},
						},
					},
					hidden = true,
					auto_close = true,
				},
			},
		},

		-- INFO: Bigfile saver
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5mb
		},

		notifier = {
			enabled = false,
			timeout = 1000,
			margin = { top = 1, right = 2, bottom = 0 },
		},

		-- INFO: Quick file rendering
		quickfile = { enabled = true },

		-- INFO: Terminal
		terminal = {
			enabled = true,
		},

		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true, -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},

		lazygit = {
			enabled = true,
			theme = {
				inactiveBorderColor = { fg = "StatusLineNC" },
			},
		},

		-- INFO: Dashboard (welcome screen)
		dashboard = {
			enabled = true,
			width = 30,
			pane_gap = 0,
			preset = {
				keys = {
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "Find File", hl = "@diff.delta", width = 30 },
							{ "[f]", hl = "SnacksDashboardKey" },
						},
						key = "f",
						action = ":Telescope find_files",
					},
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "New File", hl = "@diff.delta", width = 30 },
							{ "[n]", hl = "SnacksDashboardKey" },
						},
						key = "n",
						action = ":ene | startinsert",
					},
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "Recent Files", hl = "@diff.delta", width = 30 },
							{ "[r]", hl = "SnacksDashboardKey" },
						},
						key = "r",
						action = ":Telescope oldfiles",
					},
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "Explorer", hl = "@diff.delta", width = 30 },
							{ "[e]", hl = "SnacksDashboardKey" },
						},
						key = "e",
						action = ":Neotree",
					},
					{
						text = {
							{ "󰅨", hl = "@diff.delta", width = 2 },
							{ "Projects", hl = "@diff.delta", width = 30 },
							{ "[p]", hl = "SnacksDashboardKey" },
						},
						key = "p",
						action = ":lua require('plugins.custom.projects').setup()",
					},
					{
						text = {
							{ "󰊢", hl = "@diff.delta", width = 2 },
							{ "Lazy Git", hl = "@diff.delta", width = 30 },
							{ "[g]", hl = "SnacksDashboardKey" },
						},
						key = "g",
						action = ":lua Snacks.lazygit()",
					},
					{
						text = {
							{ "󰈭", hl = "@diff.delta", width = 2 },
							{ "Find Text (Grep)", hl = "@diff.delta", width = 30 },
							{ "[t]", hl = "SnacksDashboardKey" },
						},
						key = "t",
						action = ":Telescope live_grep",
					},
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "Config", hl = "@diff.delta", width = 30 },
							{ "[c]", hl = "SnacksDashboardKey" },
						},
						key = "c",
						action = ":lua vim.cmd('cd ~/dotfiles/.config/nvim') vim.cmd('edit ~/dotfiles/.config/nvim/init.lua')",
					},
					{
						text = {
							{ "󱥚", hl = "@diff.delta", width = 2 },
							{ "Themes", hl = "@diff.delta", width = 30 },
							{ "[v]", hl = "SnacksDashboardKey" },
						},
						key = "v",
						action = function()
							require("nvchad.themes").open({ style = "bordered" })
						end,
					},
					{
						text = {
							{ "", hl = "@diff.delta", width = 2 },
							{ "Quit", hl = "@diff.delta", width = 30 },
							{ "[q]", hl = "SnacksDashboardKey" },
						},
						key = "q",
						action = ":qa",
					},
				},
				header = [[
           ▄ ▄                   
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
	 
 [ malick.dev ] ]],
			},
			formats = {
				footer = { "dsf", align = "left" },
			},
			sections = {
				{ section = "header", padding = 0 },
				{ section = "keys", gap = 0.8, padding = 1 },
				{ section = "startup", padding = 5 },
			},
		},
	},
}
