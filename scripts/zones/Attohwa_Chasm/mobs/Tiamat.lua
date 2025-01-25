-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPointTable =
{
    { x = -509.612, y = -7.883,  z = -57.162 },
    { x = -511.114, y = -8.854,  z = -61.300 },
    { x = -513.979, y = -9.972,  z = -66.404 },
    { x = -516.567, y = -11.228, z = -71.118 },
    { x = -516.019, y = -12.018, z = -77.012 },
    { x = -516.266, y = -12.074, z = -82.299 },
    { x = -520.644, y = -12.033, z = -84.040 },
    { x = -525.511, y = -11.937, z = -79.784 },
    { x = -531.459, y = -12.028, z = -75.823 },
    { x = -537.182, y = -11.317, z = -79.414 },
    { x = -541.642, y = -11.083, z = -80.879 },
    { x = -546.247, y = -11.653, z = -78.959 },
    { x = -550.252, y = -11.713, z = -81.462 },
    { x = -553.738, y = -12.191, z = -83.898 },
    { x = -558.361, y = -12.178, z = -84.656 },
    { x = -562.449, y = -12.202, z = -84.500 },
    { x = -565.689, y = -12.420, z = -79.477 },
    { x = -559.911, y = -11.622, z = -67.839 },
    { x = -556.672, y = -11.939, z = -66.284 },
    { x = -551.187, y = -12.342, z = -67.364 },
    { x = -545.686, y = -11.851, z = -64.526 },
    { x = -540.688, y = -12.420, z = -61.299 },
    { x = -547.407, y = -11.494, z = -56.208 },
    { x = -545.911, y = -11.480, z = -53.302 },
    { x = -543.347, y = -11.080, z = -49.358 },
    { x = -547.281, y = -11.188, z = -46.117 },
    { x = -551.477, y = -11.580, z = -48.592 },
    { x = -555.466, y = -11.945, z = -50.986 },
    { x = -560.512, y = -12.042, z = -51.924 },
    { x = -563.436, y = -12.140, z = -48.995 },
    { x = -563.185, y = -12.002, z = -46.441 },
    { x = -563.587, y = -12.005, z = -43.905 },
    { x = -566.766, y = -12.674, z = -41.782 },
    { x = -563.552, y = -12.000, z = -39.131 },
    { x = -560.329, y = -12.000, z = -37.608 },
    { x = -553.611, y = -11.488, z = -36.440 },
    { x = -547.924, y = -9.652,  z = -32.699 },
    { x = -545.229, y = -9.139,  z = -26.835 },
    { x = -539.781, y = -6.688,  z = -24.802 },
    { x = -537.228, y = -6.278,  z = -21.546 },
    { x = -536.608, y = -4.329,  z = -16.014 },
    { x = -540.775, y = -4.301,  z = -13.786 },
    { x = -547.040, y = -4.759,  z = -13.895 },
    { x = -552.430, y = -5.316,  z = -11.979 },
    { x = -556.140, y = -4.988,  z = -8.711  },
    { x = -560.106, y = -4.234,  z = -5.819  },
    { x = -559.868, y = -4.000,  z = -1.305  },
    { x = -557.823, y = -4.000,  z = 3.232   },
    { x = -553.009, y = -3.918,  z = 4.200   },
    { x = -549.802, y = -8.944,  z = -24.848 },
}

local function setupFlightMode(mob, battleTime, mobHP)
    mob:setAnimationSub(1) -- Change to flight.
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(730)
    mob:setLocalVar('changeTime', battleTime)
    mob:setLocalVar('changeHP', mobHP / 1000)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true) -- Used for drawin

    xi.mob.updateNMSpawnPoint(mob, spawnPointTable)
    mob:setRespawnTime(math.random(86400, 259200)) -- When server restarts, reset timer
end

entity.onMobSpawn = function(mob)
    -- Reset animation so it starts grounded.
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    -- Tiamat draws in from set boundaries leaving her spawn area
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > 28,
            target:getZPos() > -31 and target:getXPos() > -515,
            target:getZPos() <= -31 and target:getXPos() > -500,
        },
        position = mob:getPos(),
        wait = 5,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    if
        mob:getHPP() <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):addEffectFlag(xi.effectFlag.DEATH)
    end

    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and
        mob:actionQueueEmpty()
    then
        local changeTime  = mob:getLocalVar('changeTime')
        local twohourTime = mob:getLocalVar('twohourTime')
        local changeHP    = mob:getLocalVar('changeHP')
        local battleTime  = mob:getBattleTime()
        local animation   = mob:getAnimationSub()
        local mobHP       = mob:getHP()

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar('twohourTime', twohourTime)
        end

        -- Initial grounded mode.
        if
            animation == 0 and
            battleTime - changeTime > 60
        then
            setupFlightMode(mob, battleTime, mobHP)

        -- Flight mode.
        -- TODO: Verify if sleep is broken on phase change.  Previous confirmation of
        -- being able to sleep while mid-air.

        elseif
            animation == 1 and
            (mobHP / 1000 <= changeHP - 10 or battleTime - changeTime > 120) and
            mob:checkDistance(target) <= 6 -- This 2 checks are a hack until we can handle skills targeting a position and not an entity.
        then
            mob:useMobAbility(1282) -- This ability also handles animation change to 2.

            mob:setLocalVar('changeTime', battleTime)
            mob:setLocalVar('changeHP', mobHP / 1000)

        -- Subsequent grounded mode.
        elseif animation == 2 then
            if battleTime / 15 > twohourTime then -- 2-Hour logic.
                mob:useMobAbility(688)
                mob:setLocalVar('twohourTime', battleTime / 15 + math.random(4, 8))

            elseif mobHP / 1000 <= changeHP - 10 or battleTime - changeTime > 120 then -- Change mode.
                setupFlightMode(mob, battleTime, mobHP)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
    xi.mob.updateNMSpawnPoint(mob, spawnPointTable)
end

return entity
