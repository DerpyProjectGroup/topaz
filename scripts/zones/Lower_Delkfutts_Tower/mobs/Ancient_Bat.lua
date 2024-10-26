-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Ancient Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 777, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 778, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 779, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 780, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 781, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
