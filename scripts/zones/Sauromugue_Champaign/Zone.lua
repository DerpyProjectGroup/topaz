-----------------------------------
-- Zone: Sauromugue_Champaign (120)
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
require('scripts/quests/i_can_hear_a_rainbow')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ROC)
    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2
    xi.voidwalker.zoneOnInit(zone)
    xi.cactuarRegimes.initializeBooks(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-571, 1, 339, 7)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function(zone)
    for i = ID.npc.QM2, ID.npc.QM2 + 5 do
        GetNPCByID(i):resetLocalVars()
    end

    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
