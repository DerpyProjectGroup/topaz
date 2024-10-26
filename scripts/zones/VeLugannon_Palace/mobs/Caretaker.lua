-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Caretaker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 746, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
