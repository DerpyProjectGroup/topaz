-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Panna Cotta
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 614, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 615, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity
