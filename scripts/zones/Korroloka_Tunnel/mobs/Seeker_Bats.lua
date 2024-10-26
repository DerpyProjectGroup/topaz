-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Seeker Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 727, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 728, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
