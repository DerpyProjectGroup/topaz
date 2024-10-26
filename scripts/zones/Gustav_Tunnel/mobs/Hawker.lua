-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Hawker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 764, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
