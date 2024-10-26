-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Tonberry Shadower
-- Note: PH for Hoar-knuckled Rimberry
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HOAR_KNUCKLED_RIMBERRY_PH, 10, 5400) -- 90 minute minimum
end

return entity
