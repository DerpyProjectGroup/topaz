-----------------------------------
-- Exp Controller Global
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.exp_controller = xi.exp_controller or {}

xi.exp_controller.onInitialize = function(zone)
    local mobs = zone:getMobs() -- Gives mobs a zone wide EXP bonus. Used for COP Signet Zones without FoV/GoV.
    if next(mobs) ~= nil then -- Check to see if table is empty
        for _, mob in ipairs(mobs) do
            mob:addMobMod(xi.mobMod.EXP_BONUS, 0)
        end
    end
end

xi.exp_controller.onZoneIn = function(player, prevZone)
end

xi.exp_controller.onTriggerAreaEnter = function(player, triggerArea)
end

xi.exp_controller.onEventUpdate = function(player, csid, option)
end

xi.exp_controller.onEventFinish = function(player, csid, option)
end
