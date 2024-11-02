-----------------------------------
-- Area: La Vaule [S]
--   NM: Ashmaker Gotblut
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 30)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 15)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.LULLABYRES, 100)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkillPrepare = function (mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onSpellPrecast = function(mob, spell)
end

entity.onSpellCast = function(mob, target, spell)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, math.random(5, 10))
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
