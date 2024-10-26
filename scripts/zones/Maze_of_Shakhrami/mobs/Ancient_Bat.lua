-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ancient Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 698, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 699, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
