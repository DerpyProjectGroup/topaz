-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Biddybug
-----------------------------------
mixins = { require('scripts/mixins/families/ladybug') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
