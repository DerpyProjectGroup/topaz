-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Fuligo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 669, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 670, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
