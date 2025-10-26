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

-- this is done to avoid double key press after closing terminal
vim.api.nvim_create_autocmd({ "TermClose" }, {
	pattern = "term://*",
	desc = "skip 'Process exited...' screen after terminal closes",
	callback = function()
		vim.api.nvim_input("<CR>")
	end,
	group = autocmd_group,
})

-- maps
vim.keymap.set({ "n", "i" }, "<C-[>", function()
	-- normal escape
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)

	local window_ids = vim.api.nvim_tabpage_list_wins(0)
	if #window_ids <= 1 then
		return
	end

	for _, window_id in ipairs(window_ids) do
		local success, window_config = pcall(vim.api.nvim_win_get_config, window_id)
		if success and window_config.relative == "win" then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(window_id) })
			local buffer_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window_id))
			if #filetype == 0 or #buffer_name == 0 then
				pcall(vim.api.nvim_win_close, window_id, true)
			end
		end
	end
end, { desc = "Ctrl+[ also closes all popups" })
