vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<C-Up>", ":resize +2<cr>")
vim.keymap.set("n", "<C-Down>", ":resize -2<cr>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")

vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv")

vim.keymap.set({"n", "x", "v"}, "<leader>h", ":noh<cr>")
