-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Aydeewa Diremite
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
end

return entity
