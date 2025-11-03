-----------------------------------------------------------
--  HACK: Theme Switcher
-----------------------------------------------------------

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local themify = require("themify.api")

local function themes()
	local colorschemes = {}

	local colorsId = themify.Manager.colorschemes
	local colorName

	for k, v in pairs(colorsId) do
		colorName = themify.Manager.get(v).themes[1]

		table.insert(colorschemes, k, { colorName, v })
	end

	return colorschemes
end

local example = function(opts)
	opts = opts or {}

	local function next_color(bufnr)
		actions.move_selection_next(bufnr)
		local selected = action_state.get_selected_entry()
		themify.set_current(selected.value[2], selected.value[1])
	end

	local function prev_color(bufnr)
		actions.move_selection_previous(bufnr)
		local selected = action_state.get_selected_entry()
		themify.set_current(selected.value[2], selected.value[1])
	end

	pickers
		.new(opts, {
			finder = finders.new_table({
				results = themes(),
				entry_maker = function(entry)
					return {
						value = entry,
						display = "󱥚 " .. entry[1],
						ordinal = entry[1],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(bufnr, map)
				actions.select_default:replace(function()
					actions.close(bufnr)
					local selection = action_state.get_selected_entry()
					print(" 󱥚 " .. '"' .. selection.value[1] .. '"' .. " Selected")
					themify.set_current(selection.value[2], selection.value[1])
				end)

				map("i", "<C-j>", next_color)
				map("i", "<C-k>", prev_color)
				map("i", "<C-n>", next_color)
				map("i", "<C-p>", prev_color)

				return true
			end,
		})
		:find()
end

local theme_switcher = {}
local config = {
	prompt_title = "Theme name",
	results_title = " Themes",
	prompt_prefix = " ",
	layout_strategy = "vertical",
	layout_config = { width = 0.3, height = 0.5 },
}

theme_switcher.setup = function()
	example(config)
end

return theme_switcher
