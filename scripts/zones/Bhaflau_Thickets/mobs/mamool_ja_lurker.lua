-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Mamool Ja Lurker
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
