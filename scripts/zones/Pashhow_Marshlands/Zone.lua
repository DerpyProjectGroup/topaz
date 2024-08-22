-----------------------------------
-- Zone: Pashhow_Marshlands (109)
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.BOWHO_WARMONGER)

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(547.841, 23.192, 696.323, 136)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 13
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneWeatherChange = function(weather)
    if weather == xi.weather.RAIN or weather == xi.weather.SQUALL then
        DisallowRespawn(ID.mob.TOXIC_TAMLYN, false)
        if os.time() > GetServerVariable('TamlynRespawn') then
            SpawnMob(ID.mob.TOXIC_TAMLYN)
        end
    elseif weather ~= xi.weather.RAIN or weather ~= xi.weather.SQUALL then
        DisallowRespawn(ID.mob.TOXIC_TAMLYN, true)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 13 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
