-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Greater Colibri
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
end

return entity
