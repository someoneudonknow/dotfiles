local servers = {
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"clangd",
	"cssls",
	"dockerls",
	"ts_ls",
	"html",
	"pyright",
}
local formatters = {
	"prettier",
	"stylua",
	"isort",
	"black",
	"pylint",
	"eslint_d",
	"clang-format",
	"yamllint",
	"rustfmt",
	"golines",
	"lemminx",
	"beautysh",
	"sqlfmt",
	"postgrestools",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup(settings)

			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = servers,
			})

			require("mason-tool-installer").setup({
				ensure_installed = formatters,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local nvim_lsp = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local protocol = require("vim.lsp.protocol")

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("Format", { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason_lspconfig.setup_handlers({
				function(server)
					nvim_lsp[server].setup({
						capabilities = capabilities,
					})
				end,
				["dockerls"] = function()
					nvim_lsp["dockerls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["bash-language-server"] = function()
					nvim_lsp["bash-language-server"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["clangd"] = function()
					nvim_lsp["clangd"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					nvim_lsp["gopls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["rust_analyzer"] = function()
					nvim_lsp["rust_analyzer"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["ts_ls"] = function()
					nvim_lsp["ts_ls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["cssls"] = function()
					nvim_lsp["cssls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["html"] = function()
					nvim_lsp["html"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["jsonls"] = function()
					nvim_lsp["jsonls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["eslint"] = function()
					nvim_lsp["eslint"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["pyright"] = function()
					nvim_lsp["pyright"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
}
