local file_utils = require("utils.file-utils")
local table_utils = require("utils.table-utils")
local settings = require("utils.settings-manager")

local HEADER_FOLDER_PATH = vim.fn.stdpath("config") .. "/lua/customs/ascii_imgs/"
local NSFW_FOLDER_PATH = vim.fn.stdpath("config") .. "/lua/customs/ascii_imgs/nsfw_imgs"
local sfw_files = vim.fn.globpath(HEADER_FOLDER_PATH, "*.txt", false, true)
local nsfw_files = vim.fn.globpath(NSFW_FOLDER_PATH, "*.txt", false, true)
local current_img = 0

local function load_img_paths(is_nsfw)
	local paths = table_utils.shallow_copy(sfw_files)

	if is_nsfw then
		for _, v in ipairs(nsfw_files) do
			table.insert(paths, v)
		end
	end

	return paths
end

local files = load_img_paths(settings.get_setting("horny_mode"))

local M = {}

function M.reload_img_paths(is_nsfw)
	if current_img > #sfw_files and not is_nsfw then
		current_img = 1
	end

	files = load_img_paths(is_nsfw)
end

function M.get_images_map()
	local images_map = {}

	for idx, file in ipairs(files) do
		table.insert(images_map, { idx, file_utils.get_file_name_from_path(file), file })
	end

	return images_map
end

function M.load_image_by_idx(self, idx)
	if idx < 1 or idx > #files then
		return nil
	end

	current_img = idx

	local file = files[current_img]

	return self.load_image(file)
end

function M.get_current_img_idx()
	return current_img
end

function M.load_image(path)
	return file_utils.convert_to_table_from_file(path)
end

function M.load_random_safe_image(self)
	math.randomseed(os.time())

	if #files == 0 then
		return nil
	end

	current_img = math.random(#files)
	local random_file = files[current_img]
	local image = self.load_image(random_file)

	if not image then
		print("Failed to read image content from file: " .. random_file)
		return nil
	end

	return image
end

function M.cycle_load_next_image(self)
	if #files == 0 then
		return nil
	end

	if current_img >= #files then
		current_img = 0
	end

	current_img = current_img + 1

	local next_file = files[current_img]

	local image = self.load_image(next_file)
	if not image then
		print("Failed to read image content from file: " .. next_file)
		return nil
	end
	return image
end

function M.cycle_load_prev_image(self)
	if #files == 0 then
		return nil
	end

	if current_img < 0 then
		current_img = #files - 1
	end

	current_img = current_img - 1

	local prev_file = files[current_img]

	local image = self.load_image(prev_file)
	if not image then
		print("Failed to read image content from file: " .. prev_file)
		return nil
	end
	return image
end

return M
