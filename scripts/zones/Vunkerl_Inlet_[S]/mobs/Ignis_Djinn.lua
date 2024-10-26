-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Ignis Djinn
-- Note: PH for Big Bang
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
mixins = { require('scripts/mixins/families/djinn') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BIG_BANG_PH, 10, 3600) -- 1 hour
end

return entity
