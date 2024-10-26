-----------------------------------
-- Area: Grauberg [S]
--  Mob: Ajattara
-- Note: PH for Scitalis
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
local entity = {}

local scitalisPHTable =
{
    [ID.mob.SCITALIS - 1] = ID.mob.SCITALIS,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, scitalisPHTable, 10, 3600) -- 1 hour
end

return entity
