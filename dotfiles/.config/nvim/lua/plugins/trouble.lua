return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>ld",
			"<cmd>Trouble lsp_definitions toggle focus=true<cr>",
			desc = "LSP definitions",
		},
		{
			"<leader>lr",
			"<cmd>Trouble lsp_references toggle focus=true<cr>",
			desc = "LSP references",
		},
		{
			"<leader>lt",
			"<cmd>Trouble lsp_type_definitions toggle focus=true<cr>",
			desc = "LSP type definitions",
		},
		{
			"<leader>ls",
			"<cmd>Trouble symbols toggle focus=true<cr>",
			desc = "Buffer sumbols",
		},
		{
			"<leader>gd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer diagnostics",
		},
		{
			"<leader>gD",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Global diagnostics",
		},
		{
			"<leader>gq",
			"<cmd>Trouble qflist toggle focus=true<cr>",
			desc = "Quickfix list",
		},
	},
}
