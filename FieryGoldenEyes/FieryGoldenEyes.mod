return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`FieryGoldenEyes` encountered an error loading the Darktide Mod Framework.")

		new_mod("FieryGoldenEyes", {
			mod_script       = "FieryGoldenEyes/scripts/mods/FieryGoldenEyes/FieryGoldenEyes",
			mod_data         = "FieryGoldenEyes/scripts/mods/FieryGoldenEyes/FieryGoldenEyes_data",
			mod_localization = "FieryGoldenEyes/scripts/mods/FieryGoldenEyes/FieryGoldenEyes_localization",
		})
	end,
	packages = {},
}
