-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Baya Hiramayuh
-- !pos -12.08 2 -143.37 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
