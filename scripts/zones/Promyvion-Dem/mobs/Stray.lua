-----------------------------------
-- Area: Promyvion-Dem
--   NM: Stray
-----------------------------------
require('scripts/globals/promyvion')
mixins =
{
    require('scripts/mixins/families/empty')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
