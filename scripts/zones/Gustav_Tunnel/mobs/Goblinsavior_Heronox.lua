-----------------------------------
-- Area: Gustav Tunnel
--   NM: Goblinsavior Heronox
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
    xi.hunts.checkHunt(mob, player, 423)
end

return entity
