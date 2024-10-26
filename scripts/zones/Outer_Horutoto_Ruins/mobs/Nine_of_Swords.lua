-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_SWORDS)
    -- xi.regime.checkRegime(player, mob, 668, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 3, xi.regime.type.FIELDS)
end

return entity
