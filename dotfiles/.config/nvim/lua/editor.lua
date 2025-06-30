-- enable relative line numbers
Utils.set("number", true)
Utils.set("relativenumber", true)

-- disable search result highlighting
Utils.set("hlsearch", false)

-- smart case while searching
Utils.set("ignorecase", true)
Utils.set("smartcase", true)

-- disable swap file
Utils.set("swapfile", false)

-- don't show current mode (already shown in status line)
Utils.set("showmode", false)

-- highligh current line
Utils.set("cursorline", true)

-- set tab to 4 spaces
Utils.set("shiftwidth", 4)
Utils.set("tabstop", 4)
Utils.set("expandtab", true)

-- disable mouse
Utils.set("mouse", "")

-- enable sign column
Utils.set("signcolumn", "yes")

-- add j/k movements that are bigger than 1 line to jumplist
Utils.map("n", "j", [[v:count ? (v:count > 1 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
Utils.map("n", "k", [[v:count ? (v:count > 1 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })

-- split below for vertical & to right for horizontal
Utils.set("splitbelow", true)
Utils.set("splitright", true)

-- add guides
Utils.set("colorcolumn", "101")
