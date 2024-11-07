-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
mixins =
{
    require('scripts/mixins/families/khimaira'),
}
-----------------------------------
local entity = {}

local drawInPos =
{
    { x = 838.88, y =  0.00, z = 358.86 },
    { x = 834.93, y = -0.14, z = 363.68 },
    { x = 840.13, y = -0.31, z = 366.46 },
    { x = 842.69, y =  0.00, z = 360.12 },
    { x = 846.15, y = -0.27, z = 360.25 },
    { x = 845.30, y = -0.51, z = 366.68 },
    { x = 850.33, y = -1.34, z = 365.43 },
    { x = 850.40, y = -1.45, z = 355.85 },
}


entity.onMobInitialize = function(mob)
    mob:addListener('EFFECT_LOSE', 'KHIMAIRA_EFFECT_LOSE', function(owner, effect)
        local effectType = effect:getEffectType()
        if effectType == xi.effect.STUN then
            owner:addMod(xi.mod.STUNRES, 5)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(xi.mod.STATUSRES, 50)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.STUNRES, -75)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getZPos() > 442,
        position   =
        {
            { 574.86, -20.32, 437.50, target:getRotPos() },
        }
    }

    local drawInTableEast =
    {
        condition1 = target:getXPos() > 645,
        position   =
        {
            { 640.47, -15.81, 304.56, target:getRotPos() },
            { 640.47, -15.81, 313.56, target:getRotPos() },
            { 640.47, -15.81, 320.56, target:getRotPos() },
            { 640.47, -15.81, 325.56, target:getRotPos() },
            { 640.47, -15.81, 333.56, target:getRotPos() },
        }
    }

    if
        target:getLocalVar('[Draw-In]WaitTime') < os.time()
    then
        utils.arenaDrawIn(mob, target, drawInTableNorth)
        utils.arenaDrawIn(mob, target, drawInTableEast)
    end
end

entity.onMobEngage = function(mob, target)
    if mob:getHPP() == 100 then
        mob:setMod(xi.mod.STUNRES, -75)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(48, 72) * 3600 -- 48 to 72 hours in 60min windows
    xi.mob.nmTODPersist(mob, respawn)
end

return entity
