-----------------------------------
-- Area: Bhaflau Thickets
--  MOB: Grand Marid
-- Note: 30 minute lottery
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
mixins = 
{ 
require('scripts/mixins/families/chigoe_pet'),
require('scripts/mixins/families/marid'),
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 5, 1800)
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 5, 1800)
end

return entity
