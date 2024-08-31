local mod = get_mod("Undress")
local ItemUtils = require("scripts/utilities/items")

-- local slot_filter = {"slot_gear_head", "slot_gear_upperbody", "slot_gear_lowerbody"}

mod:command("undress", mod:localize("cmd_desc"), function(sub_cmd)
    local gm_name = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    local valid_gamemode = gm_name and (gm_name == "hub" or gm_name == "shooting_range")

    if not valid_gamemode then
        mod:notify(mod:localize("catch_error"))
        return
    end

    local unequip_slots = {}
    if sub_cmd == "all" then
        unequip_slots["slot_gear_upperbody"] = true
        unequip_slots["slot_gear_lowerbody"] = true
    elseif sub_cmd == "clothes" then
        unequip_slots["slot_gear_upperbody"] = true
    elseif sub_cmd == "pants" then
        unequip_slots["slot_gear_lowerbody"] = true
    else
        local msg = mod:localize("msg_help")
        msg = msg .. "\n" .. mod:localize("msg_help_all")
        msg = msg .. "\n" .. mod:localize("msg_help_clothes")
        msg = msg .. "\n" .. mod:localize("msg_help_pants")
        mod:echo(msg)
        return
    end

    ItemUtils.unequip_slots(unequip_slots):next(function(result)
        if result then
            mod:notify(mod:localize("success"))
        end
    end)
end)