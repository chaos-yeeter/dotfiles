return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle | UndotreeFocus<CR>")
	end,
}
