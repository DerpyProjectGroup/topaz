-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 753, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
