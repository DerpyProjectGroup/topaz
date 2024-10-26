-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Tinkerer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 631, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 633, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity
