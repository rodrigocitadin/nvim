vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabline = "%f"
vim.opt.showtabline = 2
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.background = "dark"
vim.g.maplocalleader = ","
vim.cmd("let &fcs='eob: '")
vim.cmd("set clipboard=unnamedplus")

local filetype_settings_group = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	group = filetype_settings_group,
	pattern = { "*.js*", "*.ts*", "*.ex*" },
	command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = filetype_settings_group,
	pattern = { "*.go" },
	command = "setlocal tabstop=8 softtabstop=8 shiftwidth=8",
})

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.nvim-undo"
