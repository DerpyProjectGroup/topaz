-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 450.741 2.110 -290.736 119
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
