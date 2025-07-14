return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>ld",
			":Trouble lsp_definitions toggle focus=true<cr>",
			desc = "LSP definitions",
		},
		{
			"<leader>lr",
			":Trouble lsp_references toggle focus=true<cr>",
			desc = "LSP references",
		},
		{
			"<leader>lt",
			":Trouble lsp_type_definitions toggle focus=true<cr>",
			desc = "LSP type definitions",
		},
		{
			"<leader>ls",
			":Trouble symbols toggle focus=true<cr>",
			desc = "Buffer symbols",
		},
		{
			"<leader>gd",
			":Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer diagnostics",
		},
		{
			"<leader>gD",
			":Trouble diagnostics toggle focus=true<cr>",
			desc = "Global diagnostics",
		},
		{
			"<leader>gq",
			":Trouble qflist toggle focus=true<cr>",
			desc = "Quickfix list",
		},
	},
}
