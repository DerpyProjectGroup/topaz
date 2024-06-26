-----------------------------------
-- Contains all common weaponskill calculations including but not limited to:
-- fSTR
-- Alpha
-- Ratio -> cRatio
-- min/max cRatio
-- applications of fTP
-- applications of critical hits ('Critical hit rate varies with TP.')
-- applications of accuracy mods ('Accuracy varies with TP.')
-- applications of damage mods ('Damage varies with TP.')
-- performance of the actual WS (rand numbers, etc)
-----------------------------------
require('scripts/globals/magicburst')
require('scripts/globals/ability')
require('scripts/globals/magic')
require('scripts/globals/utils')
require('scripts/globals/combat/physical_utilities')
-----------------------------------
xi = xi or {}
xi.weaponskills = xi.weaponskills or {}

-- Obtains alpha, used for working out WSC on legacy servers
-- Retail has no alpha anymore as of 2014 Weaponskill functions
local function getAlpha(level)
    local alpha = 1

    if not xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        if level > 75 then
            alpha = 0.85
        elseif level > 59 then
            alpha = 0.9 - math.floor((level - 60) / 2) / 100
        elseif level > 5 then
            alpha = 1 - math.floor(level / 6) / 100
        end
    end

    return alpha
end

-- Returns fSTR based on range and divisor
local function calculateRawFstr(dSTR, divisor)
    local fSTR = 0

    if dSTR >= 12 then
        fSTR = dSTR + 4
    elseif dSTR >= 6 then
        fSTR = dSTR + 6
    elseif dSTR >= 1 then
        fSTR = dSTR + 7
    elseif dSTR >= -2 then
        fSTR = dSTR + 8
    elseif dSTR >= -7 then
        fSTR = dSTR + 9
    elseif dSTR >= -15 then
        fSTR = dSTR + 10
    elseif dSTR >= -21 then
        fSTR = dSTR + 12
    else
        fSTR = dSTR + 13
    end

    return fSTR / divisor
end

-- Given the attacker's str and the mob's vit, fSTR2 is calculated (for ranged WS)
xi.weaponskills.fSTR2 = function(atkStr, defVit, weaponRank)
    local dSTR  = atkStr - defVit
    local fSTR2 = calculateRawFstr(dSTR, 2)

    -- Apply fSTR2 caps.
    local lowerCap = weaponRank * -2

    if weaponRank == 0 then
        lowerCap = -2
    elseif weaponRank == 1 then
        lowerCap = -3
    end

    fSTR2 = utils.clamp(fSTR2, lowerCap, (weaponRank + 8) * 2)

    return fSTR2
end

-- http://wiki.ffo.jp/html/1705.html
-- https://www.ffxiah.com/forum/topic/21497/stalwart-soul/ some anecdotal data that aligns with JP
-- https://www.bg-wiki.com/ffxi/Agwu%27s_Scythe Souleater Effect that goes beyond established cap, Stalwart Soul bonus being additive to trait
local function souleaterBonus(attacker, wsParams)
    if attacker:hasStatusEffect(xi.effect.SOULEATER) then
        local souleaterEffect   = attacker:getMaxGearMod(xi.mod.SOULEATER_EFFECT) / 100
        local souleaterEffectII = attacker:getMod(xi.mod.SOULEATER_EFFECT_II) / 100
        local stalwartSoulBonus = 1 - attacker:getMod(xi.mod.STALWART_SOUL) / 100
        local bonusDamage       = math.floor(attacker:getHP() * (0.1 + souleaterEffect + souleaterEffectII))

        if bonusDamage >= 1 then
            attacker:delHP(utils.stoneskin(attacker, bonusDamage * stalwartSoulBonus))

            --[[if attacker:getMainJob() ~= xi.job.DRK then
                return math.floor(bonusDamage / 2)
            end]]

            return bonusDamage
        end
    end

    return 0
end

xi.weaponskills.scarletDeliriumBonus = function(attacker)
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.SCARLET_DELIRIUM_1) then
        local power = attacker:getStatusEffect(xi.effect.SCARLET_DELIRIUM_1):getPower()

        bonus = 1 + power / 100
    end

    return bonus
end

