-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
