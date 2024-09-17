-----------------------------------
-- Custom NM System
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')


require('scripts/globals/utils')
local customUtil = require('modules/custom/lua/custom_util')
-----------------------------------
local m = Module:new('custom_nm')

m.zone = {}


-----------------------------------
-- Values
-----------------------------------

m.rate = customUtil.rate

m.spawnType =
{
    LOTTERY   = 1,
    INSTANT   = 2,
    TIMED     = 3,
    ITEM      = 4,
}

m.spawnFrom =
{
    QM        = '???'
}

m.respawn =
{
    MINUTE     =  60,    -- 1m
    VERY_SHORT =  300,   -- 5m
    SHORT      =  1800,  -- 30m
    MODERATE   =  3600,  -- 1hr
    LONG       =  7200,  -- 2hr
    VERY_LONG  =  14400, -- 4hr
    DAILY      =  86400, -- 24hr
    WINDOWS    =  75900 + math.random(0, 6) * 1800, -- 21-24hr
}

-----------------------------------
-- Helpers
-----------------------------------

local convertPos = function(pos)
    return
    {
        x   = pos[1],
        y   = pos[2],
        z   = pos[3],
        rot = pos[4] or 0,
    }
end

-----------------------------------
-- NM functions
-----------------------------------

local onMobDeath = function(mob, playerArg, optParams, tblNM)
    local spawnDelay = tblNM.spawnWait

    if tblNM.items and #tblNM.items > 0 then
        for _, v in ipairs(tblNM.items) do
            playerArg:addTreasure(v[2], mob, v[1])
        end
    end

    if tblNM.spawnType == m.spawnType.ITEM then
        local qm  = mob:getLocalVar('QM')
        local npc = GetNPCByID(qm)
        if npc then
            npc:timer(tblNM.spawnWait * 1000, function(npcArg)
                npcArg:setStatus(xi.status.NORMAL)
            end)
        end

        return

    elseif tblNM.spawnType == m.spawnType.TIMED then
        if tblNM.spawnWait == m.respawn.WINDOWS then
            spawnDelay = spawnDelay + (math.random(0, 6) * utils.minutes(10))
        end

        tblNM.mob:setRespawnTime(spawnDelay)
    else
        tblNM.mob:setRespawnTime(0)
    end

    tblNM.spawnNext  = os.time() + spawnDelay
    SetServerVariable(tblNM.varName, tblNM.spawnNext)
end