xi.weaponskills.consumeManaBonusPhysical = function(attacker, wsParams) -- For Physical Weaponskills.
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        local MPConsumption = attacker:getMP() * 0.05 -- MP Consumed.
        local weaponDamage  = attacker:getWeaponDmg() -- Get damage of weapon in main slot.
        local power = ((100 + (MPConsumption)) / 100) -- Damage Modifier based on MP consumed.
        attacker:delMP(MPConsumption)                 -- Delete MP from player
        bonus = weaponDamage * power                  -- Weapon Damage * Modifier
        -- attacker:printToPlayer(string.format('Weapon Damage: %s', bonus), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
    end

    return bonus
end

xi.weaponskills.consumeManaBonusWeaponDamage = function(attacker, wsParams) -- For modifying a weapon's base damage. Used for Physical Weaponskills.
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        local MPConsumption = attacker:getMP() * 0.05 -- MP Consumed.
        local power = ((100 + (MPConsumption)) / 100) -- Damage Modifier based on MP consumed.
        bonus = power                                 -- Weapon Damage * Bonus
          -- attacker:printToPlayer(string.format('Weapon Damage: %s', bonus), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
    end

    return bonus
end

xi.weaponskills.consumeManaBonusMPConsumption = function(attacker, hitsDone) -- Procs MP Consumption for Physical Weaponskills.
    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        for i = 1, hitsDone do
            local MPConsumption = attacker:getMP() * 0.25 -- MP Consumed.
            attacker:delMP(MPConsumption)                 -- Delete MP from player
        end
    end

    return 0
end

xi.weaponskills.consumeManaBonusMagical = function(attacker, wsParams) -- For Magic Weaponskills.
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        local MPConsumption = attacker:getMP() * 0.25 -- MP Consumed.
        local power = ((100 + (MPConsumption)) / 100) -- Damage Modifier based on MP consumed.
        attacker:delMP(MPConsumption)  
        bonus = power                                 -- Final power to apply to weaponskill.
    end

    return bonus
end

xi.weaponskills.consumeManaBonusHybrid = function(attacker, wsParams) -- For Magic Portion of Hybrid Weaponskills.
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        local MPConsumption = attacker:getMP() * 0.25 -- MP Consumed.
        local power = ((100 + (MPConsumption)) / 100) -- Damage Modifier based on MP consumed.
        bonus = power                                 -- Final power to apply to weaponskill.
    end

    return bonus
end

local function shadowAbsorb(target)
    local targetShadows = target:getMod(xi.mod.UTSUSEMI)
    local shadowType    = xi.mod.UTSUSEMI

    if targetShadows == 0 then
        if math.random(1, 100) <= 80 then
            targetShadows = target:getMod(xi.mod.BLINK)
            shadowType    = xi.mod.BLINK
        end
    end

    if targetShadows > 0 then
        targetShadows = targetShadows - 1

        if shadowType == xi.mod.UTSUSEMI then
            local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
            if effect then
                if targetShadows == 1 then
                    effect:setIcon(xi.effect.COPY_IMAGE)
                elseif targetShadows == 2 then
                    effect:setIcon(xi.effect.COPY_IMAGE_2)
                elseif targetShadows == 3 then
                    effect:setIcon(xi.effect.COPY_IMAGE_3)
                end
            end
        end

        target:setMod(shadowType, targetShadows)
        if targetShadows == 0 then
            target:delStatusEffect(xi.effect.COPY_IMAGE)
            target:delStatusEffect(xi.effect.BLINK)
        end

        return true
    end

    return false
end

local function getMultiAttacks(attacker, target, wsParams, firstHit, offHand)
    local numHits      = 0
    local bonusHits    = 0
    local doubleRate   = attacker:getMod(xi.mod.DOUBLE_ATTACK) + attacker:getMerit(xi.merit.DOUBLE_ATTACK_RATE)
    local tripleRate   = attacker:getMod(xi.mod.TRIPLE_ATTACK) + attacker:getMerit(xi.merit.TRIPLE_ATTACK_RATE)
    local quadRate     = attacker:getMod(xi.mod.QUAD_ATTACK)
    local oaThriceRate = attacker:getMod(xi.mod.MYTHIC_OCC_ATT_THRICE)
    local oaTwiceRate  = attacker:getMod(xi.mod.MYTHIC_OCC_ATT_TWICE)
    local isJump       = wsParams.isJump or false

    if isJump then
        doubleRate = doubleRate + attacker:getMod(xi.mod.JUMP_DOUBLE_ATTACK)
    end

    -- TODO: Assasin vest +2 Ambush augment.
    -- The logic here wasnt actually checking for the augment.
    -- Also, it was in a completely different scale, making triple attack trigger always.

    if math.random(1, 100) <= quadRate then
        bonusHits = bonusHits + 3
    elseif math.random(1, 100) <= tripleRate then
        bonusHits = bonusHits + 2
    elseif math.random(1, 100) <= doubleRate then
        bonusHits = bonusHits + 1
    elseif firstHit and math.random(1, 100) <= oaThriceRate then -- Can only proc on first hit
        bonusHits = bonusHits + 2
    elseif firstHit and math.random(1, 100) <= oaTwiceRate then -- Can only proc on first hit
        bonusHits = bonusHits + 1
    end

    attacker:delStatusEffect(xi.effect.ASSASSINS_CHARGE)
    attacker:delStatusEffect(xi.effect.WARRIORS_CHARGE)

    -- Try OaX for Jumps
    -- ... What's the correct dual wield interaction?
    if isJump and bonusHits == 0 and attacker:isPC() then
        -- getWeaponHitCount will always return 1 if there's a weapon in the slot, which is already accounted for.
        if offHand then
            bonusHits = attacker:getWeaponHitCount(true) - 1
        else
            bonusHits = attacker:getWeaponHitCount(false) - 1
        end
    end

    numHits = numHits + bonusHits

    return numHits
end

local function cRangedRatio(attacker, defender, params, ignoredDef, tp)
    local atkMultiplier   = xi.weaponskills.fTP(tp, params.atkVaries)
    local cratio          = attacker:getRATT() / (defender:getStat(xi.mod.DEF) - ignoredDef)
    local levelCorrection = 0

    if attacker:getMainLvl() < defender:getMainLvl() then
        levelCorrection = (defender:getMainLvl() - attacker:getMainLvl()) / 40
    end

    if attacker:hasStatusEffect(xi.effect.FLASHY_SHOT) then
        levelCorrection = 0
    end

    cratio = (cratio - levelCorrection) * atkMultiplier

    -- adding cap check base on weapon https://www.bg-wiki.com/ffxi/PDIF info
    local damageLimitPlus = attacker:getMod(xi.mod.DAMAGE_LIMIT) / 100
    local damageLimitPercent = (100 + attacker:getMod(xi.mod.DAMAGE_LIMITP)) / 100
    local weaponType = attacker:getWeaponSkillType(xi.slot.RANGED)
    local cRatioCap  = 3.25 -- Archery

    if weaponType == xi.skill.MARKSMANSHIP then
        cRatioCap = 3.5
    end

    cRatioCap = (cRatioCap + damageLimitPlus) * damageLimitPercent -- Damage Limit calc

    cratio = utils.clamp(cratio, 0, cRatioCap)

    -- max
    local pdifmax = cratio

    if cratio < 0.9 then
        pdifmax = cratio * 10 / 9
    elseif cratio < 1.1 then
        pdifmax = 1
    end

    -- min
    local pdifmin = 0

    if cratio < 0.9 then
        pdifmin = cratio
    elseif cratio < 1.1 then
        pdifmin = 1
    else
        pdifmin = cratio * 20 / 19 - 3 / 19
    end

    local pdif     = { pdifmin, pdifmax }
    local pdifcrit = { pdifmin * 1.25, pdifmax * 1.25 }

    return pdif, pdifcrit
end

local function getRangedHitRate(attacker, target, bonus)
    local acc = attacker:getRACC()
    local eva = target:getEVA() + target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    if bonus == nil then
        bonus = 0
    end

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        target:isFacing(attacker, 23)
    then
        -- Yonin evasion boost if defender is facing attacker
        bonus = bonus - target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    if attacker:hasTrait(xi.trait.AMBUSH) and attacker:isBehind(target, 23) then
        bonus = bonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    acc = acc + bonus

    if attacker:getMainLvl() > target:getMainLvl() then -- acc bonus
        acc = acc + (attacker:getMainLvl() - target:getMainLvl()) * 2
    elseif attacker:getMainLvl() < target:getMainLvl() then -- acc penalty
        acc = acc - (target:getMainLvl() - attacker:getMainLvl()) * 1.5
    end

    local hitdiff = (acc - eva) / 2 -- no need to check if eva is hier or lower than acc it will be negative if eva is higher and positive if acc is higher
    local hitrate = (75 + hitdiff) / 100

    -- Applying hitrate caps
    hitrate = utils.clamp(hitrate, 0.2, 0.98)
    --print(hitrate)
    return hitrate
end

-- Function to calculate if a hit in a WS misses, criticals, and the respective damage done
local function getSingleHitDamage(attacker, target, dmg, ftp, wsParams, calcParams)
    local criticalHit = false
    local finaldmg    = 0
    -- local pdif = 0 Reminder for Future Implementation!

    -- priority order of checks
    -- evade > parry > shadow/blink > guard/block

    -- check evasion
    local missChance = math.random()
    if
        (missChance > calcParams.hitRate and
        not calcParams.guaranteedHit) or
        calcParams.mustMiss
    then
        -- miss logic
        return finaldmg, calcParams
    end

    -- check parry
    if
        calcParams.attackType == xi.attackType.PHYSICAL and
        not calcParams.guaranteedHit and
        xi.combat.physical.isParried(target, attacker)
    then
        local hitsParried          = attacker:getLocalVar('[attacksParried]')
        attacker:setLocalVar('[attacksParried]', hitsParried + 1)
        -- parried logic
        return finaldmg, calcParams
    end

    -- check shadows
    if
        not calcParams.guaranteedHit and
        shadowAbsorb(target)
    then
        -- shadow absorb logic
        calcParams.shadowsAbsorbed = calcParams.shadowsAbsorbed + 1
        return finaldmg, calcParams
    end

    -- check guard
    if
        calcParams.attackType == xi.attackType.PHYSICAL and
        not calcParams.guaranteedHit and
        xi.combat.physical.isGuarded(target, attacker)
    then
        local hitsGuarded          = attacker:getLocalVar('[attacksGuarded]')
        attacker:setLocalVar('[attacksGuarded]', hitsGuarded + 1)
        -- guarded logic
        return finaldmg, calcParams
    end

    local critChance = math.random() -- See if we land a critical hit
    criticalHit = (wsParams.critVaries and critChance <= calcParams.critRate) or
        calcParams.forcedFirstCrit or
        calcParams.mightyStrikesApplicable

    if criticalHit then
        calcParams.criticalHit = true
        -- attacker:printToArea(string.format('%s\'s weapon skill scores a critical hit!', attacker:getName()), xi.msg.channel.SYSTEM_3, 1)
        calcParams.pdif = xi.weaponskills.generatePdif(calcParams.ccritratio[1], calcParams.ccritratio[2], true)
        local criticalHitsLanded          = attacker:getLocalVar('[criticalHitsLanded]')
        local criticalHitsLandedIncrement = 0
        attacker:setLocalVar('[criticalHitsLanded]', criticalHitsLanded + 1)
    else
        calcParams.pdif = xi.weaponskills.generatePdif(calcParams.cratio[1], calcParams.cratio[2], true)
        -- calcParams.pdif = xi.combat.physical.calculateMeleePDIF(attacker, target, xi.skill.GREAT_AXE, 1, isCritical, applyLevelCorrection, false, ftp, true, xi.slot.MAIN)
    end

    -- finaldmg = (dmg + consumeManaBonus(attacker)) * ftp * calcParams.pdif
    finaldmg = dmg * ftp * calcParams.pdif

    -- handle blocking
    finaldmg = xi.combat.physical.handleBlock(target, attacker, finaldmg)

    calcParams.hitsLanded = calcParams.hitsLanded + 1

    return finaldmg, calcParams
end

local function modifyMeleeHitDamage(attacker, target, attackTbl, wsParams, rawDamage)
    local adjustedDamage = rawDamage

    if not wsParams.formless then
        adjustedDamage = target:physicalDmgTaken(adjustedDamage, attackTbl.damageType)

        if attackTbl.weaponType == xi.skill.HAND_TO_HAND then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.HTH_SDT) / 1000
        elseif
            attackTbl.damageType == xi.damageType.PIERCING
            -- attackTbl.weaponType == xi.skill.DAGGER or
            -- attackTbl.weaponType == xi.skill.POLEARM
        then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.PIERCE_SDT) / 1000
        elseif
            attackTbl.damageType == xi.damageType.BLUNT
            -- attackTbl.weaponType == xi.skill.CLUB or
            -- attackTbl.weaponType == xi.skill.STAFF
        then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.IMPACT_SDT) / 1000
        else
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.SLASH_SDT) / 1000
        end
    end

    -- Scarlet Delirium
    adjustedDamage = adjustedDamage * xi.weaponskills.scarletDeliriumBonus(attacker)

    -- Souleater
    adjustedDamage = adjustedDamage + souleaterBonus(attacker, wsParams)

    if adjustedDamage > 0 then
        adjustedDamage = adjustedDamage - target:getMod(xi.mod.PHALANX)
        adjustedDamage = utils.clamp(adjustedDamage, 0, 99999)
    end

    adjustedDamage = utils.stoneskin(target, adjustedDamage)

    return adjustedDamage
