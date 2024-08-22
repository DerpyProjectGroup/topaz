-----------------------------------
-- Area: Open Sea route to Mhaura
--  Mob: Northern Piranu
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
