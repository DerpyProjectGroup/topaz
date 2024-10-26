-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Lycopodium
-----------------------------------
mixins = { require('scripts/mixins/families/lycopodium') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
