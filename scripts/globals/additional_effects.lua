-----------------------------------
-- This global is intended to handle additional effects from item sources of:
-- melee attacks, ranged attacks, auto-spikes
-- Notes:
-- Ranged versions get bonus from int/mnd, melee does NOT.
-- No matter how much INT you stack that fire sword doesn't hit any harder.
-- No matter how much MND you stack that holy mace doesn't hit any harder.
-- But Ice Arrows and Bloody Bolts will gain damage from INT and Holy bolts will gain damage from MND.
-- Melee weapon proc also do not appear to adjust for level, only resistance.
-- In testing my fire sword had the same damage ranges no matter my level vs same mob.
-- Weakness/resistance to element would swing damage range a lot
-- For status effects is it possible to land on highly resistant mobs because of flooring.
-- Ranged throwing items have weird cases that don't fully fit in the above,
-- and a handfull of weapons have seem to scale up the more magic accuracy you have
-- Yes accuracy, not attack. More research needed. Not adding them till we know how they work.
-- (And then these comments get cleaned up)
-----------------------------------
require('scripts/globals/teleports') -- For warp weapon proc.
require('scripts/globals/magic') -- For resist functions
require('scripts/globals/utils') -- For clamping function
-----------------------------------
xi = xi or {}
xi.additionalEffect = xi.additionalEffect or {}

xi.additionalEffect.dStatBonus = function(attacker, defender, dStat, damage)
    local statTable =
    {
        -- [attacker stat] = {counter stat, softcap},
        [xi.mod.MND] = { cStat = xi.mod.MND, softcap = 40 },
        [xi.mod.INT] = { cStat = xi.mod.INT, softcap = 20 },
        -- Can use pretty much any modifier and the pairs don't have to math (in case of SE shenanigans..)
    }

    local tableRow = statTable[dStat]
    local sCap = tableRow.softcap
    local bonus = 0

    -- Check if this is base stat or other modifier
    if dStat >= xi.mod.STR and dStat <= xi.mod.CHR then
        bonus = attacker:getStat(dStat) - defender:getStat(tableRow.cStat)
    else
        -- See table note above
        bonus = attacker:getMod(dStat) - defender:getMod(tableRow.cStat)
    end

    if bonus then
        if sCap > 0 and bonus > sCap then
            bonus = bonus + (bonus - sCap) / 2
        end

        if bonus > 0 then
            damage = damage + bonus
        end
    end

    return damage
end

xi.additionalEffect.levelCorrectRates = function(dLV, aLV, chance, lvCorrect)
    -- Do not alter 100% proc rates
    if chance < 100 then
        if dLV > aLV then
            chance = utils.clamp(chance - lvCorrect * (dLV - aLV), 1, 99)
        end
    end

    return chance
end

xi.additionalEffect.statusAttack = function(addStatus, defender)
    local effectList =
    {
        [xi.effect.DEFENSE_DOWN] = { tick = 0, strip = xi.effect.DEFENSE_BOOST },
        [xi.effect.EVASION_DOWN] = { tick = 0, strip = xi.effect.EVASION_BOOST },
        [xi.effect.ATTACK_DOWN]  = { tick = 0, strip = xi.effect.ATTACK_BOOST },
        [xi.effect.POISON]       = { tick = 3, strip = nil },
        [xi.effect.CHOKE]        = { tick = 3, strip = nil },
    }

    local effect = effectList[addStatus]
    if effect then
        if effect.strip then
            defender:delStatusEffect(effect.strip)
        end

        return effect.tick
    end

    return 0
end

xi.additionalEffect.calcDamagePhys = function(attacker, element, defender, damage, addType, item)
    local params = {}

    return damage
end

xi.additionalEffect.calcDamage = function(attacker, element, defender, damage, addType, item)
    local params = {}

    params.bonusmab = 0
    params.includemab = true
    damage = addBonusesAbility(attacker, element, defender, damage, params)
    damage = damage * applyResistanceAddEffect(attacker, defender, element, 0)
    -- Todo: make sure day/weather/affinity bonuses tie in right here
    damage = adjustForTarget(defender, damage, element)
    damage = finalMagicNonSpellAdjustments(attacker, defender, element, damage)

    --[[
    This should rightly be modified by resistance checks, and while those DO they are presently not perfect.
    If you want to force some extra randomness, un-comment the line below to artificially force 20% variance.
    ]]
    damage = damage * (math.random(90, 110) / 100)

    return damage
