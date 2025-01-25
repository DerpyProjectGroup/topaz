-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Stone Monument
-- Note: Involved in quest "An Explorer's Footsteps"
-- !pos -205.593 -23.210 -119.670 115
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
