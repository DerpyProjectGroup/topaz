-----------------------------------
-- Area: Arrapago Reef
--  ZNM T1: Lil Apkallu
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}

local runningPoints = {
    {x = 509.5, y = -8.5, z = 166.2},
    {x = 504.5, y = -7.5, z = 159.0},
    {x = 494.4, y = -2.7, z = 163.1},
    {x = 506.3, y = -8.2, z = 176.8},
    {x = 491.3, y = -6.7, z = 182.9},
    {x = 482.3, y = -8.5, z = 188.8},
    {x = 478.5, y = -4.0, z = 177.5}
}
-- Todo: Apkallu hate, no hate generation during panic runs

local function runForIt(mob)
    local destination = mob:getLocalVar('RunDestination')
    mob:pathTo(runningPoints[destination].x, runningPoints[destination].y, runningPoints[destination].z, 9)

    if (mob:checkDistance(runningPoints[destination]) <= 2) then
        mob:setLocalVar('RunDestination', math.random(#runningPoints))
    end

end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setSpeed(50 - 10) -- 50 is current default.
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setAutoAttackEnabled(true)
    mob:setMod(xi.mod.SLOWRES, 100)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('TimeToRun', os.time() + math.random(60, 90)) -- Runs at timed intervals, not HPP based
end

entity.onMobFight = function(mob, target)
    local now = os.time()

    if (mob:getLocalVar('Mid100Fist') == 0 and mob:hasStatusEffect(xi.effect.HUNDRED_FISTS)) then
        mob:setLocalVar('Mid100Fist', 1)
    end
    if (mob:getLocalVar('Mid100Fist') == 1 and not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS)) then
        -- 100 fists wore off
        mob:setLocalVar('Mid100Fist', 0)
        for i = 1, math.random(1,3) do
            mob:useMobAbility(1717)
        end
    end

    if (mob:getLocalVar('QueueAction') == 1 and mob:checkDistance(target) < 5) then
        mob:setLocalVar('QueueAction', 0)
        if(mob:getHPP() <= 35) then
            mob:useMobAbility(690)
        else
            mob:useMobAbility(1717)
        end
    end

    if (mob:getLocalVar('Running') == 0) then -- not running
        if (now > mob:getLocalVar('TimeToRun')) then
            mob:useMobAbility(1713) -- Yawn then Run
            mob:setLocalVar('Running', 1)
            mob:setAutoAttackEnabled(false)
            mob:setLocalVar('RunDestination', math.random(#runningPoints))
            mob:setLocalVar('TimeToStop', now + math.random(25, 60))
        end
     else -- running
        if (now > mob:getLocalVar('TimeToStop')) then
            -- done running for now
            --mob:pathTo(target:getPos().x, target:getPos().y, target:getPos().z, 9)
            mob:setLocalVar('Running', 0)
            mob:setAutoAttackEnabled(true)
            mob:setLocalVar('TimeToRun', now + math.random(75,95))
            mob:setLocalVar('QueueAction', 1)
        else
            runForIt(mob)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity