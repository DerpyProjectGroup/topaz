-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Soot Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 628, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity
