-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Kaboom
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 709, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
end

return entity
