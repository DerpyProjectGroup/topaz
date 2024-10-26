-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Healer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 644, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity
