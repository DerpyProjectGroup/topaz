-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Statue
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 754, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
