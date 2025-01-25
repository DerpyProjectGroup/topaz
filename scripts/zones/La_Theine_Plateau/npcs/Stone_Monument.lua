-----------------------------------
-- Area: La Theine Plateau
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 334.133 50.623 141.163 102
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
