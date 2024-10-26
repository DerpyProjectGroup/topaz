-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Headsman
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 643, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
