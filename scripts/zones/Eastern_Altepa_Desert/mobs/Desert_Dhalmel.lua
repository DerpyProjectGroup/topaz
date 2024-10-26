-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Desert Dhalmel
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 111, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
end

return entity
