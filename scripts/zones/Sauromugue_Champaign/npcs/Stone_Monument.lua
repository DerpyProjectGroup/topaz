-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 77.544 -2.746 -184.803 120
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