end

local modParameters =
{
    ['str_wsc'] = { xi.mod.STR, xi.mod.WS_STR_BONUS },
    ['dex_wsc'] = { xi.mod.DEX, xi.mod.WS_DEX_BONUS },
    ['vit_wsc'] = { xi.mod.VIT, xi.mod.WS_VIT_BONUS },
    ['agi_wsc'] = { xi.mod.AGI, xi.mod.WS_AGI_BONUS },
    ['int_wsc'] = { xi.mod.INT, xi.mod.WS_INT_BONUS },
    ['mnd_wsc'] = { xi.mod.MND, xi.mod.WS_MND_BONUS },
    ['chr_wsc'] = { xi.mod.CHR, xi.mod.WS_CHR_BONUS },
}

local function calculateWsMods(attacker, calcParams, wsParams)
    local wsMods = 0

    for parameterName, modList in pairs(modParameters) do
        local paramValue = wsParams[parameterName] and wsParams[parameterName] or 0

        wsMods = wsMods + attacker:getStat(modList[1]) * paramValue
    end

    return wsMods * calcParams.alpha + calcParams.fSTR
end

-- Compute magic damage component of hybrid weaponskill
-- https://wiki.ffo.jp/html/1261.html
-- https://www.ffxiah.com/forum/topic/33470/the-sealed-dagger-a-ninja-guide/151/#3420836
-- https://www.ffxiah.com/forum/topic/49614/blade-chi-damage-formula/2/#3171538
local function calculateHybridMagicDamage(tp, physicaldmg, attacker, target, wsParams, calcParams, wsID)
    local ftp = xi.weaponskills.fTP(tp, wsParams.ftpMod)
    local magicdmg = physicaldmg * ftp + attacker:getMod(xi.mod.MAGIC_DAMAGE)
    local wsd = attacker:getMod(xi.mod.ALL_WSDMG_ALL_HITS)
    if attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        wsd = wsd + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
    end
    magicdmg = magicdmg * (100 + wsd) / 100
    magicdmg = addBonusesAbilityWeaponSkill(attacker, wsParams.ele, target, magicdmg, wsParams)
    magicdmg = magicdmg + calcParams.bonusfTP * physicaldmg
    magicdmg = magicdmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, calcParams.bonusAcc)
    magicdmg = target:magicDmgTaken(magicdmg, wsParams.ele)

    if magicdmg > 0 then
        magicdmg = adjustForTarget(target, magicdmg, wsParams.ele) -- this may absorb or nullify
    end

    if magicdmg > 0 then                                           -- handle nonzero damage if previous function does not absorb or nullify
        magicdmg = magicdmg - target:getMod(xi.mod.PHALANX)
        magicdmg = utils.clamp(magicdmg, 0, 99999)
        magicdmg = utils.oneforall(target, magicdmg)
        magicdmg = utils.stoneskin(target, magicdmg)
    end

    -- Apply Consume Mana
    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        magicdmg = (magicdmg * (xi.weaponskills.consumeManaBonusHybrid(attacker, wsParams)))
        attacker:delStatusEffect(xi.effect.CONSUME_MANA)
    end
        
    -- Divine/Elemental Seal Bonus

    local magicseal = 1
    if wsParams.ele ~= nil and wsParams.ele ~= xi.element.LIGHT and (attacker:hasStatusEffect(xi.effect.ELEMENTAL_SEAL)) then
        magicseal = math.floor(math.random(265,275) / 100)
        attacker:delStatusEffect(xi.effect.ELEMENTAL_SEAL)
    elseif wsParams.ele ~= nil and wsParams.ele == xi.element.LIGHT and (attacker:hasStatusEffect(xi.effect.DIVINE_SEAL)) then
        magicseal = math.floor(math.random(265,275) / 100)
        attacker:delStatusEffect(xi.effect.DIVINE_SEAL)
    end

    magicdmg = (magicdmg * magicseal)

    return magicdmg
end

