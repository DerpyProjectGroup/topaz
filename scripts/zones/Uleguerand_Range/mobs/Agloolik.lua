-----------------------------------
-- Area: Uleguerand Range
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity