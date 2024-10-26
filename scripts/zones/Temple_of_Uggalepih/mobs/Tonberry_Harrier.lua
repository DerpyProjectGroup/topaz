-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry Harrier
-- Note: PH for Sozu Terberry
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
local entity = {}

local terberryPHTable =
{
    [ID.mob.SOZU_TERBERRY - 3] = ID.mob.SOZU_TERBERRY, -- -122 0.028 -13
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 790, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 791, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 792, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 793, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 794, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 795, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, terberryPHTable, 10, 3600) -- 1 hour
end

return entity
