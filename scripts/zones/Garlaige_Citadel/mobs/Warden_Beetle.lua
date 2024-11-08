-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Warden Beetle
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 710, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
