-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -102.355 7.981 253.706 108
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
