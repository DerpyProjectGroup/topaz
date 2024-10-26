-----------------------------------
-- Area: East Ronfaure [S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
end

return entity
