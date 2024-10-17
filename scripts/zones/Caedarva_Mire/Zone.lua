-----------------------------------
-- Zone: Caedarva_Mire (79)
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.AYNU_KAYSEY)
    GetMobByID(ID.mob.AYNU_KAYSEY):setRespawnTime(math.random(900, 10800))
    -- GetMobByID(ID.mob.KHIMAIRA):setRespawnTime(math.random(12, 36) * 3600) -- 12 to 36 hours after maintenance, in 1-hour increments
    xi.mob.nmTODPersistCache(zone, ID.mob.ZIKKO)
    xi.mob.nmTODPersistCache(zone, ID.mob.KHIMAIRA)
    DisallowRespawn(ID.mob.ZIKKO, true) -- Spawn is controlled by players entering swamps

    xi.helm.initZone(zone, xi.helmType.LOGGING)

    -- Swamp trigger areas (Map 1)
    zone:registerTriggerArea(1, 305, 2.5, -380, 0, 0, 0) -- South swamp (J-8)
    zone:registerTriggerArea(2, 300, 2.5, -370, 0, 0, 0) -- South swamp (J-8)
    zone:registerTriggerArea(3, 300, 2.5, -345, 0, 0, 0) -- North swamp (J-8)
    zone:registerTriggerArea(4, 460, 2.5, -340, 0, 0, 0) -- South swamp (K-8)
    zone:registerTriggerArea(5, 462, 2.5, -303, 0, 0, 0) -- North swamp (K-8)
    zone:registerTriggerArea(6, 140, 2.5, -178, 0, 0, 0) -- Swamp (I-7)

    -- Swamp trigger areas (Map 2)
    zone:registerTriggerArea(7, -378, 2.5, -143, 0, 0, 0) -- Swamp (I-7)
    zone:registerTriggerArea(8, -421, 2.5, -184, 0, 0, 0) -- Swamp (I-7)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(339.996, 2.5, -721.286, 200)
    end

    if prevZone == xi.zone.LEUJAOAM_SANCTUM then
        player:setPos(495.450, -28.25, -478.43, 32)
    end

    if prevZone == xi.zone.PERIQIA then
        player:setPos(-252.715, -7.666, -30.64, 128)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')
    player:entityVisualPacket('1pd1')
    player:entityVisualPacket('2pc1')
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local trigID = triggerArea:GetTriggerAreaID()
    local effect = xi.effect.WEIGHT
    local power  = 50
    local msg    = zones[player:getZoneID()].text.LEG_STUCK
    local duration = math.random(25, 45)

    -- 5% chance to instead get stoneskin
    if math.random(1, 20) <= 1 then
        effect = xi.effect.STONESKIN
        power  = math.random(75, 125)
        msg    = msg + 1
        duration = math.random(60, 180)
    end

    -- Swamps
    if trigID <= 8 then
        if not player:hasStatusEffect(effect) then
            player:addStatusEffect(effect, power, 0, duration)
            player:messageSpecial(msg)
        end
    end

    -- Zikko Swamp
    -- Players can only attempt to spawn Zikko every 5 minutes
    -- Moreover, there is a 5% chance Zikko will spawn when players enter a swamp
    -- near the Dvucca Isle Staging Point
    if trigID == 7 or trigID == 8 then
        local zikko = GetMobByID(zones[player:getZoneID()].mob.ZIKKO)
        local spawn = player:getPos()

        if
            math.random(1, 20) == 1 and
            player:getLocalVar('ZikkoCooldown') < os.time() and
            zikko:getRespawnTime() < os.time()
        then
            zikko:setSpawn(spawn.x, spawn.y, spawn.z)
            DisallowRespawn(zikko:getID(), false)
            SpawnMob(zikko:getID()):updateClaim(player)
        end

        player:setLocalVar('ZikkoCooldown', os.time() + 300)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 133 then -- enter instance, warp to periqia
        player:setPos(0, 0, 0, 0, 56)
    elseif csid == 130 then
        player:setPos(0, 0, 0, 0, 69)
    end
end

return zoneObject
