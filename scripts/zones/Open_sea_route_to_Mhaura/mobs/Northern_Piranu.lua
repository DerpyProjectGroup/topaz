-----------------------------------
-- Area: Open Sea Route to Mhaura
--   NM: Northern Piranu
-- Note: Fished up
--       Need capture for proper model ID
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity