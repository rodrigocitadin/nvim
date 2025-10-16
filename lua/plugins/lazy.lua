local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		"austinliuigi/smoke.nvim",
		config = function()
			require("smoke").setup({ disable_italics = true })
		end
	},
	{ "shaunsingh/nord.nvim" },
	{ "rose-pine/neovim" },
	{ "ramojus/mellifluous.nvim" },
	{ "bettervim/yugen.nvim" },

	--
	{ 'wakatime/vim-wakatime',   lazy = false },
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-\>]]
			})
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require("lualine").setup({ options = { theme = 'auto' } })
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("telescope").setup({
				hidden = true
			})
		end
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		config = function()
			require("nvim-tree").setup {
				view = {
					adaptive_size = true
				},
				filters = {
					enable = true,
					dotfiles = false,
					git_clean = false,
					git_ignored = false,
					no_bookmark = false,
					no_buffer = false,
					-- custom = { "node_modules", "\\.cache" },
					-- exclude = {},
				},
			}
		end,
	},
	{
		'terrortylor/nvim-comment',
		config = function()
			require("nvim_comment").setup({ create_mappings = false })
		end
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = true,
	},
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require('cmp')
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = lsp_zero.cmp_format({ details = true }),
				mapping = cmp.mapping.preset.insert({
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<C-Space>'] = cmp.mapping.complete(),
					['<Tab>'] = cmp.mapping(function(fallback)
						local col = vim.fn.col('.') - 1

						if cmp.visible() then
							cmp.select_next_item({ behavior = 'select' })
						elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
							fallback()
						else
							cmp.complete()
						end
					end, { 'i', 's' }),

					-- Go to previous item
					['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
				}),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})
		end
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			-- if you want to know more about mason.nvim
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			lsp_zero.on_attach(function(client, bufnr)
				vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_prev({ float = true }) end, opts)
				vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_next({ float = true }) end, opts)
				vim.keymap.set({ "n", "v" }, "<leader>la", function() vim.lsp.buf.code_action() end, opts)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					-- function(server_name)
					-- 	require('lspconfig')[server_name].setup({})
					-- end,

					-- this is the "custom handler" for `lua_ls`
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require('lspconfig').lua_ls.setup(lua_opts)
					end,
				}
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	}
})
