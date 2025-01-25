-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 320.755 -4.000 368.722 118
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
