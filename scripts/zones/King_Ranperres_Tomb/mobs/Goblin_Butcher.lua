-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Butcher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 631, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 633, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
end

return entity
