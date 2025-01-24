local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local ascii_imgs = require("utils.ascii-image-utils")

local function open_default_picker(opts)
	opts = opts or {}

	local settings = require("utils.settings-manager")
	local is_nsfw = settings.get_setting("horny_mode")
	local imgs_map = ascii_imgs.get_images_map()
	local title = "Select Header Image" .. (is_nsfw and " (Watch around, HORNY MODE IS ON)" or "")

	local function change_header(new_header)
		local dashboard = require("alpha.themes.dashboard")
		local current_idx = ascii_imgs.get_current_img_idx()

		settings.update_setting("alpha_header", current_idx)

		if new_header then
			dashboard.config.layout[2] =
				{ type = "text", val = new_header, opts = { position = "center", hl = "Type" } }
			vim.cmd("AlphaRedraw")
		else
			print("No images.")
		end
	end

	pickers
		.new(opts, {
			prompt_title = title,
			finder = finders.new_table({
				results = imgs_map,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry[2],
						ordinal = entry[2],
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(opts),
			default_selection_index = ascii_imgs.get_current_img_idx(),
			previewer = previewers.new_buffer_previewer({
				title = "ASCII Image Preview",
				define_preview = function(self, entry)
					local image = ascii_imgs.load_image(entry.value[3])
					assert(image ~= nil and type(image) == "table", "Failed to load image")
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, image)
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local image = ascii_imgs:load_image_by_idx(selection.value[1])

					change_header(image)
				end)
				return true
			end,
		})
		:find()
end

local function open_header_picker()
	open_default_picker({
		layout_strategy = "vertical",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			width = 0.8,
			height = 0.9,
			preview_height = 0.7,
		},
	})
end

vim.api.nvim_create_user_command("SelectHeaderImage", function()
	open_header_picker()
end, { desc = "Open Header Image Picker" })
