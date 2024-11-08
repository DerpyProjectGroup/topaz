-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wraith
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 708, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 3, xi.regime.type.FIELDS)
end

return entity
