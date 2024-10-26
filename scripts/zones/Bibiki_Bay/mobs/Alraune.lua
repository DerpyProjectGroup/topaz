-----------------------------------
-- Area: Bibiki Bay
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 3, xi.regime.type.FIELDS)
end

return entity
