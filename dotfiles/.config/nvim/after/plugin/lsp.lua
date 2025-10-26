local builtin = require("telescope.builtin")
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noselect",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-c>"] = cmp.mapping.abort(),
		["<C-l>"] = cmp.mapping(function(_)
			if cmp.visible() then
				cmp.confirm({ select = true })
				return
			end
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function(_)
			if luasnip.expand_or_locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{
			name = "path",
			option = {
				trailing_slash = true,
				get_cwd = function()
					return vim.fn.resolve(vim.fn.getcwd())
				end,
			},
		},
		{ name = "buffer" },
	}),
})

require("cmp_nvim_lsp").setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "workspace",
			},
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"taplo",
	"ruff",
	"basedpyright",
	"ts_ls",
	"tailwindcss",
	"yamlls",
	"html",
	"cssls",
	"jsonls",
	"eslint",
	"clangd",
})

-- diagnostic setup
vim.diagnostic.config({
	underline = {
		severity = { vim.diagnostic.severity.ERROR },
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.ERROR] = "",
		},
	},
})

-- setup keybindings
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "show code actions" })
vim.keymap.set("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, { desc = "search workspace symbols" })
vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "rename symbol" })
vim.keymap.set("n", "<leader>li", function()
	vim.lsp.buf.implementation({ reuse_win = true })
end, { desc = "jump to implementation" })
vim.keymap.set("n", "<leader>lI", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay lsp hints" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show documentation" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<NOP>", { desc = "disable Ctrl+s mapping" })
vim.keymap.set({ "n", "i" }, "<M-s>", vim.lsp.buf.signature_help, { desc = "show function signature" })
vim.keymap.set({ "n", "i" }, "<M-d>", vim.diagnostic.open_float, { desc = "show diagnostic under cursor" })
