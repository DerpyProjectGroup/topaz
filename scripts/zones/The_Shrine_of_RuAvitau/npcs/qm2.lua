-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawns Kirin)
-- !pos -81 32 2 178
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { 1404, 1405, 1406, 1407 }) and
        npcUtil.popFromQM(player, npc, ID.mob.KIRIN)
    then
        player:showText(npc, ID.text.KIRIN_OFFSET)
        player:confirmTrade()
    end
end

return entity
