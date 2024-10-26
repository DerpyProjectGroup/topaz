-----------------------------------
-- Area: Bibiki Bay
--  Mob: Coralline Uragnite
-----------------------------------
mixins = { require('scripts/mixins/families/uragnite') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 10, 2, xi.regime.type.FIELDS)
end

return entity
