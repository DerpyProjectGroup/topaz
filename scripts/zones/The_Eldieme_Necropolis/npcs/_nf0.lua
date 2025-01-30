-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Tallow Candle
-- !pos -346.54 -2.30 336.66
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    func.handleCandleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.handleCandleTrigger(player, npc)
end

return entity
