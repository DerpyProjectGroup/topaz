-----------------------------------
-- Area: Open Sea route to Mhaura
--  Mob: Gugru Orobon
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setSpeed(40) -- Reportedly has lower movement speed
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
