-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Lou Carcolh
-- Note: PH for Nommo
-----------------------------------
mixins = {require('scripts/mixins/families/slug')}
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
local entity = {}

local nommoPHTable =
{
    [ID.mob.NOMMO - 5] = ID.mob.NOMMO, -- -168.292 24.499 396.933
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nommoPHTable, 10, 3600) -- 1 hour
end

return entity
