-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Tallow Candle
-- !pos 384.07 -34.30 -374.14
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
