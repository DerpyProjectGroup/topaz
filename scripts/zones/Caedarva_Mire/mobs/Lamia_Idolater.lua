-----------------------------------
-- Area: Caedarva Mire
--  Mob: Lamia Idolater
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
