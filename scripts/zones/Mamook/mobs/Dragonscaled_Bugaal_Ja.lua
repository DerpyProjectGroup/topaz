-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-- Note: True behavior of bugard respawn unfconfirmed, and assumed to be
--  similar to that of wikipedia entries
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

local function respawnBugards(mob)
    if mob:getLocalVar('respawnTime') < os.time() then
        mob:setLocalVar('respawnTime', os.time() + 120)
        local pos = mob:getPos()

        for i = 1, 3 do
            local bugard = GetMobByID(mob:getID() + i)

            if not bugard:isAlive() then
                mob:entityAnimationPacket('casm')
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(false)
                mob:setMobAbilityEnabled(false)

                mob:timer(1500, function(mobArg)
                    mobArg:entityAnimationPacket('shsm')
                    bugard:setSpawn(pos.x + math.random(-5, 5), pos.y, pos.z + math.random(-5, 5))
                    bugard:spawn()
                    xi.follow.follow(bugard, mob)

                    if mobArg:getTarget() ~= nil then
                        bugard:updateEnmity(mob:getTarget())
                    end

                    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setMobAbilityEnabled(true)
                end)

                return
            end
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP) -- Needs verification

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.FAMILIAR, hpp = 85 },
        },
    })
end

entity.onMobRoam = function(mob)
    respawnBugards(mob)
end

entity.onMobFight = function(mob, target)
    respawnBugards(mob)

    for i = 1, 3 do
        local bugard = GetMobByID(mob:getID() + i)

        if
            bugard:isAlive() and
            bugard:getCurrentAction() == xi.action.ROAMING
        then
            bugard:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Reduces Mamool Ja Savages' military force by 1
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(100800, 259200)) -- 28 to 72 hours
end

return entity
