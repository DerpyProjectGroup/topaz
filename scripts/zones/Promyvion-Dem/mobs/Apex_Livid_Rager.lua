-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Apex Livid Rager
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima'),
    require('scripts/mixins/families/empty')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
end

return entity
