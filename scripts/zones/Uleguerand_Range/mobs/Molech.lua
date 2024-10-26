-----------------------------------
-- Area: Uleguerand Range
--  Mob: Molech
-- Note: PH for Magnotaur
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
local entity = {}

local magnotaurPHTable =
{
    [ID.mob.MAGNOTAUR - 2] = ID.mob.MAGNOTAUR,
    [ID.mob.MAGNOTAUR - 1] = ID.mob.MAGNOTAUR,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, magnotaurPHTable, 10, 3600) -- 1 hour
end

return entity