end

-- paralyze on hit, fire damage on hit, etc.
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
-- TODO: Reduce complexity in this function:
-- - replace giant if/else chain with table+key functions
--   e.g. [procType.DAMAGE] = { code }
-- - replace each handler (elseif addType == procType.DEBUFF then) with a function
xi.additionalEffect.attack = function(attacker, defender, baseAttackDamage, item)
    local lvCorrect = item:getMod(xi.mod.ITEM_ADDEFFECT_LVADJUST)
    local dStat     = item:getMod(xi.mod.ITEM_ADDEFFECT_DSTAT)
    local addType   = item:getMod(xi.mod.ITEM_ADDEFFECT_TYPE)
    local subEffect = item:getMod(xi.mod.ITEM_SUBEFFECT)
    local damage    = item:getMod(xi.mod.ITEM_ADDEFFECT_DMG)
    local chance    = item:getMod(xi.mod.ITEM_ADDEFFECT_CHANCE)
    local element   = item:getMod(xi.mod.ITEM_ADDEFFECT_ELEMENT)
    local addStatus = item:getMod(xi.mod.ITEM_ADDEFFECT_STATUS)
    local power     = item:getMod(xi.mod.ITEM_ADDEFFECT_POWER)
    local duration  = item:getMod(xi.mod.ITEM_ADDEFFECT_DURATION)
    local option    = item:getMod(xi.mod.ITEM_ADDEFFECT_OPTION)
    local msgID     = 0
    local msgParam  = 0
    local drainRoll = math.random(1, 3) -- Temp, being refactored out

    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
        DAMAGE          = 1,
        DEBUFF          = 2,
        HP_HEAL         = 3,
        MP_HEAL         = 4,
        HP_DRAIN        = 5,
        MP_DRAIN        = 6,
        TP_DRAIN        = 7,
        HPMPTP_DRAIN    = 8,
        DISPEL          = 9,
        ABSORB_STATUS   = 10,
        SELF_BUFF       = 11,
        DEATH           = 12,
        BRIGAND         = 13,
        VS_FAMILY       = 14,
        AVATAR_SUMMONED = 15,
        NIGHTTIME       = 16,
        GOD_WIND        = 17,
        VS_ECOSYSTEM    = 18,
        DAMAGE_HP_PERC  = 19,
        POISON_PARALYZE_BIND  = 20,
        DAMAGE_MP_PERC  = 21,

        HPMP_DRAIN    = 22, -- ToDo Shift our enum up to avoid conflicts - Umeboshi
    }

    -- If player is level synced below the level of the item, do no proc
    if item:getReqLvl() > attacker:getMainLvl() then
        return 0, 0, 0
    end

    -- Ranged attack items use this, most other items -usually- do not (See notes at top of script).
    if lvCorrect > 0 then
        chance = xi.additionalEffect.levelCorrectRates(defender:getMainLvl(), attacker:getMainLvl(), chance, lvCorrect)
    end

    -- If we're not going to proc, lets not execute all those checks!
    if math.random(1, 100) > chance then
        return 0, 0, 0
    end

    -- Archery/marksmanship use this, most other items -usually- do not (See notes at top of script).
    if dStat > 0 then
        damage = xi.additionalEffect.dStatBonus(attacker, defender, dStat, damage)
    end

    --------------------------------------
    -- Additional Effect Damage
    --------------------------------------

    if addType == procType.DAMAGE then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
        msgID  = xi.msg.basic.ADD_EFFECT_DMG

        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage

    --------------------------------------
    -- Additional Effect Damage HP % (Excalibur)
    --------------------------------------

    elseif addType == procType.DAMAGE_HP_PERC then
        local damageType     = attacker:getWeaponDamageType(xi.slot.MAIN)
        local physicalResist = defender:getMod(xi.mod.SLASH_SDT) / 1000
        damage = math.floor(attacker.getHP(attacker) / 4)
        damage = damage * physicalResist
        damage = damage - defender:getMod(xi.mod.PHALANX)
        damage = utils.clamp(damage, 0, 99999)
        damage = utils.stoneskin(defender, damage)
        defender:takeDamage(damage, player, xi.attackType.PHYSCIAL, damageType)

        -- damage = xi.additionalEffect.calcDamagePhys(attacker, element, defender, damage)
        msgID = xi.msg.basic.ADD_EFFECT_DMG

        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage

    elseif addType == procType.DAMAGE_MP_PERC then
        local currentMP = attacker.getMP(attacker)
        damage = math.floor(attacker.getMP(attacker) * 0.15) -- Deals 10% of current MP as damage.
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
        msgID  = xi.msg.basic.ADD_EFFECT_DMG
        attacker:addMP(-(currentMP * 0.05)) -- Drains 5% of current MP on proc.
        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage

        --------------------------------------
        -- Inflicts negative effects vs target
        --------------------------------------
    elseif addType == procType.DEBUFF then
        if addStatus and addStatus > 0 then
            local tick = xi.additionalEffect.statusAttack(addStatus, defender)
            msgID = xi.msg.basic.ADD_EFFECT_STATUS
            defender:addStatusEffect(addStatus, power, tick, duration)
            msgParam = addStatus
        end

        --------------------------------------
        -- Inflicts negative effects vs target (Metasoma Katars)
        --------------------------------------

    elseif addType == procType.POISON_PARALYZE_BIND then
        statusRoll = math.random(1, 3)
        if (statusRoll == 1) then
            addStatus = xi.effect.POISON
            power = 10
        elseif (statusRoll == 2) then
            addStatus = xi.effect.PARALYSIS
            power = 35
        elseif (statusRoll == 3) then
            addStatus = xi.effect.BIND
            power = 30
        end
        local tick = xi.additionalEffect.statusAttack(addStatus, defender)
        msgID = xi.msg.basic.ADD_EFFECT_STATUS
        defender:addStatusEffect(addStatus, power, tick, duration)
        msgParam = addStatus

        --------------------------------------
        -- Recovers user's HP
        --------------------------------------
    elseif addType == procType.HP_HEAL and not attacker:hasStatusEffect(xi.effect.CURSE_II) then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        local hitPoints = damage -- Note: not actually damage, if you wanted damage see HP_DRAIN instead
        -- Unknown what modifies the HP, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_HP_HEAL
        attacker:addHP(hitPoints)
        msgParam = hitPoints

        --------------------------------------
        -- Recovers user's MP
        --------------------------------------
    elseif addType == procType.MP_HEAL and not attacker:hasStatusEffect(xi.effect.CURSE_II) then -- Mjollnir does this, it is not Aspir.
        local magicPoints = damage
        -- Unknown what modifies this, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_MP_HEAL
        attacker:addMP(magicPoints)
        msgParam = magicPoints

        --------------------------------------
        -- Drains HP from target
        --------------------------------------
    elseif (addType == procType.HP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1, 3) == 1)) and not attacker:hasStatusEffect(xi.effect.CURSE_II) then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        -- Upyri: ID 4105
        if defender:isUndead() or defender:getPool() == 4105 then
            return 0
        end

        if damage > defender:getHP() then
            damage = defender:getHP()
        end

        local drainMod = 1 + (attacker:getMod(xi.mod.ENH_DRAIN_ASPIR) + attacker:getMod(xi.mod.ENH_DRAIN)) / 100

        msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
        msgParam = damage * drainMod
        attacker:addHP(damage * drainMod)

        --------------------------------------
        -- Drains MP from target
        --------------------------------------
    elseif (addType == procType.MP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1, 3) == 2)) and not attacker:hasStatusEffect(xi.effect.CURSE_II) then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        if damage > defender:getMP() then
            damage = defender:getMP()
        elseif defender:getMP() == 0 then
            return 0, 0, 0 -- Conditions not hit
        end

        local drainMod = 1 + (attacker:getMod(xi.mod.ENH_DRAIN_ASPIR) + attacker:getMod(xi.mod.ENH_ASPIR)) / 100

        msgID    = xi.msg.basic.ADD_EFFECT_MP_DRAIN
        msgParam = damage * drainMod
        defender:addMP(-damage * drainMod)
        attacker:addMP(damage * drainMod)

        --------------------------------------
        -- Drains TP from target
        --------------------------------------
    elseif addType == procType.TP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1, 3) == 3) then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        if damage > defender:getTP() then
            damage = defender:getTP()
        elseif defender:getTP() == 0 then
            return 0, 0, 0 -- Conditions not hit
        end

        msgID    = xi.msg.basic.ADD_EFFECT_TP_DRAIN
        msgParam = damage
        defender:addTP(-damage)
        attacker:addTP(damage)

        --------------------------------------
        -- Dispels dispelable effects from target
        --------------------------------------
    elseif addType == procType.DISPEL then
        local dispel = defender:dispelStatusEffect()
        -- Resistance check should be in dispelStatusEffect() itself
        if dispel == xi.effect.NONE then
            return 0, 0, 0
        elseif not defender:hasImmunity(xi.immunity.DISPEL) then
            msgID    = xi.msg.basic.ADD_EFFECT_DISPEL
            msgParam = dispel
        else
            return 0, 0, 0
        end

        --------------------------------------
        -- Absorbs status effects from target
        --------------------------------------
    elseif addType == procType.ABSORB_STATUS then
        -- Ripping off Aura Steal here
            local resist = applyResistanceAddEffect(attacker, defender, element, 0)
            if resist > 0.0625 then
                local stolen = attacker:stealStatusEffect(defender)
                if stolen ~= 0 then
                msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
                msgParam = stolen
            else
                return 0, 0, 0 -- Conditions not hit
            end
        end

        --------------------------------------
        -- Buffs that affect the player
        --------------------------------------
    elseif addType == procType.SELF_BUFF then
        if addStatus == xi.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
            -- Does not stack with or replace other shadows
            if
                attacker:hasStatusEffect(xi.effect.BLINK) or
                attacker:hasStatusEffect(xi.effect.COPY_IMAGE)
            then
                return 0, 0, 0
            else
                attacker:addStatusEffect(xi.effect.BLINK, power, 0, duration)
                msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
                msgParam = xi.effect.BLINK
            end
        elseif addStatus == xi.effect.HASTE then
            attacker:addStatusEffect(xi.effect.HASTE, power, 0, duration, 0, 0)
            -- Todo: verify power/duration/tier/overwrite etc
            msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
            msgParam = xi.effect.HASTE
        else
            print('scripts/globals/additional_effects.lua : unhandled additional effect selfbuff! Effect ID: '..addStatus)
        end

        --------------------------------------
        -- Inflicts death
        --------------------------------------
    elseif addType == procType.DEATH then
        if defender:isNM() or defender:isUndead() or -- Todo: DeathRes has no place in the resistance functions so far..
        math.random(1, 100) > defender:getMod(xi.mod.DEATHRES) -- We are checking for a fail, not a success.
        then
            return 0, 0, 0 -- NMs immune or roll failed so return out
        else
            msgID    = xi.msg.basic.ADD_EFFECT_STATUS
            msgParam = xi.effect.KO
            defender:setHP(0)
        end
        --------------------------------------
        -- Special case for Bucc. knife
        --------------------------------------
    elseif addType == procType.BRIGAND then
        if defender:getPool() == 531 and attacker:getEquipID(xi.slot.MAIN) == xi.item.BUCCANEERS_KNIFE then
            defender:setMod(xi.mod.DMG, 0)
            defender:setLocalVar('killable', 1)
            defender:setUnkillable(false)
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
            msgID  = xi.msg.basic.ADD_EFFECT_DMG
            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end
            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

        --------------------------------------
        -- Additional effects vs various super families
        -- Note: This checks a mobs super family to cover all types of
        --       mobs within a family.
        --   Ex: Beast, Lizard, Orc, etc.
        --------------------------------------
    elseif addType == procType.VS_FAMILY then
        if defender:getSuperFamily() == option then
            -- If Drain effect:
            if subEffect == xi.subEffect.HP_DRAIN and not attacker:hasStatusEffect(xi.effect.CURSE_II) then
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

                if damage > defender:getHP() then
                    damage = defender:getHP()
                end

                local drainMod = 1 + (attacker:getMod(xi.mod.ENH_DRAIN_ASPIR) + attacker:getMod(xi.mod.ENH_DRAIN)) / 100

                msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
                msgParam = damage * drainMod
                defender:addHP(-damage * drainMod)
                attacker:addHP(damage * drainMod)

                -- If debuff effect
            elseif addStatus and addStatus > 0 then
                local tick = xi.additionalEffect.statusAttack(addStatus, defender)
                msgID = xi.msg.basic.ADD_EFFECT_STATUS
                defender:addStatusEffect(addStatus, power, tick, duration)
                -- Else damaging effect
            else
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
                msgID  = xi.msg.basic.ADD_EFFECT_DMG

                if damage < 0 then
                    msgID = xi.msg.basic.ADD_EFFECT_HEAL
                end

                msgParam = damage
            end
        else

            --    return 0, 0, 0 -- Conditions not hit
        end

        --------------------------------------
        -- Additional effects trigger when specific avatar is summoned in party.
        -- Option is used to determine the specific avatar required to trigger.
        -- This ID reads from pets.lua (xi.pet.id)
        --------------------------------------
    elseif addType == procType.AVATAR_SUMMONED then
        local flag = false

        for _, member in pairs(attacker:getParty()) do
            if member:getPet() ~= nil and member:getPetID() == option then
                flag = true
            end
        end

        if flag then
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
            msgID  = xi.msg.basic.ADD_EFFECT_DMG

            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end

            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

        --------------------------------------
        -- Triggers at night
        --------------------------------------
    elseif addType == procType.NIGHTTIME then
        local time = VanadielHour()

        if time >= 20 and time <= 4 then
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
            msgID  = xi.msg.basic.ADD_EFFECT_DMG

            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end

            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

        --------------------------------------
        -- Throwables towards Gods in sky to
        -- dispel their en-effect
        --------------------------------------
    elseif addType == procType.GOD_WIND then
        if defender:getFamily() == option then
            defender:setMobMod(xi.mobMod.ADD_EFFECT, 0)
        else
            return 0, 0, 0 -- Conditions not hit
        end

        --------------------------------------
        -- Additional effects vs various family ecosystems
        -- Note: This checks a mob's ecosystem to cover all types of
        --       mobs within an ecosystem.
        --   Ex: Plantoid, Beast, Aquatic
        --------------------------------------
    elseif addType == procType.VS_ECOSYSTEM then
        if defender:getEcosystem() == option then
            -- If Drain effect:
            if subEffect == xi.subEffect.HP_DRAIN and not attacker:hasStatusEffect(xi.effect.CURSE_II) then
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

                if damage > defender:getHP() then
                    damage = defender:getHP()
                end

                local drainMod = 1 + (attacker:getMod(xi.mod.ENH_DRAIN_ASPIR) + attacker:getMod(xi.mod.ENH_DRAIN)) / 100

                msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
                msgParam = damage * drainMod
                defender:addHP(-damage* drainMod)
                attacker:addHP(damage * drainMod)

                -- If Debuff effect:
            elseif addStatus and addStatus > 0 then
                local tick = xi.additionalEffect.statusAttack(addStatus, defender)
                msgID = xi.msg.basic.ADD_EFFECT_STATUS
                defender:addStatusEffect(addStatus, power, tick, duration)
                -- Else damaging effect
            else
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
                msgID  = xi.msg.basic.ADD_EFFECT_DMG
                --print('VS ECOSYSTEM DMG PASSED')
                if damage < 0 then
                    msgID = xi.msg.basic.ADD_EFFECT_HEAL
                end

                msgParam = damage
            end
        else
            --print('Vs Ecosystem condition Not passed, bailing')
            return 0, 0, 0 -- Conditions not hit
        end
    end

    --[[
    if msgID == nil then
        print('Additional effect has a nil msgID !!')
    elseif msgParam == nil then
        print('Additional effect has a nil msgParam !!')
    end
    print('subEffect: '..subEffect..' msgID: '..msgID..' msgParam: '..msgParam)
    ]]
    return subEffect, msgID, msgParam
end

xi.additionalEffect.spikes = function(attacker, defender, damage, spikeEffect, power, chance)
    --[[ Todo..
    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
    }
    ]]
end
