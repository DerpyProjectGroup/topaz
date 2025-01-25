-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -499.189 12.600 373.592 117
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
