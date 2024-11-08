-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Donjon Bat
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 709, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

return entity
