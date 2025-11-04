function Set_highlights()
	vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { link = "WarningMsg" })
	vim.api.nvim_set_hl(0, "BufferLineFill", { link = "StatusLineTerm" })
	vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { link = "Quote" })
	-- vim.api.nvim_set_hl(0, "BufferLineBuffer", { bg = "#ffffff" })
	-- vim.api.nvim_set_hl(0, "BufferLineSeparator", { link = "StatusLineTerm" })
	-- vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { link = "StatusLineTerm" })
	-- vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { link = "Quote" })
	-- vim.api.nvim_set_hl(0, "BufferLineFileIcon", { link = "Quote" })

	vim.api.nvim_set_hl(0, "MiniFilesBorder", { link = "NotifyDEBUGBorder" })
	vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { link = "Search" })
end

Set_highlights() -- Run once initially

vim.cmd([[autocmd ColorScheme * lua Set_highlights()]]) -- Run on colorscheme change
