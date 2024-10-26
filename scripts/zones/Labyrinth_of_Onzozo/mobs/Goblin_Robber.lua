-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Robber
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
end

return entity
