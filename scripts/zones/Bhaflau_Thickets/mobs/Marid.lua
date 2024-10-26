-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Marid
-- Note: Place holder Mahishasura
-----------------------------------
mixins =
{
    require('scripts/mixins/families/chigoe_pet'),
    require('scripts/mixins/families/marid'),
}
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
local entity = {}

local mahishasuraPHTable =
{
    [ID.mob.MAHISHASURA - 10] = ID.mob.MAHISHASURA, -- 215.000 -18.000 372.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mahishasuraPHTable, 5, 10800) -- 3 hours
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 5, 1800)
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 5, 1800)
end

return entity
