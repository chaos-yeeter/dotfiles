local luasnip = require("luasnip")
local snippet = luasnip.snippet
local insert = luasnip.insert_node
local format = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("python", {
	snippet(
		{ trig = "main", name = "main", desc = "condition to check if file is run directly" },
		format(
			[[
			if __name__ == "__main__":
				{}
			]],
			{ insert(1, "pass") }
		)
	),

	snippet(
		{ trig = "def", name = "function-definition" },
		format(
			[[
			def {}({}){}:
				{}
			]],
			{ insert(1), insert(2), insert(3, ""), insert(4, "return") }
		)
	),
})
