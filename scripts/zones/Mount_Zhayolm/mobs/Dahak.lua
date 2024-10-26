-----------------------------------
-- Area: Mount Zhayolm
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
end

return entity
