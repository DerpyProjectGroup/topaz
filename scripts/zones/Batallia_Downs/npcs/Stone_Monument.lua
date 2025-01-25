-----------------------------------
-- Area: Batallia Downs
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 185.669 9.049 -614.025 105
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

return entity
