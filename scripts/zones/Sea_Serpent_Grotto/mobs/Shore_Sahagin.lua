-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Shore Sahagin
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
