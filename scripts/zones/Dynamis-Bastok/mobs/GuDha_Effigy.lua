-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Gu'Dha Effigy
-- Note: Mega Boss
-----------------------------------
local entity = {}

mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[isDynamis_Megaboss]', 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 4401 })
end

return entity
