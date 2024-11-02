-----------------------------------
-- Area: La Vaule [S]
--   NM: Hawkeyed Dnatbat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.RANGED_DMG_RATING, 100)
    mob:setMod(xi.mod.RATT, 500)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
