-- telescope
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>sg", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>st", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>so", ":Telescope oldfiles<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- format code using LSP
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")
