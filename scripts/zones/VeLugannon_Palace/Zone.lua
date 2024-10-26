-----------------------------------
-- Zone: VeLugannon_Palace (177)
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ZIPACNA)

    xi.treasure.initZone(zone)
    xi.cactuarRegimes.initializeBooks(zone)
    SetServerVariable('[POP]SteamCleaner', 0) -- should 'reset' on server repop
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
        player:setPos(-100.01, -25.752, -399.468, 59)
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
