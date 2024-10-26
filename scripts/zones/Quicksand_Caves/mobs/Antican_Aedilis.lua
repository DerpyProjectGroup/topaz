-----------------------------------
-- Area: Quicksand Caves
--  Mob: Antican Aedilis
-- Note: PH for Antican Tribunus
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
local entity = {}

local tribunusPHTable =
{
    [ID.mob.ANTICAN_TRIBUNUS + 18] = ID.mob.ANTICAN_TRIBUNUS, -- -575.455 -0.401 -433.802  TODO: Audit PH
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 812, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 813, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 814, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 815, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 816, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 817, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 818, 2, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 819, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tribunusPHTable, 10, 3600) -- 1 hour
end

return entity
