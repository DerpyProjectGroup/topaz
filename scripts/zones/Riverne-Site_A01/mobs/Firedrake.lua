-----------------------------------
-- Area: Riverne-Site_A01
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity