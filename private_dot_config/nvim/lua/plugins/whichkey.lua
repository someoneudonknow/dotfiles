return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		require("which-key").setup({
			preset = "modern",
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
				},
			},
			filter = function(mapping)
				return mapping.desc and mapping.desc ~= ""
			end,
			spec = {
				{ "<leader>a", group = "Actions" },
				{ "<leader>e", group = "Explorer" },
				{ "<leader>g", group = "Gits" },
				{ "<leader>n", group = "Jump Next" },
				{ "<leader>p", group = "Jump Prev" },
				{ "<leader>r", group = "Run" },
				{ "<leader>f", group = "Search" },
				{ "<leader>d", group = "Display" },
				{ "<leader>t", group = "Toggle" },
				{ "<leader>c", group = "Comments" },
			},
		})

		vim.api.nvim_set_hl(0, "NormalFloat", { blend = 20 })
		vim.api.nvim_set_hl(0, "FloatBorder", { blend = 20 })
		vim.api.nvim_set_hl(0, "WhichKeyNormal", { blend = 20 })
		vim.api.nvim_set_hl(0, "WhichKeyTitle", { blend = 20 })
		vim.api.nvim_set_hl(0, "FloatTitle", { blend = 20 })
	end,
}
