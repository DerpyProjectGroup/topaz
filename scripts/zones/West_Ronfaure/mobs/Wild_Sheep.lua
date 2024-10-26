-----------------------------------
-- Area: West Ronfaure
--  Mob: Wild Sheep
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 56, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
