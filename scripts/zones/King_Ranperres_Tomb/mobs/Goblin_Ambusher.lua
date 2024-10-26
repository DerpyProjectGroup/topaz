-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Ambusher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 631, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 633, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
end

return entity
