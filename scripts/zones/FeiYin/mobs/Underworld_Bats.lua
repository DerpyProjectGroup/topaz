-----------------------------------
-- Area: Fei'Yin
--  Mob: Underworld Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 713, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 714, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 715, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
