-----------------------------------
-- Area: Promyvion-Mea
--  Mob: Craver
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima'),
    require('scripts/mixins/families/empty')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 3, xi.regime.type.FIELDS)
end

return entity
