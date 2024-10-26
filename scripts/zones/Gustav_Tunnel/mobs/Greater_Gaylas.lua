-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Greater Gaylas
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 763, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 3, xi.regime.type.FIELDS)
end

return entity
