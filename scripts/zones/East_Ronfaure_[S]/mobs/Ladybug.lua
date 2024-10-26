-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Ladybug
-- Note: PH for Skogs Fru
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
mixins = { require('scripts/mixins/families/ladybug') }
-----------------------------------
local entity = {}

local skogsFruPHTable =
{
    [ID.mob.SKOGS_FRU- 70] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 32] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 31] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 30] = ID.mob.SKOGS_FRU,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, skogsFruPHTable, 5, 3600) -- 1 hour
end

return entity
