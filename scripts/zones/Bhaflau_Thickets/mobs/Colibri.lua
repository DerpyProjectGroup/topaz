-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Colibri
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
