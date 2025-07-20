local autocmd_group = vim.api.nvim_create_augroup("quality_of_life", { clear = true })

-- reload on detecting external change
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	pattern = "*",
	command = "if mode() != 'c' | checktime | endif",
	group = autocmd_group,
})

-- auto save when focus is lost
vim.api.nvim_create_autocmd({ "FocusLost" }, {
	pattern = "*",
	command = "wa!",
	group = autocmd_group,
})

-- redraw status line on branch change: gitui (TabEnter), git cli (FocusGained)
vim.api.nvim_create_autocmd({ "FocusGained", "TabEnter" }, {
	pattern = "*",
	command = "redrawstatus",
	group = autocmd_group,
})
