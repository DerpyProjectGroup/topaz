-----------------------------------
-- Area: Quicksand Caves
--  Mob: Antican Quaestor
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 812, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 813, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 814, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 815, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 816, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 817, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 818, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 819, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 3, xi.regime.type.FIELDS)
end

return entity
