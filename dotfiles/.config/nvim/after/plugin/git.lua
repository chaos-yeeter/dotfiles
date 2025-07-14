vim.keymap.set("n", "<leader>gg", ":tabnew | terminal gitui<CR>:startinsert<CR>", { desc = "open gitui in new tab" })
vim.keymap.set("t", "gt", "<C-\\><C-n>:tabnext<CR>", { desc = "navigate tabs in terminal mode" })

local git_autocmd_group = vim.api.nvim_create_augroup("git_integration", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "term://*:gitui",
	desc = "automatically enter insert mode to interact with gitui",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
	group = git_autocmd_group,
})

vim.api.nvim_create_autocmd({ "TabEnter" }, {
	pattern = "term://*:gitui",
	desc = "automatically enter insert mode to interact with gitui",
	callback = function()
		vim.cmd("startinsert")
	end,
	group = git_autocmd_group,
})
