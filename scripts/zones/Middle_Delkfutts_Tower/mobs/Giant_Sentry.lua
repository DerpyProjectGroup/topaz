-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Sentry
-- Note: PH for Rhoitos and Eurytos
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local eurytosPHList =
{
    [ID.mob.EURYTOS - 8] = ID.mob.EURYTOS, -- 27 -47 101
    [ID.mob.EURYTOS - 3] = ID.mob.EURYTOS, -- 11 -47 99
}

local rhoitosPHTable =
{
    [ID.mob.RHOITOS + 3] = ID.mob.RHOITOS,
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, rhoitosPHTable, 5, 7200) -- 2 hours minimum
    xi.mob.phOnDespawn(mob, eurytosPHList, 5, 7200) -- 2 hours minimum
end

return entity
