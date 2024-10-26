-----------------------------------
-- Zone: Carpenters_Landing (2)
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
local ID = zones[xi.zone.CARPENTERS_LANDING]
require('scripts/globals/barge')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.mob.nmTODPersistCache(zone, ID.mob.TEMPEST_TIGON)

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    xi.cactuarRegimes.initializeBooks(zone)
    func.herculesTreeOnGameHour()

    -- Barge Regions (100%)
    zone:registerTriggerArea(1, -271, 38, 533, 0, 0, 0) -- Barge at north landing
    zone:registerTriggerArea(2, 233, -15, -555, 270, 15, -500) -- Barge at south landing
    zone:registerTriggerArea(3, -115, 28, 82, 0, 0, 0) -- Barge as central landing
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
        then
            if prevZone == xi.zone.PHANAUET_CHANNEL then
                cs = xi.barge.onZoneIn(player)
            else
                player:setPos(6.509, -9.163, -819.333, 239)
            end
        end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour == 7 or hour == 22 then
        func.herculesTreeOnGameHour()
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), true)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), false)
end

zoneObject.onTransportEvent = function(player, transport)
    xi.barge.onTransportEvent(player, transport)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 10 then
        player:startEvent(15) -- arrive at South Landing
    elseif csid == 11 then
        player:startEvent(17) -- arrive at North Landing
    elseif csid == 38 then
        player:startEvent(41) -- arrive at Central Landing
    elseif csid == 14 or csid == 16 or csid == 40 then
        player:setPos(0, 0, 0, 0, xi.zone.PHANAUET_CHANNEL)
    end
end

return zoneObject
