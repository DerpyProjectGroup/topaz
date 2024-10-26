-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Gatekeeper
-- Note: PH for Rhoitos and Polybotes
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local polybotesPHTable =
{
    [ID.mob.POLYBOTES + 1] = ID.mob.POLYBOTES, -- -42.392 -63.535 -0.946
}

local rhoitosPHTable =
{
    [ID.mob.RHOITOS + 1] = ID.mob.RHOITOS, -- 81.445 -79.977 71.427
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, rhoitosPHTable, 5, 7200) -- 2  hours minimum.
    xi.mob.phOnDespawn(mob, polybotesPHTable, 5, 7200) -- 2 hours minimum.
end

return entity
