-----------------------------------
-- Area: La Vaule [S]
--   NM: Coinbiter Cjaknokk
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 750)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.BLACK_MAGIC_RECAST, -100) -- Bypass the recast limiter.
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkillPrepare = function (mob, target)
    return 2264 -- Shoulder Charge
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobMagicPrepare = function(mob, target, spell)
    if not mob:hasStatusEffect(xi.effect.DREAD_SPIKES) then
        return 277
    end
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
