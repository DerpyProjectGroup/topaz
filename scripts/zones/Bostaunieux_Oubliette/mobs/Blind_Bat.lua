-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Blind Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 615, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 617, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
