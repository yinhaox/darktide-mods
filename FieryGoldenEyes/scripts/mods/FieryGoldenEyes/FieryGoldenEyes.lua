local mod = get_mod("FieryGoldenEyes")
local Breeds = require("scripts/settings/breed/breeds")

local settings = {}
for breed_name, _ in pairs(Breeds) do
    settings[#settings + 1] = mod:get(breed_name)
end

local outlined_units = {}
setmetatable(outlined_units, { __mode = "k" })

local is_valid_game_mode = function()
    local game_mode_name = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    return game_mode_name and game_mode_name ~= "hub"
end

local get_player_unit = function()
    local player = Managers.player and Managers.player:local_player(1)
    return player and player:unit_is_alive() and player.player_unit
end

local update = function(player_unit)
    local has_outline_system = Managers.state.extension:has_system("outline_system")
    local has_side_system = Managers.state.extension:has_system("side_system")
    if has_outline_system and has_side_system then
        local outline_system = Managers.state.extension:system("outline_system")
        local side_system = Managers.state.extension:system("side_system")

        local side = side_system and side_system.side_by_unit[player_unit]
        local enemy_units = side and side.enemy_units_lookup or {}

        for enemy_unit, _ in pairs(enemy_units) do
            local is_outlined = outlined_units[enemy_unit]
            if not is_outlined then
                local enemy_unit_data_extension = ScriptUnit.has_extension(enemy_unit, "unit_data_system")
                local breed_name = enemy_unit_data_extension and enemy_unit_data_extension:breed_name()

                if not is_outlined and settings[breed_name] then
                    outline_system:add_outline(enemy_unit, "special_target")
                    outlined_units[enemy_unit] = true
                end
            end

        end
    end
end

mod.on_setting_changed = function(id)
    settings[id] = mod:get(id)
end

local acc_time = 0
mod.update = function(dt)
    acc_time = acc_time + dt
    if acc_time > 5 then
        acc_time = 0
        if is_valid_game_mode() then
            local player_unit = get_player_unit()
            if player_unit then
                update(player_unit)
            end
        end
    end
end
