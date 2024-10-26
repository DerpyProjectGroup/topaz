-----------------------------------
-- Area: Valley of Sorrows
--  Mob: Peryton
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 139, 2, xi.regime.type.FIELDS)
    -- xi.regime.checkRegime(player, mob, 141, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
end

return entity
