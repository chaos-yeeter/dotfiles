SEARCH_IGNORE_PATHS = { ".cache/", ".git/", "node_modules/", ".venv/" }

require("package-manager")

-- highlight current line & enable relative line numbers
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

-- enable smart case for search & stop highlighting matches
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable swap file & enable persistent undo
vim.opt.swapfile = false
vim.opt.undofile = true

-- hide mode indicator & disable mouse
vim.opt.showmode = false
vim.opt.mouse = ""

-- set tab style
vim.opt.expandtab = true

-- enable sign column & add guide after 100th column
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "101"

-- keep minimum 10 lines around cursor when scrolling
vim.opt.scrolloff = 10

-- disable conceal
vim.opt.conceallevel = 0

-- set command line height to 1
vim.opt.cmdheight = 1

-- custom status line
vim.opt.statusline = "%-f%m%r:%l:%c%=%{trim(system('git branch --show-current 2>/dev/null'))}"

-- bordered windows
vim.opt.winborder = "rounded"

-- buffer & window management
vim.keymap.set("n", "<leader>w", ":wa<CR>", { desc = "write all changed buffers" })
vim.keymap.set("n", "<leader>c", ":silent bp | sp | bn | bd!<CR>", { desc = "close current buffer" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit current window" })
vim.keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "quit neovim" })

-- split management
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set("n", "<C-w>v", ":vsplit<CR>", { desc = "create vertical split" })
vim.keymap.set("n", "<C-w>h", ":split<CR>", { desc = "create horizontal split" })

-- page scroll & search result navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "center half page down scroll" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "center half page up scroll" })
vim.keymap.set("n", "n", "nzz", { desc = "center search result when going forward" })
vim.keymap.set("n", "p", "pzz", { desc = "center search result when going backward" })

-- system clipboard integration
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })

-- comment code
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "comment current line" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "comment selection" })
vim.keymap.set("n", "<leader>?", "gc", { remap = true, desc = "comment using motions" })

-- miscellaneous
vim.keymap.set("x", "p", '"_dP', { desc = "retain text when pasting over selection" })
vim.keymap.set("n", "<leader>zz", ":tabnew %<CR><C-o>zz", { desc = "open current file in new tab" })

-- remove unwanted keymaps
vim.keymap.set({ "n", "x" }, "s", "<NOP>", { desc = "disable substitute" })
vim.keymap.set({ "n", "x" }, "S", "<NOP>", { desc = "disable substitute" })
