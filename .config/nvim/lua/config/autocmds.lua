--
--  HACK: Autocmds
--

-----------------------------------------------------------
--  INFO: Macros status notify
-----------------------------------------------------------

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		local msg = string.format("󰻃 Recording Macro : (Register:  %s)", vim.fn.reg_recording())
		_MACRO_RECORDING_STATUS = true
		vim.notify(msg, vim.log.levels.INFO, {
			title = "Macros",
			keep = function()
				return _MACRO_RECORDING_STATUS
			end,
		})
	end,
	group = vim.api.nvim_create_augroup("NoiceMacroNotfication", { clear = true }),
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		_MACRO_RECORDING_STATUS = false
		vim.notify(" Recorded!", vim.log.levels.INFO, {
			title = "Macros",
			timeout = 2000,
		})
	end,
	group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", { clear = true }),
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_echo({ { "File written successfully: " .. vim.fn.expand("%:p"), "Normal" } }, false, {})
-- 	end,
-- })

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = require("lualine").refresh,
})
