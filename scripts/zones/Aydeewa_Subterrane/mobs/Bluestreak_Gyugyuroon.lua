-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Bluestreak Gyugyuroon
-----------------------------------
require('scripts/globals/hunts')
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -300, y = 14.6, z = -380 }, -- Intersection (West)
    { x = -302, y = 14.3, z = -352 },
    { x = -310, y = 14.3, z = -344 },
    { x = -340, y = 14.6, z = -338 },
    { x = -340, y = 14.3, z = -368 },
    { x = -350, y = 14.8, z = -400 },
    { x = -325, y = 14.5, z = -420 },
    { x = -300, y = 14.5, z = -416 },
    { x = -300, y = 14.6, z = -380 }, -- Intersection (West)
    { x = -275, y = 14.0, z = -380 },
    { x = -260, y = 10.8, z = -375 },
    { x = -243, y = 11.6, z = -380 },
    { x = -218, y = 14.1, z = -375 },
    { x = -221, y = 14.2, z = -343 },
    { x = -179, y = 11.8, z = -337 }, -- Intersection (East)
    { x = -142, y = 11.2, z = -341 },
    { x = -140, y = 7.7,  z = -307 },
    { x = -177, y = 11.7, z = -300 },
    { x = -179, y = 11.8, z = -337 }, -- Intersection (East)
    { x = -221, y = 14.2, z = -343 },
    { x = -218, y = 14.1, z = -375 },
    { x = -243, y = 11.6, z = -380 },
    { x = -260, y = 10.8, z = -375 },
    { x = -275, y = 14.0, z = -380 },
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setLocalVar('nextPoint', 1)
end

entity.onMobEngage = function(mob)
    -- Find nearest point in path
    for i = 2, #pathNodes do
        local nearest = pathNodes[mob:getLocalVar('nextPoint')]
        local next = pathNodes[i]

        if mob:checkDistance(next.x, next.y, next.z) < mob:checkDistance(nearest.x, nearest.y, nearest.z) then
            mob:setLocalVar('nextPoint', i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local mPos = mob:getPos()
    local nextPos = pathNodes[mob:getLocalVar('nextPoint')]

    -- Update to next destination for flee path. If out of range of table, reset to 1
    if mob:checkDistance(nextPos.x, nextPos.y, nextPos.z) < 1 then
        mob:setLocalVar('nextPoint', mob:getLocalVar('nextPoint') + 1)

        if mob:getLocalVar('nextPoint') > #pathNodes then
            mob:setLocalVar('nextPoint', 1)
        end

        nextPos = pathNodes[mob:getLocalVar('nextPoint')]
    end

    -- Bluestreak maintains a distance from the player
    -- Doesn't shoot arrows while running away
    if mob:checkDistance(target) > 18 then
        mob:pathTo(mPos.x, mPos.y, mPos.z)
        mob:setMobAbilityEnabled(true)
    else
        mob:pathTo(nextPos.x, nextPos.y, nextPos.z)
        mob:setMobAbilityEnabled(false)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 464)
end

return entity
