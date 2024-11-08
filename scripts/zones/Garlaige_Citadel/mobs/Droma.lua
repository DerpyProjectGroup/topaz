-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Droma
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 707, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
