return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>")
		vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
		vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>")
		vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
	end,
}
