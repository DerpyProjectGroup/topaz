-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Jotunn Wallkeeper
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 786, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 789, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
