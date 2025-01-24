return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
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
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
