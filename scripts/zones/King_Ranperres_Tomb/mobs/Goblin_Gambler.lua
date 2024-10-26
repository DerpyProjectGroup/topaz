-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Gambler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 631, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 635, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 3, xi.regime.type.FIELDS)
end

return entity
