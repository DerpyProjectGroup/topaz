-----------------------------------
-- Area: Caedarva Mire
--  Mob: Mosshorn
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
end

return entity
