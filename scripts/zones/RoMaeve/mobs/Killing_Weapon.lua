-----------------------------------
-- Area: RoMaeve
--  Mob: Killing Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 119, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
