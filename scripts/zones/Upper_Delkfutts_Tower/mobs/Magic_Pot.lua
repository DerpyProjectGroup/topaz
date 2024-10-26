-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Magic Pot
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 788, 3, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 789, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 3, xi.regime.type.FIELDS)
end

return entity
