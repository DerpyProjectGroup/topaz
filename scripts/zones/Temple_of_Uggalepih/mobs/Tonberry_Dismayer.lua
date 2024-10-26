-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry Dismayer
-- Note: PH for Tonberry Kinq
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
mixins = { require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/prelate_door'), }
-----------------------------------
local entity = {}

local kingqPHTable =
{
    [ID.mob.TONBERRY_KINQ - 4] = ID.mob.TONBERRY_KINQ, -- -221.717 0.996 12.819
    [ID.mob.TONBERRY_KINQ - 2] = ID.mob.TONBERRY_KINQ, -- -218 -0.792 24
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
    xi.mob.phOnDespawn(mob, kingqPHTable, 10, 21600) -- 6 hours, 10% pop chance
end

return entity
