-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Evacuee
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
end

return entity
