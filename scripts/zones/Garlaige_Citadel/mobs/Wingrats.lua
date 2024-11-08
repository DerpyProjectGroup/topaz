-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wingrats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 703, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
