-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry Stabber
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/prelate_door'), }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 790, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 791, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 792, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 793, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 794, 1, xi.regime.type.GROUNDS)
    -- xi.regime.checkRegime(player, mob, 795, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
