-----------------------------------
-- Area: Mamook
--  Mob: Tyrannobugard (Pet of Dragonscaled Bugaal Ja)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
