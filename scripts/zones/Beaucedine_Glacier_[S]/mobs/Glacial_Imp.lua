-----------------------------------
-- Area: Beaucedine Glacier [S]
--  Mob: Glacial Imp
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
end

return entity
