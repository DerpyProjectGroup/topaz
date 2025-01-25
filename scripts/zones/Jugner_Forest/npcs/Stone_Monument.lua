-----------------------------------
-- Area: Jugner Forest
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -65.976 -23.829 -661.362 104
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
