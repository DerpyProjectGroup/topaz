-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Vault Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 705, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 708, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity
