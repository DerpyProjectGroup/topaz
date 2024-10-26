-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Lich
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 671, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 674, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 675, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
