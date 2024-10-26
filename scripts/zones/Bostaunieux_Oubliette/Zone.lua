-----------------------------------
-- Zone: Bostaunieux_Oubliette (167)
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.cactuarRegimes.initializeBooks(zone)

    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.DREXERION_THE_CONDEMNED)
    xi.mob.nmTODPersistCache(zone, ID.mob.PHANDURON_THE_CONDEMNED)
    xi.mob.nmTODPersistCache(zone, ID.mob.BLOODSUCKER)

    
    -- Trapdoor triggers
    zone:registerTriggerArea(1,  -66,  -2, -136, -64,  2, -134) -- 1 17461534
    zone:registerTriggerArea(2,  -67,   0, -145,   0,  0,    0)   -- 2 17461535
    zone:registerTriggerArea(3,  -56,  -2, -142, -54,  2, -140) -- 3 17461536
    zone:registerTriggerArea(4,  -19,   1, -139,   0,  0,    0)    -- 4 17461537 
    zone:registerTriggerArea(5,   14,  -2, -140,  16,  2, -138) -- 5 17461538
    zone:registerTriggerArea(6,   22,  -2, -144,  24,  2, -142) -- 6 17461539
    zone:registerTriggerArea(7,  -22,  -2, -150, -20,  2, -148) -- 7 17461540
    zone:registerTriggerArea(8,  -22,  -2, -172, -20,  2, -170) -- 8 17461541
    zone:registerTriggerArea(9,  -20,  -2, -182, -18,  2, -180) -- 9 17461542
    zone:registerTriggerArea(10, -102, -2, -180, -99,  2, -178) -- 10 17461543
    zone:registerTriggerArea(11, -90,  -2, -182, -92,  2, -180) -- 11 17461544 *
    zone:registerTriggerArea(12, -141, -2, -220, -140, 2, -218) -- 12 17461545
    zone:registerTriggerArea(13, -140, -2, -230, -138, 2, -228) -- 13 17461546
    zone:registerTriggerArea(14, -22,  -2, -220, -20,  2, -218) -- 14 17461547
    zone:registerTriggerArea(15, -20,  -2, -230, -18,  2, -228) -- 15 17461548
    zone:registerTriggerArea(16,  18,  -2, -222,  20,  2, -220) -- 16 17461549
    zone:registerTriggerArea(17,  28,  -2, -220,  30,  2, -218) -- 17 17461550
    zone:registerTriggerArea(18,  50,  -2, -220,  52,  2, -218) -- 18 17461551
    zone:registerTriggerArea(19,  60,  -2, -222,  62,  2, -220) -- 19 17461552
    zone:registerTriggerArea(20, -20,  -2, -252, -18,  2, -250) -- 20 17461553
    zone:registerTriggerArea(21, -22,  -2, -262, -20,  2, -260) -- 21 17461554
    zone:registerTriggerArea(22, -182, -2, -260, -180, 2, -258) -- 22 17461555
    zone:registerTriggerArea(23, -173, -2, -262, -171, 2, -260) -- 23 17461556
    zone:registerTriggerArea(24, -150, -2, -260, -148, 2, -258) -- 24 17461557
    zone:registerTriggerArea(25, -140, -2, -262, -138, 2, -260) -- 25 17461558
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(99.978, -25.647, 72.867, 61)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:GetTriggerAreaID()

    if triggerAreaID <= 25 then
        local trapdoor = GetNPCByID(ID.npc.TRAPDOOR_OFFSET + triggerAreaID - 1)
        if trapdoor ~= nil then
            trapdoor:openDoor(15)
        end
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    -- Don't allow Manes or Shii to spawn outside of night
    if VanadielHour() >= 6 and VanadielHour() < 18 then
        DisallowRespawn(ID.mob.MANES, true)
        DisallowRespawn(ID.mob.SHII, true)
    else
        DisallowRespawn(ID.mob.MANES, false)
        DisallowRespawn(ID.mob.SHII, false)
    end
end

return zoneObject
