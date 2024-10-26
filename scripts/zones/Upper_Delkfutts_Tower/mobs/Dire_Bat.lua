-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Dire Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 786, 3, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 787, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
end

return entity
