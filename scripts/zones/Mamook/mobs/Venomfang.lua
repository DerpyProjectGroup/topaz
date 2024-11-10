-----------------------------------
-- Area: Mamook
--   NM: Venomfang
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 60)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 25, power = 20, duration = math.random(20, 30) })
end

entity.onMobWeaponSkillPrepare = function (mob, target)
    return 379 -- Chomp Rush
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 459)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
