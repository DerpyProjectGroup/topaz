-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -237.096, y = -176.729, z = 66.510  },
    { x = -240.915, y = -176.729, z = 71.196  },
    { x = -244.554, y = -176.729, z = 78.238  },
    { x = -238.398, y = -176.729, z = 77.472  },
    { x = -229.395, y = -176.729, z = 78.389  },
    { x = -222.505, y = -176.729, z = 78.963  },
    { x = -211.989, y = -176.729, z = 76.162  },
    { x = -202.155, y = -176.729, z = 77.074  },
    { x = -194.782, y = -176.729, z = 85.499  },
    { x = -202.779, y = -176.729, z = 89.554  },
    { x = -212.760, y = -176.729, z = 92.678  },
    { x = -221.042, y = -176.729, z = 93.325  },
    { x = -230.205, y = -176.729, z = 94.413  },
    { x = -242.298, y = -176.729, z = 93.812  },
    { x = -248.338, y = -176.729, z = 101.971 },
    { x = -237.421, y = -176.729, z = 105.840 },
    { x = -229.191, y = -176.729, z = 105.774 },
    { x = -221.376, y = -176.729, z = 105.039 },
    { x = -214.032, y = -176.729, z = 104.421 },
    { x = -206.268, y = -176.729, z = 101.888 },
    { x = -183.494, y = -176.729, z = 107.748 },
    { x = -174.858, y = -176.729, z = 108.531 },
    { x = -170.724, y = -176.729, z = 114.058 },
    { x = -173.130, y = -176.729, z = 125.831 },
    { x = -185.503, y = -176.729, z = 125.448 },
    { x = -198.346, y = -176.729, z = 123.670 },
    { x = -211.107, y = -176.729, z = 123.475 },
    { x = -222.266, y = -176.729, z = 123.821 },
    { x = -233.443, y = -176.729, z = 123.330 },
    { x = -242.004, y = -176.729, z = 121.865 },
    { x = -251.956, y = -176.729, z = 122.926 },
    { x = -265.288, y = -176.729, z = 121.749 },
    { x = -276.880, y = -176.729, z = 120.215 },
    { x = -256.298, y = -176.729, z = 139.318 },
    { x = -246.236, y = -176.729, z = 141.755 },
    { x = -232.483, y = -176.729, z = 143.635 },
    { x = -222.317, y = -176.729, z = 143.632 },
    { x = -214.671, y = -176.729, z = 141.788 },
    { x = -205.726, y = -176.729, z = 146.453 },
    { x = -195.846, y = -176.729, z = 153.944 },
    { x = -194.149, y = -176.729, z = 166.793 },
    { x = -206.087, y = -176.729, z = 167.093 },
    { x = -219.294, y = -176.729, z = 166.444 },
    { x = -229.036, y = -176.729, z = 163.847 },
    { x = -237.583, y = -176.729, z = 163.615 },
    { x = -243.581, y = -176.729, z = 152.630 },
    { x = -213.177, y = -176.729, z = 177.619 },
    { x = -201.789, y = -176.729, z = 181.279 },
    { x = -196.297, y = -176.729, z = 167.560 },
    { x = -204.299, y = -176.740, z = 133.447 },
}

local function setupFlightMode(mob, battleTime)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(732)
    mob:setLocalVar('changeTime', battleTime)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true)

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
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
    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        mob:actionQueueEmpty()
    then
        local changeTime  = mob:getLocalVar('changeTime')
        local twohourTime = mob:getLocalVar('twohourTime')
        local battleTime  = mob:getBattleTime()
        local animation   = mob:getAnimationSub()

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar('twohourTime', twohourTime)
        end

        -- Initial grounded mode.
        if
            animation == 0 and
            battleTime - changeTime > 60
        then
            setupFlightMode(mob, battleTime)

        -- Flight mode.
        -- TODO: Verify if sleep is broken on phase change.  Previous confirmation of
        -- being able to sleep while mid-air.

        elseif
            animation == 1 and
            battleTime - changeTime > 30 and
            mob:checkDistance(target) <= 6 -- This 2 checks are a hack until we can handle skills targeting a position and not an entity.
        then
            mob:useMobAbility(1292) -- This ability also handles animation change to 2.

            mob:setLocalVar('changeTime', battleTime)

        -- Subsequent grounded mode.
        elseif animation == 2 then
            if battleTime / 15 > twohourTime then -- 2-Hour logic.
                mob:useMobAbility(695)
                mob:setLocalVar('twohourTime', battleTime / 15 + 20)

            elseif battleTime - changeTime > 60 then -- Change mode.
                setupFlightMode(mob, battleTime)
            end
        end
    end

    -- Jorm draws in from set boundaries leaving her spawn area
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() < -105 and target:getXPos() > -215 and target:getZPos() > 195,
            target:getXPos() > -250 and target:getXPos() < -212 and target:getZPos() < 55,
            target:getXPos() > -160 and target:getZPos() > 105 and target:getZPos() < 130,
        },
        position = mob:getPos(),
        wait = 3,
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
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1296 and mob:getHPP() <= 30 then
        local roarCounter = mob:getLocalVar('roarCounter')

        roarCounter = roarCounter + 1
        mob:setLocalVar('roarCounter', roarCounter)

        if roarCounter > 2 then
            mob:setLocalVar('roarCounter', 0)
        else
            mob:useMobAbility(1296)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
