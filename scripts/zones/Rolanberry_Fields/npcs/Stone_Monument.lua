-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 362.479 -34.894 -398.994 110
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
