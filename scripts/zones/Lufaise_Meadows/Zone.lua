-----------------------------------
-- Zone: Lufaise_Meadows (24)
require('scripts/globals/exp_controller')
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable('realPadfoot', math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        local respawnP = GetServerVariable('\\[SPAWN\\]'..v)
        if os.time() > respawnP then
            SpawnMob(v)
        else
            GetMobByID(v):setRespawnTime(respawnP - os.time())
        end
    end

    GetMobByID(ID.mob.YALUN_EKE):setLocalVar('chooseYalun', math.random(1, 2))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    GetMobByID(ID.mob.FLOCKBOCK):setRespawnTime(math.random(3600, 7200))

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    xi.exp_controller.onInitialize(zone)
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
        player:setPos(458, 6, -4, 82)
    end
end
zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local cooldown = GetMobByID(ID.mob.SENGANN):getLocalVar('cooldown')
    -- Don't allow Sengann to spawn outside of night
    if VanadielHour() >= 4 and VanadielHour() < 20 then
        DisallowRespawn(ID.mob.SENGANN, true)
    elseif os.time() > cooldown then
        DisallowRespawn(ID.mob.SENGANN, false)
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    if
        os.time() > GetMobByID(ID.mob.YALUN_EKE):getLocalVar('yalunRespawn') and
        weather == xi.weather.FOG
    then
        local chooseYalun = GetMobByID(ID.mob.YALUN_EKE):getLocalVar('chooseYalun')
        local count = 1
        for k, v in pairs(ID.mob.YALUN_EKE_PH) do
            if count == chooseYalun then
                DisallowRespawn(k, true)
                DisallowRespawn(v, false)
                local pos = GetMobByID(k):getSpawnPos()
                DespawnMob(k) -- Ensure PH is not up
                GetMobByID(v):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(v) -- Spawn Yal-Un Eke
            else
                count = count + 1
            end
        end
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
