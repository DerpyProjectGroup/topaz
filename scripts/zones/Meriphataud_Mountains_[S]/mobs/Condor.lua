-----------------------------------
-- Area: Meriphataud Mountains [S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 10, 1, xi.regime.type.FIELDS)
end

return entity
