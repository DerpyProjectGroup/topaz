-----------------------------------
-- Area: Misareaux Coast
--  Mob: Boggelmann
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMP(0)
    mob:setMod(xi.mod.SLEEP_MEVA, 80)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
