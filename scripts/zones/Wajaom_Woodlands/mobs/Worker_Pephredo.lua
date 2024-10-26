-----------------------------------
-- Area: Wajaom Woodlands
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