-- Calculates the raw damage for a weaponskill, used by both xi.weaponskills.doPhysicalWeaponskill and xi.weaponskills.doRangedWeaponskill.
-- Behavior of damage calculations can vary based on the passed in calcParams, which are determined by the calling function
-- depending on the type of weaponskill being done, and any special cases for that weaponskill
--
-- wsParams can contain: ftpMod, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, critVaries,
-- accVaries, ignoredDefense, atkVaries, kick, hybridWS, hitsHigh, formless
--
-- See xi.weaponskills.doPhysicalWeaponskill or xi.weaponskills.doRangedWeaponskill for how calcParams are determined.

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.weaponskills.calculateRawWSDmg = function(attacker, target, wsID, tp, action, wsParams, calcParams)
    local targetLvl = target:getMainLvl()
    local targetHp  = target:getHP() + target:getMod(xi.mod.STONESKIN)

    -- Calculate alpha, WSC, and our modifiers for our base per-hit damage
    calcParams.alpha = getAlpha(attacker:getMainLvl())

    -- Begin Checks for bonus wsc bonuses. See the following for details:
    -- https://www.bg-wiki.com/bg/Utu_Grip
    -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

    for parameterName, modList in pairs(modParameters) do
        if attacker:getMod(modList[2]) > 0 then
            wsParams[parameterName] = wsParams[parameterName] + (attacker:getMod(modList[2]) / 100)
        end
    end

    local wsMods   = calculateWsMods(attacker, calcParams, wsParams)
    local mainBase = calcParams.weaponDamage[1] + wsMods + calcParams.bonusWSmods

    -- Calculate fTP multiplier
    local ftp = xi.weaponskills.fTP(tp, wsParams.ftpMod) + calcParams.bonusfTP
    if calcParams.hybridHit then
        ftp = 1 + calcParams.bonusfTP
    end
    -- Calculate critrates
    -- TODO: calc per-hit with weapon crit+% on each hand (if dual wielding)
    calcParams.critRate = 0
    if wsParams.critVaries then -- Work out critical hit ratios
        calcParams.critRate = xi.combat.physical.calculateSwingCriticalRate(attacker, target, tp, wsParams.critVaries)
    end

    -- Start the WS
    local hitsDone                = 1
    local hitdmg                  = 0
    local finaldmg                = 0
    local mainhandTPGain          = xi.combat.tp.getSingleWeaponTPReturn(attacker, xi.slot.MAIN)
    local subTPGain               = xi.combat.tp.getSingleWeaponTPReturn(attacker, xi.slot.SUB)
    local isJump                  = wsParams.isJump or false
    local attackerTPMult          = wsParams.attackerTPMult or 1
    calcParams.hitsLanded         = 0
    calcParams.shadowsAbsorbed    = 0
    calcParams.mainhandHitsLanded = 0
    calcParams.offhandHitsLanded  = 0

    -- Calculate the damage from the first hit
    if
        not isJump and
        calcParams.firstHitRate
    then
        calcParams.origHitRate = calcParams.hitRate
        calcParams.hitRate = calcParams.firstHitRate
    end

    local dmg = mainBase
    hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, ftp, wsParams, calcParams)

    if
        not isJump and
        calcParams.origHitRate
    then
        calcParams.hitRate = calcParams.origHitRate
    end

    if calcParams.melee then
        hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
    end

    if calcParams.skillType and hitdmg > 0 then
        attacker:trySkillUp(calcParams.skillType, targetLvl)

        if isJump then
            attacker:addTP(mainhandTPGain * attackerTPMult)
        end
    end

    finaldmg = finaldmg + hitdmg

    calcParams.tpHitsLanded   = calcParams.hitsLanded -- Store number of TP hits that have landed thus far
    calcParams.mainHitsLanded = calcParams.tpHitsLanded
    -- Finish first/mainhand hit

    local numMainHandMultis = getMultiAttacks(attacker, target, wsParams, true, false)
    local numOffhandMultis  = 0
    local numMultiProcs     = numMainHandMultis > 0 and 1 or 0

    -- Have to calculate added bonus for SA/TA here since it is done outside of the fTP multiplier
    if (attacker:getMainJob() == xi.job.THF or attacker:getSubJob() == xi.job.THF) then
        -- Add DEX/AGI bonus to first hit if THF main and valid Sneak/Trick Attack
        if calcParams.sneakApplicable then
            finaldmg = finaldmg + calcParams.pdif * attacker:getStat(xi.mod.DEX) * (1 + attacker:getMod(xi.mod.SNEAK_ATK_DEX) / 100) * (1 + attacker:getMod(xi.mod.AUGMENTS_SA) / 100)
            if calcParams.pdif == nil then
                print(attacker:getName())
                print('PDIF returned nil')
            end
        end

        if calcParams.trickApplicable then
            finaldmg = finaldmg + calcParams.pdif * attacker:getStat(xi.mod.AGI) * (1 + attacker:getMod(xi.mod.TRICK_ATK_AGI) / 100) * (1 + attacker:getMod(xi.mod.AUGMENTS_TA) / 100)
            if calcParams.pdif == nil then
                print(attacker:getName())
                print('PDIF returned nil')
            end
        end
    end

    -- We've now accounted for any crit from SA/TA, so nullify them
    calcParams.forcedFirstCrit = false

    -- For items that apply bonus damage to the first hit of a weaponskill (but not later hits),
    -- store bonus damage for first hit, for use after other calculations are done
    local firstHitBonus = finaldmg * attacker:getMod(xi.mod.ALL_WSDMG_FIRST_HIT) / 100

    -- Reset fTP if it's not supposed to carry over across all hits for this WS
    -- We'll recalculate our mainhand damage after doing offhand
    if not wsParams.multiHitfTP then
        ftp = 1
    end

    local offhandSkill = attacker:getWeaponSkillType(xi.slot.SUB)
    if calcParams.skillType == xi.skill.HAND_TO_HAND then
        offhandSkill = xi.skill.HAND_TO_HAND
        subTPGain    = mainhandTPGain
    end

    -- Do the extra hit for our offhand if applicable
    if calcParams.extraOffhandHit and finaldmg < targetHp then
        calcParams.hitsLanded = 0
        local offhandDmg      = calcParams.weaponDamage[2] + wsMods
        hitdmg, calcParams    = getSingleHitDamage(attacker, target, offhandDmg, ftp, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(offhandSkill, targetLvl)

            if isJump then
                attacker:addTP(subTPGain * attackerTPMult)
            end
        end

        finaldmg = finaldmg + hitdmg
        hitsDone = hitsDone + 1

        calcParams.tpHitsLanded      = calcParams.tpHitsLanded + calcParams.hitsLanded
        calcParams.offhandHitsLanded = calcParams.hitsLanded

        numOffhandMultis = getMultiAttacks(attacker, target, wsParams, false, true)
        numMultiProcs    = numOffhandMultis > 0 and numMultiProcs + 1 or numMultiProcs
    end

    calcParams.guaranteedHit = false -- Accuracy bonus from SA/TA applies only to first main and offhand hit

    dmg = mainBase

    -- First mainhand hit is already accounted for
    local mainhandHits     = wsParams.numHits - 1
    local mainhandHitsDone = 0

    -- Use up any remaining hits in the WS's numhits
    while hitsDone < 8 and mainhandHitsDone < mainhandHits and finaldmg < targetHp do
        calcParams.hitsLanded = 0
        hitdmg, calcParams    = getSingleHitDamage(attacker, target, dmg, ftp, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(calcParams.skillType, targetLvl)

            if isJump then
                attacker:addTP(mainhandTPGain * attackerTPMult)
            end
        end

        finaldmg                  = finaldmg + hitdmg
        hitsDone                  = hitsDone + 1
        mainhandHitsDone          = mainhandHitsDone + 1
        calcParams.mainHitsLanded = calcParams.mainHitsLanded + calcParams.hitsLanded

        -- Check each hit for multis, but stop after we get 2 multi procs
        if numMultiProcs < 2 then
            local extraMultis = getMultiAttacks(attacker, target, wsParams, false, false)
            numMainHandMultis = numMainHandMultis + extraMultis
            numMultiProcs     = extraMultis > 0 and numMultiProcs + 1 or numMultiProcs
        end
    end

    -- Proc any mainhand multi attacks.
    local mainhandMultiHitsDone = 0

    while hitsDone < 8 and mainhandMultiHitsDone < numMainHandMultis and finaldmg < targetHp do
        calcParams.hitsLanded = 0
        hitdmg, calcParams    = getSingleHitDamage(attacker, target, dmg, ftp, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(calcParams.skillType, targetLvl)

            if isJump then
                attacker:addTP(mainhandTPGain * attackerTPMult)
            end
        end

        finaldmg                  = finaldmg + hitdmg
        hitsDone                  = hitsDone + 1
        mainhandMultiHitsDone     = mainhandMultiHitsDone + 1
        calcParams.mainHitsLanded = calcParams.mainHitsLanded + calcParams.hitsLanded
    end

    -- Proc any offhand multi attacks.
    local offhandMultiHitsDone = 0
    while hitsDone < 8 and offhandMultiHitsDone < numOffhandMultis and finaldmg < targetHp do
        local offhandDmg      = calcParams.weaponDamage[2] + wsMods
        calcParams.hitsLanded = 0
        hitdmg, calcParams    = getSingleHitDamage(attacker, target, offhandDmg, ftp, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(offhandSkill, targetLvl)

            if isJump then
                attacker:addTP(subTPGain * attackerTPMult)
            end
        end

        finaldmg                     = finaldmg + hitdmg
        hitsDone                     = hitsDone + 1
        offhandMultiHitsDone         = offhandMultiHitsDone + 1
        calcParams.offhandHitsLanded = calcParams.offhandHitsLanded + calcParams.hitsLanded
    end

    calcParams.extraHitsLanded = calcParams.mainHitsLanded + calcParams.offhandHitsLanded

    -- Remove the TP hit landed from the count if it did -- otherwise we would gain extra TP
    if calcParams.tpHitsLanded > 1 then
        calcParams.extraHitsLanded = calcParams.extraHitsLanded - 1
    end

    -- Handle Consume Mana MP Consumption. Applies to every hit landed.
    xi.weaponskills.consumeManaBonusMPConsumption(attacker, wsParams.numHits)

    -- Factor in "all hits" bonus damage mods
    -- TODO: does this apply to every hit of a multi hit WS as it's coming in to account for potentially excess damage here?
    local bonusdmg = 0

    if not isJump then
        bonusdmg = attacker:getMod(xi.mod.ALL_WSDMG_ALL_HITS) -- For any WS

        if
            attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 and
            not attacker:isPet()
        then
            -- For specific WS
            bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
        end

        finaldmg = finaldmg * (100 + bonusdmg) / 100 -- Apply our "all hits" WS dmg bonuses
        finaldmg = finaldmg + firstHitBonus -- Finally add in our "first hit" WS dmg bonus from before
    end

    -- Return our raw damage to then be modified by enemy reductions based off of melee/ranged
    calcParams.finalDmg = finaldmg

    return calcParams
end

-- Sets up the necessary calcParams for a melee WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to xi.weaponskills.takeWeaponskillDamage.
xi.weaponskills.doPhysicalWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg, taChar)
    -- Determine cratio and ccritratio
    local ignoredDef         = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignoredDefense)
    local cratio, ccritratio = xi.weaponskills.cMeleeRatio(attacker, target, wsParams, ignoredDef, tp)

    -- Set up conditions and wsParams used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = xi.weaponskills.handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type']       = xi.attackType.PHYSICAL,
        ['slot']       = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.MAIN)
    }

    local calcParams = {}
    calcParams.wsID                    = wsID
    calcParams.attackInfo              = attack
    calcParams.weaponDamage            = xi.weaponskills.getMeleeDmg(attacker, attack.weaponType, wsParams.kick)
    calcParams.fSTR                    = xi.weaponskills.fSTR(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getWeaponDmgRank())
    calcParams.cratio                  = cratio
    calcParams.ccritratio              = ccritratio
    calcParams.accStat                 = attacker:getACC()
    calcParams.melee                   = true
    calcParams.mustMiss                = target:hasStatusEffect(xi.effect.PERFECT_DODGE) or (target:hasStatusEffect(xi.effect.ALL_MISS) and not wsParams.hitsHigh)
    calcParams.sneakApplicable         = attacker:hasStatusEffect(xi.effect.SNEAK_ATTACK) and (attacker:isBehind(target) or attacker:hasStatusEffect(xi.effect.HIDE) or target:hasStatusEffect(xi.effect.DOUBT))
    calcParams.taChar                  = taChar
    calcParams.trickApplicable         = calcParams.taChar ~= nil
    calcParams.assassinApplicable      = calcParams.trickApplicable and attacker:hasTrait(xi.trait.ASSASSIN)
    calcParams.guaranteedHit           = calcParams.sneakApplicable or calcParams.trickApplicable
    calcParams.mightyStrikesApplicable = attacker:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    calcParams.forcedFirstCrit         = calcParams.sneakApplicable or calcParams.assassinApplicable
    calcParams.extraOffhandHit         = attacker:isDualWielding() or attack.weaponType == xi.skill.HAND_TO_HAND
    calcParams.hybridHit               = wsParams.hybridWS
    calcParams.flourishEffect          = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)
    calcParams.bonusTP                 = wsParams.bonusTP or 0
    calcParams.attackType              = xi.attackType.PHYSICAL

    local isJump = wsParams.isJump or false
    if isJump then
        calcParams.bonusfTP    = 0
        calcParams.bonusAcc    = attacker:getMod(xi.mod.JUMP_ACC_BONUS)
        calcParams.bonusWSmods = 0
    else
        calcParams.bonusfTP    = gorgetBeltFTP or 0
        calcParams.bonusAcc    = (gorgetBeltAcc or 0) + attacker:getMod(xi.mod.WSACC)
        calcParams.bonusWSmods = wsParams.bonusWSmods or 0
    end

    if wsParams.accVaries then
        -- applied to all hits (This is a penalty!)
        local accLost       = calcParams.accStat * (1 - xi.weaponskills.fTP(tp, wsParams.accVaries))
        calcParams.bonusAcc = calcParams.bonusAcc - accLost
    end

    calcParams.firstHitRate = xi.weaponskills.getHitRate(attacker, target, calcParams.bonusAcc + 125)
    calcParams.hitRate      = xi.weaponskills.getHitRate(attacker, target, calcParams.bonusAcc)
    calcParams.skillType    = attack.weaponType

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams     = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Add in magic damage for hybrid weaponskills
    if wsParams.hybridWS then
        finaldmg = finaldmg + calculateHybridMagicDamage(tp, finaldmg, attacker, target, wsParams, calcParams, wsID)
    end

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)
    attacker:delStatusEffect(xi.effect.SNEAK_ATTACK)
    attacker:delStatusEffectSilent(xi.effect.BUILDING_FLOURISH)

    if wsParams.meleedmg ~= nil and finaldmg > 0 then
            finaldmg = finaldmg + wsParams.meleedmg
    end

    -- Ws Specific DMG Bonus -Umeboshi
    --[[ if (attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0) then
        bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
    end]]

    -- PVP Adjustments
    if 
        target:getAllegiance() == 2 or
        target:getAllegiance() == 3 or
        target:getAllegiance() == 4 or
        target:getAllegiance() == 5 or
        target:getAllegiance() == 6
    then
        finaldmg = finaldmg * 0.45
    end

    finaldmg            = finaldmg --* xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    -- print('Final Damage Weaponskills')
    -- print(finaldmg)
    calcParams.finalDmg = finaldmg
    finaldmg            = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    local criticalHitsLanded = attacker:getLocalVar('[criticalHitsLanded]')
    if criticalHitsLanded > 0 then
        attacker:printToPlayer(string.format('%s\'s weapon skill scores [%s ] critical hits!', attacker:getName(), criticalHitsLanded), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        attacker:setLocalVar('[criticalHitsLanded]', 0)
    end

    local hitsParried = attacker:getLocalVar('[attacksParried]')
    if hitsParried > 0 then
        attacker:printToPlayer(string.format('The %s parried [%s ] hits!', target:getName(), hitsParried), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        attacker:setLocalVar('[attacksParried]', 0)
    end

    local hitsGuarded = attacker:getLocalVar('[attacksGuarded]')
    if hitsGuarded > 0 then
        attacker:printToPlayer(string.format('The %s guarded [%s ] hits!', target:getName(), hitsGuarded), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        attacker:setLocalVar('[attacksGuarded]', 0)
    end

    local hitsBlocked = attacker:getLocalVar('[attacksBlocked]')
    if hitsBlocked > 0 then
        attacker:printToPlayer(string.format('The %s blocked [%s ] hits!', target:getName(), hitsBlocked), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        attacker:setLocalVar('[attacksBlocked]', 0)
    end

    attacker:delStatusEffect(xi.effect.CONSUME_MANA)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- Sets up the necessary calcParams for a ranged WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to xi.weaponskills.takeWeaponskillDamage.
xi.weaponskills.doRangedWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Determine cratio and ccritratio
    local ignoredDef         = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignoredDefense)
    local cratio, ccritratio = cRangedRatio(attacker, target, wsParams, ignoredDef, tp)

    -- Set up conditions and params used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = xi.weaponskills.handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type']       = xi.attackType.RANGED,
        ['slot']       = xi.slot.RANGED,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.RANGED),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.RANGED)
    }

    local calcParams =
    {
        wsID                    = wsID,
        weaponDamage            = { attacker:getRangedDmg() * xi.weaponskills.consumeManaBonusWeaponDamage(attacker, wsParams) },
        skillType               = attacker:getWeaponSkillType(xi.slot.RANGED),
        fSTR                    = xi.weaponskills.fSTR2(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getRangedDmgRank()),
        cratio                  = cratio,
        ccritratio              = ccritratio,
        accStat                 = attacker:getRACC(),
        melee                   = false,
        mustMiss                = false,
        sneakApplicable         = false,
        trickApplicable         = false,
        assassinApplicable      = false,
        mightyStrikesApplicable = false,
        forcedFirstCrit         = false,
        extraOffhandHit         = false,
        flourishEffect          = false,
        bonusTP                 = wsParams.bonusTP or 0,
        bonusfTP                = gorgetBeltFTP or 0,
        bonusAcc                = (gorgetBeltAcc or 0) + attacker:getMod(xi.mod.WSACC),
        bonusWSmods             = wsParams.bonusWSmods or 0,
        attackType              = xi.attackType.RANGED
    }
    if wsParams.accVaries then
        -- applied to all hits (This is a penalty!)
        local accLost       = calcParams.accStat * (1 - xi.weaponskills.fTP(tp, wsParams.accVaries))
        calcParams.bonusAcc = calcParams.bonusAcc - accLost
    end

    calcParams.hitRate = getRangedHitRate(attacker, target, calcParams.bonusAcc + 10)

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)

    -- Ws Specific DMG Bonus -Umeboshi
    --[[if (attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0) then
        bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
    end]]
        
    if wsParams.meleedmg ~= nil and finaldmg > 0 then
            finaldmg = finaldmg + wsParams.meleedmg
    end

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * target:getMod(xi.mod.PIERCE_SDT) / 1000

    -- Add in magic damage for hybrid weaponskills
    if wsParams.hybridWS then
        finaldmg = finaldmg + calculateHybridMagicDamage(tp, finaldmg, attacker, target, wsParams, calcParams, wsID)
    end

    -- PVP damage adjustments
    if 
        target:getAllegiance() == 2 or
        target:getAllegiance() == 3 or
        target:getAllegiance() == 4 or
        target:getAllegiance() == 5 or
        target:getAllegiance() == 6
    then
        finaldmg = finaldmg * 0.45
    end

    finaldmg = finaldmg -- * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus

    -- If target has damage cap modifier, damage can not exceed value.
    if target:getMod(xi.mod.DMGRANGE_CAP) > 0 and finaldmg > target:getMod(xi.mod.DMGRANGE_CAP) then
        finaldmg = target:getMod(xi.mod.DMGRANGE_CAP)
    end

    calcParams.finalDmg = finaldmg

    finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    -- Delete single use effects from abilities.
    attacker:delStatusEffect(xi.effect.FLASHY_SHOT)
    attacker:delStatusEffect(xi.effect.STEALTH_SHOT)
    attacker:delStatusEffect(xi.effect.BOOST)

    local criticalHitsLanded = attacker:getLocalVar('[criticalHitsLanded]')
    if criticalHitsLanded > 0 then
        attacker:printToPlayer(string.format('%s\'s weapon skill scores [%s ] critical hits!', attacker:getName(), criticalHitsLanded), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        attacker:setLocalVar('[criticalHitsLanded]', 0)
    end

    attacker:delStatusEffect(xi.effect.CONSUME_MANA)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params: ftpMod, wsc_str, wsc_dex, wsc_vit, wsc_agi, wsc_int, wsc_mnd, wsc_chr,
--         ele (xi.element.FIRE), skill (xi.skill.STAFF)

xi.weaponskills.doMagicWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Set up conditions and wsParams used for calculating weaponskill damage
    local attack =
    {
        ['type']       = xi.attackType.MAGICAL,
        ['slot']       = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL + wsParams.ele
    }

    local calcParams =
    {
        ['shadowsAbsorbed'] = 0,
        ['tpHitsLanded']    = 1,
        ['extraHitsLanded'] = 0,
        ['bonusTP']         = wsParams.bonusTP or 0,
        ['wsID']            = wsID
    }

    local bonusfTP, bonusacc = xi.weaponskills.handleWSGorgetBelt(attacker)
    bonusacc                 = bonusacc + attacker:getMod(xi.mod.WSACC)

    -- local fint = utils.clamp(8 + (attacker:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)), -32, 32)
    local dStat = 0 -- Not all weaponskills use INT as a comparison. Set special use cases in the weaponskill's lua. Else use old INT-INT function.
    if
        wsParams.useStatCoefficient == true and
        wsParams.dStat1 and
        wsParams.dStat2 and
        wsParams.dStatMultiplier
    then
        dStat = utils.clamp(8 + ((attacker:getStat(wsParams.dStat1) - target:getStat(wsParams.dStat2)) * wsParams.dStatMultiplier) / 2, -32, 32)
         -- attacker:printToPlayer(string.format('dStat: %s', dStat), xi.msg.channel.SYSTEM_3) -- Debug to see modifier
    elseif wsParams.useStatCoefficient == false then
        dStat = 0
        -- attacker:printToPlayer(string.format('dStat: %s', dStat), xi.msg.channel.SYSTEM_3) -- Debug to see modifier
    else
        dStat = math.floor(8 + (attacker:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)) / 2)
        dStat = utils.clamp(dStat, -32, 32)
        -- attacker:printToPlayer(string.format('dStat: %s', dStat), xi.msg.channel.SYSTEM_3) -- Debug to see modifier
    end

    local dmg  = 0

    -- Magic-based WSes never miss, so we don't need to worry about calculating a miss, only if a shadow absorbed it.
    if not shadowAbsorb(target) then

        -- Begin Checks for bonus wsc bonuses. See the following for details:
        -- https://www.bg-wiki.com/bg/Utu_Grip
        -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

        for parameterName, modList in pairs(modParameters) do
            if attacker:getMod(modList[2]) > 0 then
                wsParams[parameterName] = wsParams[parameterName] + (attacker:getMod(modList[2]) / 100)
            end
        end

        for parameterName, modList in pairs(modParameters) do
            local paramValue = wsParams[parameterName] and wsParams[parameterName] or 0

            dmg = dmg + attacker:getStat(modList[1]) * paramValue
        end

        dmg = dmg + attacker:getMainLvl() + 2 + dStat -- fint

        -- Applying fTP multiplier
        local ftp = xi.weaponskills.fTP(tp, wsParams.ftpMod) + bonusfTP

        dmg = dmg * ftp

        -- Apply Consume Mana and Scarlet Delirium
        -- TODO: dmg = (dmg + consumeManaBonus(attacker)) * scarletDeliriumBonus(attacker)
        dmg = dmg * xi.weaponskills.scarletDeliriumBonus(attacker)
        dmg = dmg * xi.weaponskills.consumeManaBonusMagical(attacker, wsParams)

        -- Factor in "all hits" bonus damage mods
        local bonusdmg = attacker:getMod(xi.mod.ALL_WSDMG_ALL_HITS) -- For any WS
        if
            attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 and
            not attacker:isPet()
        then
            -- For specific WS
            bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
        end

        -- Add in bonusdmg
        dmg = dmg * (100 + bonusdmg) / 100 -- Apply our "all hits" WS dmg bonuses
        dmg = dmg + dmg * attacker:getMod(xi.mod.ALL_WSDMG_FIRST_HIT) / 100 -- Add in our "first hit" WS dmg bonus
        dmg = dmg + dmg * attacker:getMod(xi.mod.YAEGASUMI_BONUS) / 100

        -- Calculate magical bonuses and reductions
        dmg = addBonusesAbilityWeaponSkill(attacker, wsParams.ele, target, dmg, wsParams)
        dmg = dmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, bonusacc)
        dmg = target:magicDmgTaken(dmg, wsParams.ele)

        if dmg < 0 then
            calcParams.finalDmg = dmg

            dmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
            return dmg
        end

        dmg = adjustForTarget(target, dmg, wsParams.ele)

        -- PVP Damage Adjustments
        if 
            target:getAllegiance() == 2 or
            target:getAllegiance() == 3 or
            target:getAllegiance() == 4 or
            target:getAllegiance() == 5 or
            target:getAllegiance() == 6
        then
            dmg = dmg * 0.45
        end

        if dmg > 0 then
            dmg = dmg - target:getMod(xi.mod.PHALANX)
            dmg = utils.clamp(dmg, 0, 99999)
        end

        dmg = utils.oneforall(target, dmg)
        dmg = utils.stoneskin(target, dmg)

        dmg = dmg -- * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    else
        calcParams.shadowsAbsorbed = 1
    end

    --Divine/Elemental Seal Bonus
    if 
        wsParams.ele ~= nil and
        (wsParams.ele ~= xi.element.LIGHT or (wsParams.ele == xi.element.LIGHT and wsParams.skill == xi.skill.STAFF)) and -- Check for Dark element or Light for Sunburst/Starburst
        (attacker:hasStatusEffect(xi.effect.ELEMENTAL_SEAL))
    then
        dmg = math.floor(math.random(210,235)/100*dmg)
        attacker:delStatusEffect(xi.effect.ELEMENTAL_SEAL)
    elseif
        wsParams.ele ~= nil and
        (wsParams.ele == xi.element.LIGHT or (wsParams.ele == xi.element.DARK and wsParams.skill == xi.skill.STAFF)) and -- Check for light element or Dark for Sunburst/Starburst
        (attacker:hasStatusEffect(xi.effect.DIVINE_SEAL))
    then
        dmg = math.floor(math.random(225,245)/100*dmg)
        attacker:delStatusEffect(xi.effect.DIVINE_SEAL)
    end

    if target:getMod(xi.mod.DMGMAGIC_CAP) > 0 and dmg > target:getMod(xi.mod.DMGMAGIC_CAP) then -- If mob has this mod, damage can not exceed mod value.
        dmg = target:getMod(xi.mod.DMGMAGIC_CAP)
    end

    calcParams.finalDmg = dmg

    if dmg > 0 then
        attacker:trySkillUp(attack.weaponType, target:getMainLvl())
    end

    dmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    attacker:delStatusEffect(xi.effect.CONSUME_MANA)

    return dmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- After WS damage is calculated and damage reduction has been taken into account by the calling function,
