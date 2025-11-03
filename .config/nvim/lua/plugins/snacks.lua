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
			preset = {
				keys = {
					{
						icon = "󰅨 ",
						key = "p",
						desc = "Projects",
						action = ":lua require('plugins.custom.projects').setup()",
					},
					{ icon = "󰊢 ", key = "g", desc = "Lazy git", action = ":lua Snacks.lazygit() " },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
					{ icon = "󱄽 ", key = "t", desc = "Find Text (Grep)", action = ":Telescope live_grep" },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":Telescope oldfiles",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua vim.cmd('cd ~/dotfiles/.config/nvim') vim.cmd('edit ~/dotfiles/.config/nvim/init.lua')",
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
	 
[malick.dev]
				]],
			},
		},
	},
}
