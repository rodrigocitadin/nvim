vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.background = "dark"
vim.g.maplocalleader = ","
vim.cmd("let &fcs='eob: '")
vim.cmd("set clipboard=unnamedplus")

vim.autocommands = {
  {
    "BufEnter",
    {
      pattern = { "*.h", "*.c", "*.cs", "*.php", "*.py", "*.prisma", "*.fs", "*.sql" },
      command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4",
    }
  },
  {
    "BufEnter",
    {
      pattern = { "*.go" },
      command = "setlocal tabstop=8 softtabstop=8 shiftwidth=8",
    }
  }
}
