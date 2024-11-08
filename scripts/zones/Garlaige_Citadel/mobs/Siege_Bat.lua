-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Siege Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 704, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
