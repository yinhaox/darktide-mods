return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Undress` encountered an error loading the Darktide Mod Framework.")

		new_mod("Undress", {
			mod_script       = "Undress/scripts/mods/Undress/Undress",
			mod_data         = "Undress/scripts/mods/Undress/Undress_data",
			mod_localization = "Undress/scripts/mods/Undress/Undress_localization",
		})
	end,
	packages = {},
}
