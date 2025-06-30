Utils.set("conceallevel", 0)

-- ref: https://github.com/epwalsh/obsidian.nvim/issues/286#issuecomment-1873439811
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { WIKI_DIRECTORY .. "*.md" },
	desc = "Set conceallevel for markdown files",
	callback = function()
		Utils.set_local("conceallevel", 2)
	end,
	group = vim.api.nvim_create_augroup("SetConcealLevel", { clear = true }),
})
