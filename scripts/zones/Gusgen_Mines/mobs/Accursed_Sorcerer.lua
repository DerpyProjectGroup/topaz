-----------------------------------
-- Area: Gusgen Mines
--  Mob: Accursed Sorcerer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 679, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 680, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 686, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

return entity
