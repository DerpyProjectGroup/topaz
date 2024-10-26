-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Smilodon
-- Note: PH for La Velue
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
local entity = {}

local laVeluePHTable =
{
    [ID.mob.LA_VELUE - 22] = ID.mob.LA_VELUE, -- -314.365 -18.745 -56.016
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, laVeluePHTable, 10, 3600) -- 1 hour
end

return entity
