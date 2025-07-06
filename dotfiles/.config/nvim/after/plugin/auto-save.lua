-- auto save when focus is lost
vim.api.nvim_create_autocmd({ "FocusLost" }, {
	pattern = "*",
	command = "wa!",
})
