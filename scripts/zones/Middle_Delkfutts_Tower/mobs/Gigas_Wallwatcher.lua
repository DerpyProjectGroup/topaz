-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Gigas Wallwatcher
-- Note: PH for Ogygos
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local ogygosPHTable =
{
    [ID.mob.OGYGOS + 1] = ID.mob.OGYGOS, -- -503 -127.715 24
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ogygosPHTable, 5, 7200) -- 2 hours minimum
end

return entity
