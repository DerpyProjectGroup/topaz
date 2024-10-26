-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Big Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 782, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 783, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
