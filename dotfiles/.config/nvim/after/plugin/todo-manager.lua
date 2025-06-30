local todo_comments = require("todo-comments")

todo_comments.setup({})

Utils.map("n", "]t", require("todo-comments").jump_next, { desc = "Next todo comment" })
Utils.map("n", "[t", require("todo-comments").jump_prev, { desc = "Previous todo comment" })
Utils.map("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Search TODOs in the project" })
