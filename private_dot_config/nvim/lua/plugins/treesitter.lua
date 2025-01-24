return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"http",
				"rust",
				"lua",
				"javascript",
				"typescript",
				"python",
				"html",
				"css",
				"vim",
				"vimdoc",
				"c",
				"markdown",
				"markdown_inline",
				"rust",
				"go",
				"java",
				"cpp",
				"c_sharp",
				"dockerfile",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			rainbow = {
				enable = true,
				disable = { "html" },
				extended_mode = false,
				max_file_lines = nil,
			},
		})
	end,
}
