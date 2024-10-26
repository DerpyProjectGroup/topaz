-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Gigantobugard
-- Note: PH for Megalobugard
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
local entity = {}

local megalobugardPHTable =
{
    [ID.mob.MEGALOBUGARD - 21] = ID.mob.MEGALOBUGARD, -- -137.168 -15.390 91.016
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, megalobugardPHTable, 10, 3600) -- 1 hour
end

return entity
