-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Robber
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 764, 3, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 765, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
end

return entity
