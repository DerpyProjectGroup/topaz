-----------------------------------
-- Area: Arrapago Reef
--  Mob: Heraldic Imp
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
end

return entity
