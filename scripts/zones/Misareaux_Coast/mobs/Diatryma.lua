-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Diatryma
-- Note: PH for Okyupete
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
local entity = {}

local okyupetePHTable =
{
    [ID.mob.OKYUPETE - 8] = ID.mob.OKYUPETE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, okyupetePHTable, 10, 3600) -- 1 hour
end

return entity
