local ascii_imgs = require("utils.ascii-image-utils")
local settings = require("utils.settings-manager")

return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		_Gopts = {
			position = "center",
			hl = "Type",
			wrap = "overflow",
		}

		local header_opts = {
			position = "center",
			hl = "Type",
		}

		local prev_idx = settings.get_setting("alpha_header")
		local header = ascii_imgs:load_image_by_idx(prev_idx) or ascii_imgs:load_random_safe_image()

		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			{ type = "text", val = header, opts = header_opts },
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
		}

		dashboard.section.buttons.val = {
			dashboard.button("sr", "󰁯  > restore session", "<cmd>SessionRestore<CR>"),
			dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "  Config", ":e $HOME/.config/nvim/init.lua<CR>"),
			dashboard.button("h", "  Change header image", "<cmd>SelectHeaderImage<CR>"),
			dashboard.button("q", "󰈆  Quit", ":qa<CR>"),
		}

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			desc = "Add Alpha dashboard footer",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val =
					{ " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
				dashboard.section.header.opts.hl = "DashboardFooter"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
