-----------------------------------
-- Zone: Mamook (65)
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helmType.LOGGING)
    
    xi.mob.nmTODPersistCache(zone, ID.mob.HUNDREDFACED_HAPOOL_JA)
    xi.mob.nmTODPersistCache(zone, ID.mob.DRAGONSCALED_BUGAAL_JA)
    xi.mob.nmTODPersistCache(zone, ID.mob.DARTING_KACHAAL_JA)
    xi.mob.nmTODPersistCache(zone, ID.mob.DEVOUT_RADOL_JA)
    xi.mob.nmTODPersistCache(zone, ID.mob.GULOOL_JA_JA)
    xi.mob.nmTODPersistCache(zone, ID.mob.VENOMFANG)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-117.491, -20.115, -299.997, 6)
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
