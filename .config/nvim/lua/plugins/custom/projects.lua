-----------------------------------------------------------
--  HACK: Projects Opener
-----------------------------------------------------------

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local Path = require("plenary.path")
local scan = require("plenary.scandir")

local projects = {}
local last_project = nil

-- Highlight groups (optional, define in your colorscheme)
vim.cmd([[
  hi ProjectDir guifg=#569CD6
  hi ProjectFile guifg=#D4D4D4
  hi GitClean guifg=#6A9955
  hi GitDirty guifg=#F44747
  hi GitNone guifg=#808080
]])

local function expand_path(path)
	return path:gsub("^~", os.getenv("HOME") or "~")
end

local function getDirs(path)
	local dirs = {}
	local full_path = expand_path(path)
	local handle = io.popen('ls -1 "' .. full_path .. '"')
	if not handle then
		return dirs
	end
	for name in handle:lines() do
		local f = full_path .. "/" .. name
		local stat = vim.loop.fs_stat(f)
		if stat and stat.type == "directory" then
			table.insert(dirs, name)
		end
	end
	handle:close()
	return dirs
end

local function get_git_status(path)
	local git_dir = Path:new(path .. "/.git")
	if not git_dir:exists() then
		return "", "GitNone"
	end
	local handle = io.popen('git -C "' .. path .. '" status --porcelain')
	local status = handle:read("*a")
	handle:close()
	if status == "" then
		return "", "GitClean"
	else
		return "", "GitDirty"
	end
end

local function get_file_count(path)
	local handle = io.popen('ls -1 "' .. path .. '" 2>/dev/null | wc -l')
	local count = tonumber(handle:read("*a")) or 0
	handle:close()
	return count
end

-- Updated: only change directory and reveal Neo-tree
local function openProject(target)
	vim.cmd("cd " .. vim.fn.fnameescape(target))
	if vim.fn.exists(":Neotree") == 2 then
		vim.cmd("Neotree reveal")
	end
	last_project = target
end

local function make_entry(entry, base_path)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 2 }, -- project icon
			{ width = 2 }, -- git icon
			{ remaining = true }, -- project name
			{ width = 6 }, -- file count
		},
	})

	local full_path = expand_path(base_path) .. "/" .. entry
	local git_icon, git_hl = get_git_status(full_path)
	local file_count = get_file_count(full_path)

	return {
		value = entry,
		display = function()
			local items = {
				{ "󰉋", "ProjectDir" },
				{ git_icon, git_hl },
				{ entry, "ProjectDir" },
				{ tostring(file_count), "ProjectFile" },
			}
			return displayer(items)
		end,
		ordinal = entry,
		path = full_path,
	}
end

-- Recursive tree scan with highlights
local function scan_tree(path, depth, max_depth)
	depth = depth or 0
	max_depth = max_depth or 5
	if depth > max_depth then
		return {}
	end

	local lines = {}
	local ok, files = pcall(scan.scan_dir, path, { depth = 1, add_dirs = true })
	if not ok then
		return lines
	end

	table.sort(files)

	for _, f in ipairs(files) do
		local name = Path:new(f):make_relative(path)
		local stat = vim.loop.fs_stat(f)
		local prefix = string.rep("  ", depth)
		local icon, hl

		if stat.type == "directory" then
			icon = " "
			hl = "ProjectDir"
			table.insert(lines, { prefix .. icon .. name, hl })
			local sub = scan_tree(f, depth + 1, max_depth)
			vim.list_extend(lines, sub)
		else
			icon = " "
			hl = "ProjectFile"
			table.insert(lines, { prefix .. icon .. name, hl })
		end
	end

	return lines
end

local function listProjects(opts)
	opts = opts or {}
	local base_path = opts.project_path or ""
	local full_base = expand_path(base_path)

	pickers
		.new(opts, {
			prompt_title = opts.prompt_title or "Select a Project",
			results_title = opts.results_title or "󰅨 Projects",
			prompt_prefix = opts.prompt_prefix or " ",
			layout_strategy = opts.layout_strategy or "vertical",
			layout_config = opts.layout_config or { width = 0.35, height = 0.7 }, -- slim width
			finder = finders.new_table({
				results = getDirs(base_path),
				entry_maker = function(entry)
					return make_entry(entry, base_path)
				end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = require("telescope.previewers").new_buffer_previewer({
				define_preview = function(self, entry, _)
					local tree_lines = scan_tree(entry.path, 0, 5) -- 5 levels deep
					local lines = {}
					local highlights = {}

					for i, line in ipairs(tree_lines) do
						if type(line) == "table" then
							table.insert(lines, line[1])
							table.insert(highlights, { i, line[2] })
						else
							table.insert(lines, line)
						end
					end

					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
					for _, hl in ipairs(highlights) do
						vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, hl[2], hl[1] - 1, 0, -1)
					end
				end,
			}),
			attach_mappings = function(bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					if selection then
						actions.close(bufnr)
						vim.schedule(function()
							openProject(selection.path)
							print('Project "' .. selection.value .. '" selected!')
						end)
					end
				end)
				return true
			end,
		})
		:find()
end

projects.openLastProject = function()
	if last_project and vim.loop.fs_stat(last_project) then
		openProject(last_project)
		print("Reopened last project: " .. last_project)
	else
		print("No last project recorded or folder no longer exists.")
	end
end

local config = {
	project_path = "~/Projects",
	prompt_title = "Select a Project",
	results_title = "󰅨 Projects",
	prompt_prefix = " ",
	layout_strategy = "vertical",
	layout_config = { width = 0.3, height = 0.7 },
}

projects.setup = function(user_opts)
	local opts = vim.tbl_extend("force", config, user_opts or {})
	listProjects(opts)
end

return projects
