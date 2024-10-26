-----------------------------------
-- Zone: Eastern_Altepa_Desert (114)
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
     -- NM Persistence
     xi.mob.nmTODPersistCache(zone, ID.mob.NANDI)
     xi.mob.nmTODPersistCache(zone, ID.mob.CACTROT_RAPIDO)
     xi.mob.nmTODPersistCache(zone, ID.mob.CENTURIO_XII_I)

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.chocobo.initZone(zone)
    xi.cactuarRegimes.initializeBooks(zone)
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
        player:setPos(260.09, 6.013, 320.454, 76)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
end

return zoneObject
