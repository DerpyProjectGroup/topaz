-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Deviator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
