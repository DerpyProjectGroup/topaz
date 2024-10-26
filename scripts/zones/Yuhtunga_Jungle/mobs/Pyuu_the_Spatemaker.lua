-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Pyuu the Spatemaker
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SLEEPRES, 20)
    mob:setMod(xi.mod.BINDRES, 20)
    mob:setMod(xi.mod.GRAVITYRES, 20)
    mob:setMod(xi.mod.SILENCERES, 100)
end

entity.onMobSpawn = function(mob)
    -- Uses Jumping Thrust following a cast of Waterga III
    mob:addListener('MAGIC_STATE_EXIT', 'PYUU_MAGIC_EXIT', function(mobArg, spell)
        if spell:getID() == 201 then
            mob:useMobAbility(770)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 364)
    -- xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(5400, 7200)) -- 1.5 to 2 hours
end

return entity
