-----------------------------------
-- Area: FeiYin
--  Mob: Colossus
-- Note: PH for Goliath
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
local entity = {}

local goliathPHTable =
{
    [ID.mob.GOLIATH + 7] = ID.mob.GOLIATH,
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 715, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goliathPHTable, 10, 1) -- No minimum respawn
end

return entity