-- handles displaying the appropriate action/message, delivering the damage to the mob, and any enmity from it
xi.weaponskills.takeWeaponskillDamage = function(defender, attacker, wsParams, primaryMsg, attack, wsResults, action)
    local finaldmg = wsResults.finalDmg

    if wsResults.tpHitsLanded + wsResults.extraHitsLanded > 0 then
        if finaldmg >= 0 then
            if primaryMsg then
                action:messageID(defender:getID(), xi.msg.basic.DAMAGE)
            else
                action:messageID(defender:getID(), xi.msg.basic.DAMAGE_SECONDARY)
            end

            if finaldmg > 0 then
                action:reaction(defender:getID(), xi.reaction.HIT)
                action:speceffect(defender:getID(), xi.specEffect.RECOIL)
            end
        else
            if primaryMsg then
                action:messageID(defender:getID(), xi.msg.basic.SELF_HEAL)
            else
                action:messageID(defender:getID(), xi.msg.basic.SELF_HEAL_SECONDARY)
            end
        end

        action:param(defender:getID(), math.abs(finaldmg))
    elseif wsResults.shadowsAbsorbed > 0 then
        action:messageID(defender:getID(), xi.msg.basic.SHADOW_ABSORB)
        action:param(defender:getID(), wsResults.shadowsAbsorbed)
    else
        if primaryMsg then
            action:messageID(defender:getID(), xi.msg.basic.SKILL_MISS)
        else
            action:messageID(defender:getID(), xi.msg.basic.EVADES)
        end

        action:reaction(defender:getID(), xi.reaction.EVADE)
    end

    local targetTPMult   = wsParams.targetTPMult or 1
    local attackerTPMult = wsParams.attackerTPMult or 1
    local isJump         = wsParams.isJump or false

    -- DA/TA/QA/OaT/Oa2-3 etc give full TP return per hit on Jumps
    if isJump then
        -- Don't feed TP and don't gain TP from takeWeaponskillDamage
        attackerTPMult            = 0
        wsResults.extraHitsLanded = 0
    end

    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attack.type, attack.damageType, attack.slot, primaryMsg, wsResults.tpHitsLanded * attackerTPMult, (wsResults.extraHitsLanded * 10) + wsResults.bonusTP, targetTPMult) * xi.settings.main.WEAPON_SKILL_POWER

    if wsResults.tpHitsLanded + wsResults.extraHitsLanded > 0 then
        if finaldmg >= 0 then
            finaldmg = finaldmg
            action:param(defender:getID(), math.abs(finaldmg))
            -- print('Final Damage')
            -- print(finaldmg)
        end
    end

    local enmityEntity = wsResults.taChar or attacker

    if wsParams.overrideCE and wsParams.overrideVE then
        defender:addEnmity(enmityEntity, wsParams.overrideCE, wsParams.overrideVE)
    else
        local enmityMult = wsParams.enmityMult or 1
        if attacker:hasStatusEffect(xi.effect.FLASHY_SHOT) and not wsResults.melee then
            enmityMult = enmityMult * 1.4
        elseif attacker:hasStatusEffect(xi.effect.STEALTH_SHOT) and not wsResults.melee then
            enmityMult = enmityMult * (1 - attacker:getMerit(xi.merit.STEALTH_SHOT) / 100)
        end
        defender:updateEnmityFromDamage(enmityEntity, finaldmg * enmityMult)
    end

    if attacker:hasStatusEffect(xi.effect.SENGIKORI) then
        if finaldmg > 0 then
            defender:setMod(xi.mod.SENGIKORI_DEBUFF, 25)  -- Apply Debuff to target.
            attacker:setLocalVar('Sengikori_SC', 0)       -- Set Initial Variable
            attacker:delStatusEffect(xi.effect.SENGIKORI) -- Consume status effect.
        end
    end

    if finaldmg > 0 then
        -- Pack the weaponskill ID in the top 8 bits of this variable which is utilized
        -- in OnMobDeath in luautils.  Max WSID is 255.
        defender:setLocalVar('weaponskillHit', bit.lshift(wsResults.wsID, 24) + finaldmg)
    end

    return finaldmg
