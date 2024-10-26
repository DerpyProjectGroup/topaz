-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Death Jacket
-- Note: PH for Erle
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local phTable =
    {
        [ID.mob.ERLE - 6] = ID.mob.ERLE,
    }

    xi.mob.phOnDespawn(mob, phTable, 10, 5400) -- 1.5 hour
end

return entity
