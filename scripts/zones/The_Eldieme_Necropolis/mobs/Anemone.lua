-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Anemone
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 minutes
end

return entity
