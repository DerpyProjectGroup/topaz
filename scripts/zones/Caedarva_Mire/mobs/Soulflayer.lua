-----------------------------------
-- Area: Caedarva Mire
--  Mob: Soulflayer
-- Note: PH for Vidhuwa the Wrathborn
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
require('scripts/globals/mobs')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VIDHUWA_PH, 20, 3600) -- 1 hour
end

return entity
