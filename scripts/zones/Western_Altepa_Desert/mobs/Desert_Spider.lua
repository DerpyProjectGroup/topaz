-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Spider
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 134, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
