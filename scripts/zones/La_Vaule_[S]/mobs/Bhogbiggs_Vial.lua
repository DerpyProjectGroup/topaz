-----------------------------------
-- Area: La Vaule [S]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setLocalVar('lifeTimer', os.time() + math.random(25, 35))
    mob:setLocalVar('usedPayload', 0)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setModelId(2224)
    mob:setMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET, 50)
    mob:setMobMod(xi.mobMod.SPEED_BOOST_MULT, 100)
    mob:setSpeed(35)
    -- mob:addStatusEffect(xi.effect.WEIGHT, 30, 0, 180)
end

entity.onMobFight = function(mob, target)
    if
        mob:checkDistance(target) <= 1 or
        mob:getLocalVar('lifeTimer') < os.time()
    then
        mob:useMobAbility(2371)
        mob:timer(2000, function(mobArg)
            mobArg:setHP(0)
        end)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    mob:setModelId(2224)
end

entity.onMobDeath = function(mob, player, optParams)
    local mobId = mob:getID()
    mob:timer(1500, function(mobArg)
        DespawnMob(mobId)
    end)
end

return entity
