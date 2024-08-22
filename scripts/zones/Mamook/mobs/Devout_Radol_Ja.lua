-----------------------------------
-- Area: Mamook
--   NM: Devout Radol Ja
-- Note: Appears to have a unique HP display, where the first % HP drops down
--  extremely quickly and the rest dropping much more slowly.
--  However, Radol Ja appears to have approx 20k HP.
--  Fight with cures + benediction Radol Ja went through 80k HP in total
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP) -- Needs verification

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = 3 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Reduces Mamool Ja Savages' military force by 1
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(259200, 432000)) -- 3 to 5 days **Spawn behaviour needs verification**
end

return entity
