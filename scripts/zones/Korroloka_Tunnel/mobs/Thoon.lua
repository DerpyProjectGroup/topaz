-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Thoon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 229)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
