vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true

local palette = {
	white = "#EEFFFF",
	black = "#000000",
	red = "#FF7F87",
	green = "#7FFF87",
	yellow = "#FFDF7F",
	blue = "#7FBFFF",
	purple = "#BF7FFF",
	cyan = "#7FFFFF",
	orange = "#FFB27F",

	comment = "#7F9F9F",
	todo = "#42A5F5", -- blue 400
	hint = "#26C6DA", -- cyan 400
	info = "#66BB6A", -- green 400
	optimization = "#FFEE58", -- yellow 400
	hack = "#FFCA28", -- amber 400
	warning = "#FFA726", -- orange 400
	error = "#EF5350", -- red 400
}

local highlight = vim.api.nvim_set_hl
highlight(0, "Normal", { bg = palette.black, fg = palette.white })
highlight(0, "CursorLine", { bg = "#202020" })
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
highlight(0, "Operator", { fg = palette.white })
highlight(0, "Label", { fg = palette.orange })
highlight(0, "Exception", { fg = palette.red })
highlight(0, "PreProc", { fg = palette.yellow })
highlight(0, "Include", { fg = palette.yellow })
highlight(0, "Define", { fg = palette.yellow })
highlight(0, "Macro", { fg = palette.yellow })
highlight(0, "PreCondit", { fg = palette.yellow })
highlight(0, "Type", { fg = palette.purple })
highlight(0, "Delimiter", { fg = palette.white })
highlight(0, "Special", { fg = palette.cyan })
highlight(0, "Underlined", { fg = palette.blue, underline = true })

-- status line
highlight(0, "StatusLineNC", { bg = "#121212" })

-- LSP diagnostics
highlight(0, "DiagnosticHint", { sp = palette.hint, underline = false })
highlight(0, "DiagnosticUnderlineHint", { link = "DiagnosticHint" })
highlight(0, "DiagnosticSignHint", { fg = palette.hint })
highlight(0, "DiagnosticFloatingHint", { fg = palette.hint })
highlight(0, "DiagnosticInfo", { sp = palette.info, underline = false })
highlight(0, "DiagnosticUnderlineInfo", { link = "DiagnosticInfo" })
highlight(0, "DiagnosticSignInfo", { fg = palette.info })
highlight(0, "DiagnosticFloatingInfo", { fg = palette.info })
highlight(0, "DiagnosticWarn", { sp = palette.warning, underline = false })
highlight(0, "DiagnosticUnderlineWarn", { link = "DiagnosticWarn" })
highlight(0, "DiagnosticSignWarn", { fg = palette.warning })
highlight(0, "DiagnosticFloatingWarn", { fg = palette.warning })
highlight(0, "DiagnosticError", { sp = palette.error, undercurl = true })
highlight(0, "DiagnosticUnderlineError", { link = "DiagnosticError" })
highlight(0, "DiagnosticSignError", { fg = palette.error })
highlight(0, "DiagnosticFloatingError", { fg = palette.error })

-- telescope, treesitter & other plugin highlights
highlight(0, "TelescopePromptPrefix", { fg = palette.red, bg = palette.black })
highlight(0, "TelescopePromptNormal", { fg = palette.white, bg = palette.black })
highlight(0, "TelescopeResultsNormal", { fg = palette.white, bg = palette.black })
highlight(0, "TelescopePreviewNormal", { fg = palette.white, bg = palette.black })

-- todos
highlight(0, "TodoBgTODO", { fg = palette.black, bg = palette.todo, bold = true })
highlight(0, "TodoFgTODO", { fg = palette.todo, bold = false })
highlight(0, "TodoSignTODO", { fg = palette.todo })
highlight(0, "TodoBgINFO", { fg = palette.black, bg = palette.info, bold = true })
highlight(0, "TodoFgINFO", { fg = palette.info, bold = false })
highlight(0, "TodoSignINFO", { fg = palette.info })
highlight(0, "TodoBgPERF", { fg = palette.black, bg = palette.optimization, bold = true })
highlight(0, "TodoFgPERF", { fg = palette.optimization, bold = false })
highlight(0, "TodoSignPERF", { fg = palette.optimization })
highlight(0, "TodoBgHACK", { fg = palette.black, bg = palette.hack, bold = true })
highlight(0, "TodoFgHACK", { fg = palette.hack, bold = false })
highlight(0, "TodoSignHACK", { fg = palette.hack })
highlight(0, "TodoBgWARN", { fg = palette.black, bg = palette.warning, bold = true })
highlight(0, "TodoFgWARN", { fg = palette.warning, bold = false })
highlight(0, "TodoSignWARN", { fg = palette.warning })
highlight(0, "TodoBgFIX", { fg = palette.black, bg = palette.error, bold = true })
highlight(0, "TodoFgFIX", { fg = palette.error, bold = false })
highlight(0, "TodoSignFIX", { fg = palette.error })

-- custom fixes
-- constants
highlight(0, "Constant", { fg = palette.blue })
highlight(0, "@lsp.mod.readonly", { fg = palette.blue })
highlight(0, "@lsp.typemod.variable.readonly", { fg = palette.blue })

-- modules & namespaces
highlight(0, "@lsp.module", { fg = palette.white })
highlight(0, "@lsp.type.namespace", { fg = palette.white })

-- classes
highlight(0, "@class", { fg = palette.orange })
highlight(0, "@lsp.type.class", { fg = palette.orange })

-- markdown URLs
highlight(0, "@markup.link", { underline = false })
highlight(0, "@markup.link.label", { fg = palette.green })
highlight(0, "@markup.link.url", { fg = palette.blue })
