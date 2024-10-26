-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Tundra Tiger
-- Note: PH for Nue, Kirata
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
local entity = {}

local nuePHTable =
{
    [ID.mob.NUE - 2] = ID.mob.NUE, -- -342.830 -100.584 168.662
    [ID.mob.NUE - 1] = ID.mob.NUE, -- -322.000 -100.000 116.000
}

local kirataPHTable =
{
    [ID.mob.KIRATA - 2] = ID.mob.KIRATA, -- 75.797 -0.335 -323.659
    [ID.mob.KIRATA - 1] = ID.mob.KIRATA, -- 69.336 -0.234 -276.561
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 46, 1, xi.regime.type.FIELDS)
    -- xi.regime.checkRegime(player, mob, 47, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, kirataPHTable, 7, 3600) -- 1 hour minimum
    xi.mob.phOnDespawn(mob, nuePHTable, 7, 3600) -- 1 hour minimum
end

return entity
