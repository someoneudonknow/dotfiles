local M = {}

local settings_file = vim.fn.stdpath("config") .. "/lua/customs/user-settings/setting.json"
local cached_settings = nil

M.default_settings = {
	alpha_header = 1,
	horny_mode = true,
	theme = "catppuccin",
	last_session_dir = "~",
}

function M.load_settings()
	if cached_settings then
		return cached_settings
	end
	local f = io.open(settings_file, "r")

	if f then
		local content = f:read("*a")
		f:close()
		local success, settings = pcall(vim.fn.json_decode, content)
		if success and type(settings) == "table" then
			cached_settings = settings
			return cached_settings
		end
	end

	cached_settings = M.default_settings

	return cached_settings
end

function M.save_settings()
	assert(cached_settings ~= nil, "No settings to save")
	if cached_settings then
		local f = io.open(settings_file, "w")
		if f then
			f:write(vim.fn.json_encode(cached_settings))
			f:close()
		else
			print("Failed to save settings to file:", settings_file)
		end
	end
end

function M.get_setting(key)
	local settings = M.load_settings()
	return settings[key]
end

function M.update_setting(key, value)
	local settings = M.load_settings()
	settings[key] = value
	cached_settings = settings
end

return M
