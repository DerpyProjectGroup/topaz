-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Ruly Imp
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
