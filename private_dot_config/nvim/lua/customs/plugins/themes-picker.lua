local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local action_state = require("telescope.actions.state")
local settings = require("utils.settings-manager")

local function open_picker_with_default(opts)
	opts = opts or {}

	local all_themes = vim.fn.getcompletion("", "color")
	local current_theme = settings.get_setting("theme") or vim.g.colors_name or "default"

	local function get_current_theme_idx()
		for index, theme in ipairs(all_themes) do
			if theme == current_theme then
				return index
			end
		end
		return 0
	end

	local function change_theme(theme)
		vim.cmd("colorscheme " .. theme)
	end

	local function next_theme(bufnr)
		actions.move_selection_next(bufnr)
		change_theme(action_state.get_selected_entry()[1])
	end

	local function prev_theme(bufnr)
		actions.move_selection_previous(bufnr)
		change_theme(action_state.get_selected_entry()[1])
	end

	pickers
		.new(opts, {
			prompt_title = "Select Themes",
			finder = finders.new_table(all_themes),
			sorter = sorters.get_generic_fuzzy_sorter(opts),
			default_selection_index = get_current_theme_idx(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selected_theme = action_state.get_selected_entry()[1]
					change_theme(selected_theme)
					settings.update_setting("theme", selected_theme)
				end)

				map("i", "<Tab>", next_theme)
				map("i", "<S-Tab>", prev_theme)
				map("n", "<Tab>", next_theme)
				map("n", "<S-Tab>", prev_theme)

				return true
			end,
		})
		:find()
end

local function open_theme_picker()
	open_picker_with_default(require("telescope.themes").get_dropdown({}))
end

vim.api.nvim_create_user_command("SelectThemes", function()
	open_theme_picker()
end, { desc = "Open Themes Picker" })
