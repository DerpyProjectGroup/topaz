-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Coppercap
-- Note: Items stolen removes caps from head
-----------------------------------
require('scripts/globals/mobs')
mixins = {require('scripts/mixins/families/funguar_s')}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
end

return entity
