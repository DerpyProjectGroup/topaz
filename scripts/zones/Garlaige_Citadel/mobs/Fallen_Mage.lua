-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Mage
-- Note: Place holder Hovering Hotpot
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
local entity = {}

local hotpotPHTable =
{
    [ID.mob.HOVERING_HOTPOT - 3] = ID.mob.HOVERING_HOTPOT, -- 188.229 -0.018 20.151
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hotpotPHTable, 20, 1800) -- 30 minutes minimum.
end

return entity
