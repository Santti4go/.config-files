vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")
-- My keymaps
vim.keymap.set("i", "ii", "<Esc>")
vim.keymap.set("v", "ii", "<Esc>")
-- Save file
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<C-s>", "<Esc><cmd>w<CR>")
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Search (and replace) for selection
vim.keymap.set("v", "<C-f>", 'y/<C-R>"<CR>')
vim.keymap.set("v", "<C-r>", 'y:%s/<C-R>"/')
-- Open Neotree to the left
-- vim.keymap.set("n", "<leader>b", ":Neotree toggle source=filesystem reveal position=left<CR>")
-- vim.keymap.set("n", "<leader>B", ":Neotree toggle source=filesystem reveal position=left action=show<CR>")
