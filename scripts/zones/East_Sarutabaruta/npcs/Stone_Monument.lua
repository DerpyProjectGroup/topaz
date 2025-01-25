-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 448.045 -7.808 319.980 116
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
