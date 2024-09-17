-----------------------------------
-- Area: Mount Zhayolm
--   NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additem 2583
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Sarameya
-- TODO: PostAIRewrite: Code the Howl effect and gradual resists.
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

function howlSequence(mob, target)
    local howlNum = mob:getLocalVar('Howl')
    mob:setLocalVar('HowlTime', os.time() + 5)

    if howlNum > 0 then
        -- howl sequence
        if howlNum == 1 then
            mob:setMod(xi.mod.STUNRES, 100)
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMagicCastingEnabled(false)

            mob:useMobAbility(1892) -- Howl
            mob:setLocalVar('Howl', howlNum + 1)
        elseif howlNum == 2 then
            mob:useMobAbility(1788) -- Ullulation
            mob:setLocalVar('Howl', howlNum + 1)
        elseif howlNum == 3 then
            if mob:getHPP() > 25 then
                -- can also not do this and just idle during this 5s period
                local mp = mob:getMP()
                if mp < 300 then
                    mob:addMP(300 - mp)
                end
                mob:castSpell(176, target) -- Firaga III
            else
                mob:useMobAbility(1790) -- GoH
            end
            mob:setLocalVar('Howl', howlNum + 1)
        elseif howlNum == 4 then
            mob:useMobAbility(1789) -- Magma Hoplon
            mob:setLocalVar('Howl', howlNum + 1)
            mob:useMobAbility(1892) -- Howl
        end
        mob:setLocalVar('Howl', howlNum + 1)


        if  mob:getLocalVar('Howl') == 5 then
            mob:setLocalVar('Howl', 0)
            mob:setLocalVar('HowlTime', os.time() + math.random(60,180))
            mob:setMod(xi.mod.STUNRES, 0)
            -- maybe don't set these until he's acted on again?
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMagicCastingEnabled(true)
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 4000)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UDMGBREATH, -20)
    mob:setMod(xi.mod.UDMGMAGIC, -20)
    mob:setMod(xi.mod.STR, 40)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:addMod(xi.mod.MEVA, 95)
    mob:addMod(xi.mod.MDEF, 30)
    mob:addMod(xi.mod.SILENCE_MEVA, 20)
    mob:addMod(xi.mod.GRAVITY_MEVA, 20)
    mob:addMod(xi.mod.LULLABY_MEVA, 30)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setLocalVar('Howl', 0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
end

entity.onMobRoam = function(mob)
    if math.random() > .95 then
        mob:useMobAbility(1892)
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('HowlTime', os.time() + math.random(60,180)) -- 60 180
end

entity.onMobDisengage = function(mob)
    mob:setAggressive(false)
    -- reset howl sequence
    mob:setLocalVar('Howl', 0)
    mob:setMod(xi.mod.STUNRES, 0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()
    local useChainspell = false
    local howlNum = mob:getLocalVar('Howl')

    if howlNum > 0 then
        if os.time() >= mob:getLocalVar('HowlTime') and mob:actionQueueEmpty() then
            howlSequence(mob, target)
        end
    else
        if hpp < 90 and mob:getLocalVar('chainspell89') == 0 then
            mob:setLocalVar('chainspell89', 1)
            useChainspell = true
        elseif hpp < 70 and mob:getLocalVar('chainspell69') == 0 then
            mob:setLocalVar('chainspell69', 1)
            useChainspell = true
        elseif hpp < 50 and mob:getLocalVar('chainspell49') == 0 then
            mob:setLocalVar('chainspell49', 1)
            useChainspell = true
        elseif hpp < 30 and mob:getLocalVar('chainspell29') == 0 then
            mob:setLocalVar('chainspell29', 1)
            useChainspell = true
        elseif hpp < 10 and mob:getLocalVar('chainspell9') == 0 then
            mob:setLocalVar('chainspell9', 1)
            useChainspell = true
        end

        if useChainspell then
            mob:useMobAbility(692) -- Chainspell
            mob:setMobMod(xi.mobMod.GA_CHANCE, 100)
        end

        -- Spams TP moves and -ga spells
        if mob:hasStatusEffect(xi.effect.CHAINSPELL) and
            mob:getLocalVar('timeSinceWS') < os.time() - 5 then
                mob:setTP(2000)
                mob:setLocalVar('timeSinceWS', os.time())
                mob:useMobAbility()
        else -- No Chainspell
            if mob:getMobMod(xi.mobMod.GA_CHANCE) == 100 then
                mob:setMobMod(xi.mobMod.GA_CHANCE, 50)
            end

            if os.time() >= mob:getLocalVar('HowlTime') and mob:getLocalVar('Howl') == 0 then -- Check to see if its time to do Howl Sequence
                mob:setLocalVar('Howl', 1)
                howlSequence(mob, target)
            end
        end
    end



    -- Regens 1% of his HP a tick with Blaze Spikes on
    if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        mob:setMod(xi.mod.REGEN, math.floor(mob:getMaxHP()/100))
    else
        if mob:getMod(xi.mod.REGEN) > 0 then
            mob:setMod(xi.mod.REGEN, 0)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 40, power = 50 })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar('timeSinceWS', os.time())
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
end

return entity
