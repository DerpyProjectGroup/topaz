-----------------------------------
-- Area: West Sarutabaruta [S]
-----------------------------------

local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
end

return entity
