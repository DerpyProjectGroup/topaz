-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Huge Spider
-- Note: Place holder for Ankabut
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
local entity = {}

local ankabutPHTable =
{
    [ID.mob.ANKABUT - 4] = ID.mob.ANKABUT, -- 656.399 -11.580 507.091
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ankabutPHTable, 10, 3600) -- 1 hour
end

return entity
