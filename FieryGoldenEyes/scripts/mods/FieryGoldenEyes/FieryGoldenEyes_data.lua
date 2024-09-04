local mod = get_mod("FieryGoldenEyes")
local Breeds = require("scripts/settings/breed/breeds")

local breed_widgets = {}
for _, breed in pairs(Breeds) do
	local tooltip = "tags:"
	for tag, _ in pairs(breed.tags) do
		tooltip = tooltip .. " " .. tag .. ";"
	end
	breed_widgets[#breed_widgets + 1] = {
		setting_id = breed.name,
		title = Managers.localization:localize(breed.display_name),
		tooltip = tooltip,
		type = "checkbox",
		default_value = false,
	}
end

return {
	name = "FieryGoldenEyes",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = breed_widgets
	}
}
