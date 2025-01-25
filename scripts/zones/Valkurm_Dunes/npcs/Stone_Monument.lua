-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -311.299 -4.420 -138.878 103
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
