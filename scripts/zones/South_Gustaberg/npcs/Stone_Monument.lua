-----------------------------------
-- Area: South Gustaberg
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 520.064 -5.881 -738.356 107
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
