-----------------------------------
-- Area: Aydeewa Subterrane
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity