-----------------------------------
-- Area: Bhaflau Thickets
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 2, xi.regime.type.FIELDS)
end

return entity
