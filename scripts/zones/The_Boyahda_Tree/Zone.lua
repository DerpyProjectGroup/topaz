-----------------------------------
-- Zone: The_Boyahda_Tree (153)
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
    xi.cactuarRegimes.initializeBooks(zone)

    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ANCIENT_GOOBBUE)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-140.008, 3.787, 202.715, 64)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
