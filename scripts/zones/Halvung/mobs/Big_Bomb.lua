-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-----------------------------------
mixins = { require('scripts/mixins/families/bomb_grow') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMod(xi.mod.SILENCE_MEVA, 150) -- Approximation - requires further experimentation
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 466)
end

return entity
