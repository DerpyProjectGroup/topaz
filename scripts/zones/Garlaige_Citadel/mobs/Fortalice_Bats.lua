-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fortalice Bats
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 710, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

return entity
