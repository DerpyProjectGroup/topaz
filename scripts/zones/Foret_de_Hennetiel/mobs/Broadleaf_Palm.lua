-----------------------------------
-- Area: Foret De Hennetiel
-- NPC: Broadleaf Palm
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.reives.onMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.reives.onMobDeath(mob)
end

return entity