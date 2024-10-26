-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Decrepit Gnole
-----------------------------------
mixins = { require('scripts/mixins/families/gnole') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