local createEntity = function(zone, tblNM)
    local dynamicNM = zone:insertDynamicEntity({
        name        = tblNM.name,
        objtype     = xi.objType.MOB,
        groupId     = tblNM.base.groupId,
        groupZoneId = tblNM.base.zoneId,
        look        = tblNM.look,
        widescan    = 0,
        -- releaseIdOnDisappear = tblNM.releaseIdOnDisappear, -- true/false

        onMobDeath  = function(mob, playerArg, optParams)
            onMobDeath(mob, playerArg, optParams, tblNM)

            if tblNM.onMobDeath then
                tblNM.onMobDeath(mob, playerArg, optParams)
            end
        end,

        -- Optional overrides
        onMobInitialize    = tblNM.onMobInitialize,

        onMobSpawn         = function(mob)
            mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
            mob:setMobMod(xi.mobMod.CHARMABLE,   0)

            if tblNM.gil then
                mob:setMobMod(xi.mobMod.GIL_MIN, tblNM.gil[1])
                mob:setMobMod(xi.mobMod.GIL_MAX, tblNM.gil[2])
            end

            if tblNM.onMobSpawn then
                tblNM.onMobSpawn(mob)
            end
        end,

        onMobRoam               = tblNM.onMobRoam,
        onMobFight              = tblNM.onMobFight,
        onMobDespawn            = tblNM.onMobDespawn,
        onMobDrawIn             = tblNM.onMobDrawIn,
        onAdditionalEffect      = tblNM.onAdditionalEffect,
        onMobWeaponSkill        = tblNM.onMobWeaponSkill,
        onCriticalHit           = tblNM.onCriticalHit,
        

        onMobWeaponSkillPrepare = function(mob, target)
            if tblNM.onMobWeaponSkillPrepare then
                local result = tblNM.onMobWeaponSkillPrepare(mob, target)

                if result > 0 then
                    return result
                end
            end

            if tblNM.skills then
                return tblNM.skills[math.random(1, #tblNM.skills)]
            end
        end,
    })

    dynamicNM:setDropID(0)

    -- Optional
    if tblNM.flags then
        dynamicNM:setMobFlags(tblNM.flags)
    end

    -- dynamicNM:setMobLevel(tblNM.level)
    -- dynamicNM:setLevel(tblNM.level)
    -- dynamicNM:setsLevel(tblNM.level)
    return dynamicNM
end

-- m.spawnNM = spawnNM

local checkPH = function(tblNM, mobPH)
    if tblNM.spawnList and #tblNM.spawnList > 0 then
        local mobID = mobPH:getID()

        -- If spawnList is used but does not contain mobID
        if not utils.contains(mobID, tblNM.spawnList) then
            return false
        end
    end

    -- Either spawnList is not used or PH is a match
    return true
end


-----------------------------------
-- Lottery Spawn Functions
-----------------------------------

local lotterySpawnRoll = function(tblNM, mobPH)
    local respawnPH = mobPH:getRespawnTime()

    if
        not tblNM.mob:isAlive() and
        not tblNM.spawning and
        os.time() > tblNM.spawnNext and
        math.random(m.rate.GUARANTEED) < tblNM.spawnRate
    then
        -- Prevent multiple PHs from being delayed
        tblNM.spawning = true

        -- Skip one placeholder respawn duration
        mobPH:setRespawnTime(respawnPH * 2)

        mobPH:timer(respawnPH, function(mobArg)
            --  Make sure the NM didn't spawn between roll and now
            if not tblNM.mob:isAlive() then
                local zone = mobArg:getZone()
                local pos  = mobArg:getSpawnPos()

                tblNM.mob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
                tblNM.mob:spawn()
            end

            tblNM.spawning = false
        end)
    end
end

local lotterySpawn = function(zone, zoneId, tblNM, instant)
    local zoneName = zone:getName()
    local mobName  = tblNM.spawnFrom

    customUtil.duplicateOverride(xi.zones[zoneName].mobs[mobName], 'onMobDespawn', function(mob)
        super(mob)

        if checkPH(tblNM, mob) then
            lotterySpawnRoll(tblNM, mob)
        end
    end)
end

-----------------------------------
-- Instant Spawn Functions
-----------------------------------

local instantSpawnRoll = function(tblNM, mobPH, player)
    if
        not tblNM.mob:isAlive() and
        os.time() > tblNM.spawnNext and
        math.random(m.rate.GUARANTEED) < tblNM.spawnRate
    then
        local zone  = mobPH:getZone()
        local pos   = mobPH:getSpawnPos()

        tblNM.mob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
        tblNM.mob:spawn()
        tblNM.mob:updateClaim(player)
    end
end

local instantSpawn = function(zone, zoneId, tblNM)
    local zoneName = zone:getName()
    local mobName  = tblNM.spawnFrom

    customUtil.duplicateOverride(xi.zones[zoneName].mobs[mobName], 'onMobDeath', function(mob, player, optParams)
        super(mob, player, optParams)

        if checkPH(tblNM, mob) then
            instantSpawnRoll(tblNM, mob, player)
        end
    end)
end

-----------------------------------
-- Item Spawn Functions
-----------------------------------

local itemSpawnHandler = function(zone, player, npc, tblNM)
    local pos =
    {
        x   = tblNM.spawnArea[1],
        y   = tblNM.spawnArea[2],
        z   = tblNM.spawnArea[3],
        rot = tblNM.spawnArea[4] or 0,
    }

    tblNM.mob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
    tblNM.mob:spawn()

    tblNM.mob:updateClaim(player)
    tblNM.mob:setLocalVar('QM', npc:getID())
    tblNM.mob:lookAt(player:getPos())

    npc:setStatus(xi.status.INVISIBLE)
    player:tradeComplete()
end

local itemSpawn = function(zone, zoneId, tblNM)
    if tblNM.npc ~= nil then
        return
    end

    tblNM.npc = zone:insertDynamicEntity({
        name        = tblNM.spawnFrom,
        objtype     = xi.objType.NPC,
        look        = tblNM.spawnLook,
        x           = tblNM.spawnArea[1],
        y           = tblNM.spawnArea[2],
        z           = tblNM.spawnArea[3],
        rotation    = 0,
        widescan    = 0,

        onTrigger   = function(player, npc)
            customUtil.dialogTable(player, tblNM.spawnText)
        end,

        onTrade     = function(player, npc, trade)
            if
                not tblNM.mob:isAlive() and
                npcUtil.tradeHasExactly(trade, tblNM.spawnItem)
            then
                itemSpawnHandler(zone, player, npc, tblNM)
            else
                player:printToPlayer('Nothing happens.', xi.msg.channel.NS_SAY)
            end
        end,
    })
end

-----------------------------------
-- Timed Spawn Functions
-----------------------------------

local getSpawnSite = function(tblNM)
    local selectedPos  = tblNM.spawnSite[1]

    if #tblNM.spawnSite > 1 then
        selectedPos = tblNM.spawnSite[math.random(1, #tblNM.spawnSite)]
    end

    return convertPos(selectedPos)
end

local timedSpawn = function(zone, zoneId, tblNM)
    if tblNM.mob:isAlive() then
        return
    end

    if os.time() > tblNM.spawnNext then
        local selectedPos = getSpawnSite(tblNM)
        tblNM.mob:setSpawn(selectedPos.x, selectedPos.y, selectedPos.z, selectedPos.rot)
        tblNM.mob:spawn()
    else
        tblNM.mob:timer((tblNM.spawnNext - os.time()) * 1000, function(mobArg)
            local selectedPos = getSpawnSite(tblNM)
            tblNM.mob:setSpawn(selectedPos.x, selectedPos.y, selectedPos.z, selectedPos.rot)
            tblNM.mob:spawn()
        end)
    end
end

-----------------------------------
-- Setup Functions
-----------------------------------

local loadTable = function(zone, tblNM)
    tblNM.varName = '\\[CUSTOM_NM\\]' .. string.gsub(tblNM.name, '%s+', '_')

    -- Respawn time persistence
    if tblNM.spawnNext == nil then
        tblNM.spawnNext = GetServerVariable(tblNM.varName) or 0
    end

-- Create entity if non-existent
    if tblNM.mob == nil then
        tblNM.mob = createEntity(zone, tblNM)
    end
    if not tblNM.mob then
        print(string.format('[CUSTOM_NM] Entity improperly initialized for: %s', tblNM.name))
        return false
    end

    return true
end

local funcTable =
{
    [m.spawnType.LOTTERY] = lotterySpawn,
    [m.spawnType.INSTANT] = instantSpawn,
    [m.spawnType.ITEM]    = itemSpawn,
    [m.spawnType.TIMED]   = timedSpawn,
}

m.initZone = function(zone)
    local zoneId   = zone:getID()

    for _, mob in ipairs(m.zone[zoneId]) do
        if funcTable[mob.spawnType] and loadTable(zone, mob) then
            funcTable[mob.spawnType](zone, zoneId, mob)
        end
    end
end

return m
