-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Senvaleget
-- !pos -103 -26 -49 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) then
        player:sendMenu(3)
    -- Else 10918
    end
end

return entity
