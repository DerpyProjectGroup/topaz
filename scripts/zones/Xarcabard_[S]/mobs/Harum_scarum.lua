-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Harum Scarum
-----------------------------------
mixins = { require('scripts/mixins/families/djinn') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
end

return entity
