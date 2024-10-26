-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Flamedrake PH
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
local entity = {}

local aiatarPHTable =
{
    [ID.mob.AIATAR - 5] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 4] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 3] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 2] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 1] = ID.mob.AIATAR,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, aiatarPHTable, 10, 75600) -- 50 minutes
end

return entity