end

-- Helper function to get Main damage depending on weapon type
xi.weaponskills.getMeleeDmg = function(attacker, weaponType, kick)
    local mainhandDamage = attacker:getWeaponDmg()
    -- attacker:printToPlayer(string.format('Main Weapon Damage: %s', mainhandDamage), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
    local offhandDamage = attacker:getOffhandDmg()

    if attacker:hasStatusEffect(xi.effect.CONSUME_MANA) then
        mainhandDamage = mainhandDamage * xi.weaponskills.consumeManaBonusWeaponDamage(attacker, wsParams)
        -- attacker:printToPlayer(string.format('Main Weapon Damage: %s', mainhandDamage), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        offhandDamage = offhandDamage * xi.weaponskills.consumeManaBonusWeaponDamage(attacker, wsParams)
        -- attacker:printToPlayer(string.format('Sub Weapon Damage: %s', offhandDamage), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
    end

    if weaponType == xi.skill.HAND_TO_HAND or weaponType == xi.skill.NONE then
        local h2hSkill = attacker:getSkillLevel(xi.skill.HAND_TO_HAND) * 0.11 + 3

        if kick and attacker:hasStatusEffect(xi.effect.FOOTWORK) then
            mainhandDamage = attacker:getMod(xi.mod.KICK_DMG) -- Use Kick damage if footwork is on
        end

        mainhandDamage = mainhandDamage + h2hSkill
        offhandDamage  = mainhandDamage
    end

    return { mainhandDamage, offhandDamage }
end

xi.weaponskills.getHitRate = function(attacker, target, bonus)
    local flourishEffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

    if flourishEffect ~= nil and flourishEffect:getPower() >= 1 then -- 1 or more Finishing moves used.
        attacker:addMod(xi.mod.ACC, 40 + flourishEffect:getSubPower() * 2)
    end

    local acc = attacker:getACC()
    local eva = target:getEVA() + target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    if flourishEffect ~= nil and flourishEffect:getPower() >= 1 then -- 1 or more Finishing moves used.
        attacker:delMod(xi.mod.ACC, 40 + flourishEffect:getSubPower() * 2)
    end

    if bonus == nil then
        bonus = 0
    end

    if
        attacker:hasStatusEffect(xi.effect.INNIN) and
        attacker:isBehind(target, 23)
    then
        -- Innin acc boost if attacker is behind target
        bonus = bonus + attacker:getStatusEffect(xi.effect.INNIN):getPower()
    end

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        attacker:isFacing(target, 23)
    then
        -- Yonin evasion boost if attacker is facing target
        bonus = bonus - target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    if attacker:hasTrait(xi.trait.AMBUSH) and attacker:isBehind(target, 23) then
        bonus = bonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    acc = acc + bonus

    -- Accuracy Bonus
    if attacker:getMainLvl() > target:getMainLvl() then
        acc = acc + (attacker:getMainLvl() - target:getMainLvl()) * 2

    -- Accuracy Penalty
    elseif attacker:getMainLvl() < target:getMainLvl() then
        acc = acc - (target:getMainLvl() - attacker:getMainLvl()) * 1.5
    end

    local hitdiff = (acc - eva) / 2
    local hitrate = (75 + hitdiff) / 100

    -- Applying hitrate caps
    hitrate = utils.clamp(hitrate, 0.2, 0.98)
    -- print(hitrate)
    return hitrate
end

-- TODO: Use a common function with optional multiplier on return, or multiply outside of this.
xi.weaponskills.fTP = function(tp, ftpTable)
    if
        not ftpTable or
        tp < 1000
    then
        -- No multiplier if points are not provided, or TP is not at minimum required
        return 1
    end

    if tp >= 2000 then
        return ftpTable[2] + (tp - 2000) * (ftpTable[3] - ftpTable[2]) / 1000
    elseif tp >= 1000 then
        return ftpTable[1] + (tp - 1000) * (ftpTable[2] - ftpTable[1]) / 1000
    end
end

xi.weaponskills.calculatedIgnoredDef = function(tp, def, ignoredDefenseTable)
    if ignoredDefenseTable then
        return xi.weaponskills.fTP(tp, ignoredDefenseTable) * def
    end

    return 0
end

local function getMeleePDifRange(wRatio, pDifFinalCap)
    local pDifUpperCap       = 0
    local pDifLowerCap       = 0
    if wRatio < 0.5 then
        pDifUpperCap = wRatio + 0.5
    elseif wRatio < 0.7 then
        pDifUpperCap = 1
    elseif wRatio < 1.2 then
        pDifUpperCap = wRatio + 0.3
    elseif wRatio < 1.5 then
        pDifUpperCap = wRatio + wRatio * 0.25
    else
        pDifUpperCap = math.min(wRatio + 0.375, pDifFinalCap)
    end

    -- pDIF lower cap.
    if wRatio < 0.38 then
        pDifLowerCap = 0
    elseif wRatio < 1.25 then
        pDifLowerCap = wRatio * 1176 / 1024 - 448 / 1024
    elseif wRatio < 1.51 then
        pDifLowerCap = 1
    elseif wRatio < 2.44 then
        pDifLowerCap = wRatio * 1176 / 1024 - 775 / 1024
    else
        pDifLowerCap = wRatio - 0.375
    end

    return { pDifLowerCap, pDifUpperCap }
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
xi.weaponskills.cMeleeRatio = function(attacker, defender, params, ignoredDef, tp, ratioMod)
    local weaponType = attacker:getWeaponSkillType(xi.slot.MAIN)
    local flourishEffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

    if flourishEffect ~= nil and flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
        attacker:addMod(xi.mod.ATTP, 25 + flourishEffect:getSubPower())
    end

    local atkMultiplier = xi.weaponskills.fTP(tp, params.atkVaries)
    local cratio        = attacker:getStat(xi.mod.ATT) * atkMultiplier / (defender:getStat(xi.mod.DEF) - ignoredDef)

    if ratioMod then
        cratio = attacker:getStat(ratioMod) * atkMultiplier / (defender:getStat(xi.mod.DEF) - ignoredDef)
        -- print(ratioMod)
    end

    -- cratio = utils.clamp(cratio, 0, 2.25)
    if flourishEffect ~= nil and flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
        attacker:delMod(xi.mod.ATTP, 25 + flourishEffect:getSubPower())
    end

    local levelCorrection = 0
    if attacker:getMainLvl() < defender:getMainLvl() then
        levelCorrection = 0.05 * (defender:getMainLvl() - attacker:getMainLvl())
    end

    cratio     = math.max(0, cratio - levelCorrection)
    local damageLimitPlus = attacker:getMod(xi.mod.DAMAGE_LIMIT) / 100
    local damageLimitPercent = (100 + attacker:getMod(xi.mod.DAMAGE_LIMITP)) / 100
    local cratioCap = (xi.combat.physical.pDifWeaponCapTable[weaponType][1] + damageLimitPlus) * damageLimitPercent -- Added damage limit bonuses

    cratio = utils.clamp(cratio, 0, cratioCap)
    local pdif = getMeleePDifRange(cratio, cratioCap)

    cratio                   = cratio + 1
    cratio                   = utils.clamp(cratio, 0, cratioCap + 1)
    local unadjustedPDifCrit = getMeleePDifRange(cratio, cratioCap + 1)

    local critbonus = utils.clamp(attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS) + defender:getMod(xi.mod.ENEMYCRITDMG), 0, 100)
    local pdifcrit  = { unadjustedPDifCrit[1] * (100 + critbonus) / 100, unadjustedPDifCrit[2] * (100 + critbonus) / 100 }

    return pdif, pdifcrit
end

xi.weaponskills.handleBlock = function(attacker, target, finaldmg)
    if
        target:getBlockRate(attacker) >= math.random(100) and
        target:isFacing(attacker) and
        target:getEcosystem() == xi.eco.BEASTMEN and
        target:getMainJob() == xi.job.PLD
    then
        finaldmg = math.floor(finaldmg * 0.5)
    elseif
        target:getBlockRate(attacker) > math.random(100) and
        target:isFacing(attacker) and
        target:isPC() and
        target:getEquippedItem(xi.slot.SUB):isShield()
    then
        local absorb = 100
        absorb = utils.clamp(absorb - target:getShieldAbsorptionRate(), 0, 100)
        -- print('blocked')
        absorb = absorb + target:getMod(xi.mod.SHIELD_DEF_BONUS)
        finaldmg = math.floor(finaldmg * (absorb / 100))
        target:trySkillUp(xi.skill.SHIELD, attacker:getMainLvl())
    end

    return finaldmg
end


xi.weaponskills.handleParry = function(attacker, target, missChance, guaranteedHit)
    local gHit = guaranteedHit or false
    if
        target:isEngaged() and
        target:isFacing(attacker) and
        target:getParryRate(attacker, target) >= math.random(100) and
        target:getMainJob() ~= xi.job.MNK and not gHit
    then -- Try parry, if so miss.
        if target:getEcosystem() == xi.eco.BEASTMEN or target:isPC() then
            missChance = 1
            -- print('parried')
        end

        if target:isPC() then
            target:trySkillUp(xi.skill.PARRY, attacker:getMainLvl())
        end
    end

    return missChance
end

xi.weaponskills.handleGuard = function(attacker, target, missChance, guaranteedHit)
    local gHit = guaranteedHit or false
    if
        ((target:getMainJob() == xi.job.MNK or
        target:getMainJob() == xi.job.PUP) or
        (target:getSubJob() == xi.job.MNK or
        target:getSubJob() == xi.job.PUP))
    then
        if
            target:getGuardRate(attacker) > math.random(100) and
            target:isFacing(attacker) and
            target:isPC() and
            not gHit
        then
            -- Per testing shown by genome mob skills register as a miss when guarded
            -- https://genomeffxi.livejournal.com/18269.html
            missChance = 1
            -- print('guarded')
            target:trySkillUp(xi.skill.GUARD, attacker:getMainLvl())
        end
    end

    return missChance
end

-- Given the attacker's str and the mob's vit, fSTR is calculated (for melee WS)
xi.weaponskills.fSTR = function(atkStr, defVit, weaponRank)
    local dSTR = atkStr - defVit
    local fSTR = calculateRawFstr(dSTR, 4)

    -- Apply fSTR caps.
    local lowerCap = math.min(-1, weaponRank * -1)

    fSTR = utils.clamp(fSTR, lowerCap, weaponRank + 8)

    return fSTR
end

xi.weaponskills.generatePdif = function(cratiomin, cratiomax, melee)
    local pdif = math.random(cratiomin * 1000, cratiomax * 1000) / 1000

    if melee then
        pdif = pdif * (math.random(100, 105) / 100)
    end

    return pdif
end

xi.weaponskills.handleWSGorgetBelt = function(attacker)
    local ftpBonus = 0
    local accBonus = 0

    if attacker:getObjType() == xi.objType.PC then
        local elementalGorget = -- Ordered by element correctly. TODO: mods/latents instead of items
        {
            xi.item.FLAME_GORGET,
            xi.item.SNOW_GORGET,
            xi.item.BREEZE_GORGET,
            xi.item.SOIL_GORGET,
            xi.item.THUNDER_GORGET,
            xi.item.AQUA_GORGET,
            xi.item.LIGHT_GORGET,
            xi.item.SHADOW_GORGET
        }

        local elementalBelt = -- Ordered by element correctly. TODO: mods/latents instead of items
        {
            xi.item.FLAME_BELT,
            xi.item.SNOW_BELT,
            xi.item.BREEZE_BELT,
            xi.item.SOIL_BELT,
            xi.item.THUNDER_BELT,
            xi.item.AQUA_BELT,
            xi.item.LIGHT_BELT,
            xi.item.SHADOW_BELT
        }

        local neck                      = attacker:getEquipID(xi.slot.NECK)
        local belt                      = attacker:getEquipID(xi.slot.WAIST)
        local weapon                    = attacker:getEquipID(xi.slot.MAIN)
        local scProp1, scProp2, scProp3 = attacker:getWSSkillchainProp()

        for i, v in ipairs(elementalGorget) do
            if neck == v then
                if
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp1) or
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp2) or
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if neck == xi.item.FOTIA_GORGET then -- Fotia Gorget
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end

        for i, v in ipairs(elementalBelt) do
            if belt == v then
                if
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp1) or
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp2) or
                    xi.magicburst.doesElementMatchWeaponskill(i, scProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if belt == xi.item.FOTIA_BELT then -- Fotia Belt
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end

        if
            weapon == xi.item.PRESTER and
            (xi.magicburst.doesElementMatchWeaponskill(xi.element.WIND, scProp1) or
            xi.magicburst.doesElementMatchWeaponskill(xi.element.WIND, scProp2) or
            xi.magicburst.doesElementMatchWeaponskill(xi.element.WIND, scProp3))
        then -- Prester
            ftpBonus = ftpBonus + 0.1
        end
    end

    return ftpBonus, accBonus
end