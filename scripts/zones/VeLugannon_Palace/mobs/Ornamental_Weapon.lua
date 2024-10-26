-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Ornamental Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 744, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
