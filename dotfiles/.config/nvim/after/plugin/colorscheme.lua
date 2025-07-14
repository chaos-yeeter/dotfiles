vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true

local palette = {
	bg = "#000000",
	fg = "#EEFFFF",
	comment = "#7F9F9F",
	red = "#FF7F87",
	green = "#7FFF87",
	yellow = "#FFDF7F",
	blue = "#7FBFFF",
	purple = "#BF7FFF",
	cyan = "#7FFFFF",
	orange = "#FFB27F",
}

local highlight = vim.api.nvim_set_hl
highlight(0, "Normal", { bg = palette.bg, fg = palette.fg })
highlight(0, "CursorLine", { bg = "#121212" })
highlight(0, "Comment", { fg = palette.comment, italic = true })
highlight(0, "String", { fg = palette.green })
highlight(0, "Character", { fg = palette.orange })
highlight(0, "Number", { fg = palette.yellow })
highlight(0, "Boolean", { fg = palette.yellow })
highlight(0, "Identifier", { fg = palette.blue })
highlight(0, "Function", { fg = palette.cyan })
highlight(0, "Statement", { fg = palette.red })
highlight(0, "Keyword", { fg = palette.red })
highlight(0, "Conditional", { fg = palette.red })
highlight(0, "Repeat", { fg = palette.red })
highlight(0, "Operator", { fg = palette.fg })
highlight(0, "Label", { fg = palette.orange })
highlight(0, "Exception", { fg = palette.red })
highlight(0, "PreProc", { fg = palette.yellow })
highlight(0, "Include", { fg = palette.yellow })
highlight(0, "Define", { fg = palette.yellow })
highlight(0, "Macro", { fg = palette.yellow })
highlight(0, "PreCondit", { fg = palette.yellow })
highlight(0, "Type", { fg = palette.purple })
highlight(0, "Delimiter", { fg = palette.fg })
highlight(0, "Special", { fg = palette.cyan })
highlight(0, "Underlined", { fg = palette.blue, underline = true })

-- LSP diagnostics
highlight(0, "DiagnosticError", { fg = palette.red })
highlight(0, "DiagnosticWarn", { fg = palette.yellow })
highlight(0, "DiagnosticInfo", { fg = palette.blue })
highlight(0, "DiagnosticHint", { fg = palette.cyan })

-- Telescope / Treesitter / other plugin groups
highlight(0, "TelescopePromptPrefix", { fg = palette.red })
highlight(0, "TelescopePromptNormal", { fg = palette.fg, bg = "#101010" })
highlight(0, "TelescopeResultsNormal", { fg = palette.fg, bg = palette.bg })
highlight(0, "TelescopePreviewNormal", { fg = palette.fg, bg = "#080808" })

-- custom fixes
-- constants
highlight(0, "Constant", { fg = palette.blue })
highlight(0, "@lsp.mod.readonly", { fg = palette.blue })
highlight(0, "@lsp.typemod.variable.readonly", { fg = palette.blue })

-- modules & namespaces
highlight(0, "@lsp.module", { fg = palette.fg })
highlight(0, "@lsp.type.namespace", { fg = palette.fg })

-- classes
highlight(0, "@class", { fg = palette.orange })
highlight(0, "@lsp.type.class", { fg = palette.orange })

-- Terminal colours setup
for i, c in ipairs({ "black", "red", "green", "yellow", "blue", "purple", "cyan", "white" }) do
	vim.g["terminal_color_" .. (i - 1)] = palette[c] or palette.fg
end
