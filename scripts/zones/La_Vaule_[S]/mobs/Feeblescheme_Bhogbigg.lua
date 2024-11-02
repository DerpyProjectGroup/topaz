-----------------------------------
-- Area: La Vaule [S]
--   NM: Feeblescheme Bhogbigg
-----------------------------------
-- mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addMod(xi.mod.STATUSRES, 30)
end

entity.onMobFight = function(mob, target)
    local grenadeTimer = mob:getLocalVar('grenadeTimer')
    local vialTimer    = mob:getLocalVar('vialTimer')
    local vialCount    = mob:getLocalVar('vialCount')
    local enmityList = mob:getEnmityList()

    -- Retrieve grenade entities
    local grenades =
    {
        GetMobByID(mob:getID() + 1),
        GetMobByID(mob:getID() + 2),
        GetMobByID(mob:getID() + 3)
    }

    local vial = GetMobByID(mob:getID() + 4)

    if
        os.time() > grenadeTimer and
        mob:canUseAbilities() and
        mob:getLocalVar('currentlySummoning') == 0
    then

        -- Spawn or engage a single grenade
        for _, grenade in ipairs(grenades) do
            if grenade:isSpawned() and grenade:getLocalVar('hasTarget') == 0 then
                if target and grenade:getCurrentAction() == xi.act.ROAMING then
                    grenade:setLocalVar('hasTarget', 1)
                    local enmityList = mob:getEnmityList()
                    local grenadeTarget = utils.randomEntry(enmityList)['entity']
                    grenade:updateEnmity(grenadeTarget)
                end
            elseif not grenade:isSpawned() then
                -- Begin summon sequence for a single grenade
                if mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and mob:actionQueueEmpty() then
                    mob:setAutoAttackEnabled(false)
                    mob:setMagicCastingEnabled(false)
                    mob:setMobAbilityEnabled(false)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    mob:entityAnimationPacket('casm')
                    mob:setLocalVar('currentlySummoning', 1)

                    mob:timer(2000, function(orc)
                        orc:entityAnimationPacket('shsm')
                        orc:setAutoAttackEnabled(true)
                        orc:setMagicCastingEnabled(true)
                        orc:setMobAbilityEnabled(true)
                        orc:setMobMod(xi.mobMod.NO_MOVE, 0)

                        -- Spawn the grenade near the mob
                        local pos = orc:getPos()
                        grenade:setSpawn(pos.x + math.random(-1, 1), pos.y, pos.z + math.random(-1, 1), pos.rot)
                        grenade:spawn()
                        local enmityList = mob:getEnmityList()
                        local grenadeTarget = utils.randomEntry(enmityList)['entity']
                        grenade:updateEnmity(grenadeTarget)
                        grenade:stun(2000)
                        orc:stun(2000)
                        orc:setLocalVar('grenadeTimer', os.time() + math.random(15, 60))
                        orc:setLocalVar('currentlySummoning', 0)
                    end)
                end
                break  -- Exit loop after spawning one grenade
            end
        end
    elseif
        os.time() > vialTimer and
        mob:canUseAbilities() and
        mob:getLocalVar('currentlySummoning') == 0
    then
        if vial:isSpawned() and vial:getLocalVar('hasTarget') == 0 then
            if target and vial:getCurrentAction() == xi.act.ROAMING  then
                vial:setLocalVar('hasTarget', 1)
                local vialTarget = utils.randomEntry(enmityList)['entity']
                vial:updateEnmity(vialTarget)
            end
        elseif -- not spawned, not casting, not using an ability and should summon
                mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
                mob:actionQueueEmpty() and
                not vial:isSpawned()
        then
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket('casm')
            mob:setLocalVar('currentlySummoning', 1)
            mob:timer(2000, function(orc2)
                orc2:entityAnimationPacket('shsm')
                orc2:setAutoAttackEnabled(true)
                orc2:setMagicCastingEnabled(true)
                orc2:setMobAbilityEnabled(true)
                orc2:setMobMod(xi.mobMod.NO_MOVE, 0)
                local pos = orc2:getPos()
                vial:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
                vial:spawn()
                local vialTarget = utils.randomEntry(enmityList)['entity']
                vial:updateEnmity(vialTarget)
                orc2:stun(2000)
                vial:stun(2000)
                orc2:setLocalVar('vialCount', vialCount + 1)
                orc2:setLocalVar('currentlySummoning', 0)
                if vialCount >= 5 then
                    orc2:setLocalVar('vialTimer', os.time() + 360) -- 6min Cooldown after 5 are spawned.
                    orc2:setLocalVar('vialCount', 0)
                else
                    orc2:setLocalVar('vialTimer', os.time() + math.random(50, 60))
                end
            end)
        end
    end
end

entity.onMobWeaponSkillPrepare = function (mob, target)
    return 2263 -- Tornado Edge
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('vialCount', 0)
    mob:setLocalVar('grenadeTimer', os.time() + 15)
    mob:setLocalVar('vialTimer', os.time() + 30)
end

entity.onMobDisengage = function(mob)
end

entity.onMobRoam = function(mob)
    mob:setLocalVar('vialTimer', 0)
    mob:setLocalVar('grenadeTimer', 0)
    mob:setLocalVar('vialCount', 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
