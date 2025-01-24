return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		pickers = {
			find_files = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},
		},
	},
}
