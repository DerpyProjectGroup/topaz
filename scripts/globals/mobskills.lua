-----------------------------------
-- Monster TP Moves Global
-- NOTE: A lot of this is good estimating since the FFXI playerbase has not found all of info for individual moves.
-- What is known is that they roughly follow player Weaponskill calculations (pDIF, dMOD, ratio, etc) so this is what
-- this set of functions emulates.
-----------------------------------
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/magicburst')
require('scripts/globals/magic')
require('scripts/globals/spells/damage_spell')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.mobskills = xi.mobskills or {}

xi.mobskills.drainType =
{
    HP = 0,
    MP = 1,
    TP = 2,
}

-- Shadow Behavior (Number of shadows to remove)
xi.mobskills.shadowBehavior =
{
    IGNORE_SHADOWS     = 0,
    NUMSHADOWS_1       = 1,
    NUMSHADOWS_2       = 2,
    NUMSHADOWS_3       = 3,
    NUMSHADOWS_4       = 4,
    NUMSHADOWS_RANDOM  = math.random(2, 3),
    WIPE_SHADOWS       = 999,
}

xi.mobskills.physicalTpBonus =
{
    ACC_VARIES  = 0,
    ATK_VARIES  = 1,
    DMG_VARIES  = 2,
    CRIT_VARIES = 3,
    DMG_FLAT    = 4,
    RANGED      = 5,
    NONE        = 6,
}

xi.mobskills.magicalTpBonus =
{
    NO_EFFECT   = 0,
    MACC_BONUS  = 1,
    MAB_BONUS   = 2,
    DMG_BONUS   = 3,
    RANGED      = 4,
    PDIF_BONUS  = 5,
}

--[[local function MobTPMod(tp)
    -- increase damage based on tp
    if tp >= 3000 then
        return 2
    elseif tp >= 2000 then
        return 1.5
    end

    return 1
end]]

local burstMultipliersByTier =
{
    [0] = 1.0,
    [1] = 1.3,
    [2] = 1.35,
    [3] = 1.40,
    [4] = 1.45,
    [5] = 1.5,
}

xi.mobskills.calculateMobMagicBurst = function(caster, element, target)
    local burstMultiplier = 1.0
    local skillchainTier, skillchainCount = xi.magicburst.formMagicBurst(element, target)

    if skillchainTier > 0 then
        burstMultiplier = burstMultipliersByTier[skillchainCount]
    end

    return burstMultiplier
end

local function MobTakeAoEShadow(mob, target, max)
    -- TODO: Use actual NIN skill, not this function
    if
        (target:getMainJob() == xi.job.NIN or
        target:getSubJob() == xi.job.NIN) and
        math.random() < 0.6
    then
        max = max - 1
        if max < 1 then
            max = 1
        end
    end

    return math.random(1, max)
end

-- helper function to handle a single hit and check for parrying, guarding, and blocking
local function handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect, minRatio, maxRatio)
    -- if a non-ranged physical mobskill then can parry or guard
    if
        tpEffect == xi.mobskills.magicalTpBonus.RANGED or
        (not xi.combat.physical.isParried(target, mob) and
        not xi.combat.physical.isGuarded(target, mob))
    then
        local pdif = math.random((minRatio * 1000), (maxRatio * 1000)) --generate random PDIF
        pdif = pdif / 1000 --multiplier set.
        finaldmg = finaldmg + hitdamage * pdif
        -- also handle blocking
        finaldmg = xi.combat.physical.handleBlock(target, mob, finaldmg)
        hitslanded = hitslanded + 1
    end

    return hitslanded, finaldmg
end

xi.mobskills.mobRangedMove = function(mob, target, skill, numHits, accMod, dmgMod, tpEffect, mtp000, mtp150, mtp300, offcratiomod)
    local returninfo    = {}
    local dSTR          = utils.clamp(mob:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT), -10, 10)
    local targetEvasion = target:getEVA() + target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        mob:isFacing(target, 23)
    then
        -- Yonin evasion boost if mob is facing target
        targetEvasion = targetEvasion + target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    -- Apply WSC (TODO: Change to include WSC)
    local base = math.max(1, mob:getWeaponDmg() + dSTR)

    if mob:getLocalVar('[ranged_attack]weaponDmg') > 0 then
        base = mob:getLocalVar('[ranged_attack]weaponDmg') + dSTR
    end

    --work out and cap ratio
    if not offcratiomod then -- default to attack. Pretty much every physical mobskill will use this, Cannonball being the exception.
        offcratiomod = mob:getStat(xi.mod.ATT)
    end

    local ratio   = offcratiomod / target:getStat(xi.mod.DEF)
    local lvldiff = math.max(0, mob:getMainLvl() - target:getMainLvl())

    ratio = ratio + lvldiff * 0.05
    ratio = utils.clamp(ratio, 0, 4)

    --work out hit rate for mobs
    local hitrate = ((mob:getACC() * accMod) - targetEvasion) / 2 + (lvldiff * 2) + 75

    hitrate = utils.clamp(hitrate, 20, 95)

    --work out the base damage for a single hit
    local hitdamage = math.max(1, base + lvldiff) * dmgMod

    --[[if tpEffect == xi.mobskills.physicalTpBonus.DMG_VARIES then
        hitdamage = hitdamage * MobTPMod(skill:getTP() / 10)
    end]]

    --work out min and max cRatio
    local maxRatio = ratio
    local minRatio = ratio - 0.375

    if ratio < 0.5 then
        maxRatio = ratio + 0.5
    elseif ratio <= 0.7 then
        maxRatio = 1
    elseif ratio <= 1.2 then
        maxRatio = ratio + 0.3
    elseif ratio <= 1.5 then
        maxRatio = (ratio * 0.25) + ratio
    elseif ratio <= 2.625 then
        maxRatio = ratio + 0.375
    elseif ratio <= 3.25 then
        maxRatio = 3
    end

    if ratio < 0.38 then
        minRatio = 0
    elseif ratio <= 1.25 then
        minRatio = ratio * (1176 / 1024) - (448 / 1024)
    elseif ratio <= 1.51 then
        minRatio = 1
    elseif ratio <= 2.44 then
        minRatio = ratio * (1176 / 1024) - (775 / 1024)
    end

    --[[apply ftp (assumes 1~3 scalar linear mod)
    if tpEffect == xi.mobskills.magicalTpBonus.DMG_BONUS then
        hitdamage = hitdamage * fTP(skill:getTP(), mtp000, mtp150, mtp300)
    end]]

    -- start the hits
    local finaldmg   = 0
    local hitsdone   = 1
    local hitslanded = 0

    -- first hit has a higher chance to land
    local firstHitChance = hitrate * 1.5

    if tpEffect == xi.mobskills.magicalTpBonus.RANGED then
        firstHitChance = hitrate * 1.2
    end

    firstHitChance = utils.clamp(firstHitChance, 35, 95)

    if (math.random() * 100) <= firstHitChance then
        -- use helper function check for parry guard and blocking and handle the hit
        hitslanded, finaldmg = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect, minRatio, maxRatio)
    end

    while hitsdone < numHits do
        if (math.random() * 100) <= hitrate then --it hit
            hitslanded, finaldmg = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect, minRatio, maxRatio)
        end

        hitsdone = hitsdone + 1
    end

    -- Handle Phalanx 'Phalanx now applies per hit - Umeboshi'
    if finaldmg > 0 then
        finaldmg = utils.clamp(finaldmg - (target:getMod(xi.mod.PHALANX) * hitslanded), 0, 99999)
    end

    -- if an attack landed it must do at least 1 damage
    if hitslanded >= 1 and finaldmg < 1 then
        finaldmg = 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg   = 0
        hitslanded = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    returninfo.dmg        = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo
end

-----------------------------------
-- Mob Physical Abilities
-- accMod    : linear multiplier for accuracy (1 default)
-- dmgMod    : linear multiplier for damage (1 default)
-- attMod    : linear multiplier for attack (1 default)
-- critPerc  : Base Crit rate for the weapon skill.
-- tpEffect  : Defined in xi.mobskills.physicalTpBonus
-- tpEffect2 : Defined in xi.mobskills.physicalTpBonus
-----------------------------------
xi.mobskills.mobPhysicalMove = function(mob, target, skill, numHits, accMod, dmgMod, tpEffect1, tpEffect1_ftp100, tpEffect1_ftp200, tpEffect1_ftp300, tpEffect2, tpEffect2_ftp100, tpEffect2_ftp200, tpEffect2_ftp300, critPerc, attMod)
    local returninfo    = {}
    local fStr = 0

    -- nil checks

    if tpEffect1 == nil then
        tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
        -- print('xi.mobskills.physicalTpBonus.NONE')
    end

    if tpEffect2 == nil then
        tpEffect2 = xi.mobskills.physicalTpBonus.NONE
        -- print('xi.mobskills.physicalTpBonus.NONE')
    end

    if
        tpEffect1_ftp100 == nil or
        tpEffect1_ftp200 == nil or
        tpEffect1_ftp300 == nil
    then
        -- This is what the old MobTPMod(tp) function performed. Should catch any nil references until all skills get audited.
        tpEffect1_ftp100 = 1.0
        -- print('tpeffect2_100 = 1')
        tpEffect1_ftp200 = 1.5
        -- print('tpeffect2_200 = 1')
        tpEffect1_ftp300 = 2.0
        -- print('tpeffect2_300 = 1')
    end

    if
        tpEffect2_ftp100 == nil or
        tpEffect2_ftp200 == nil or
        tpEffect2_ftp300 == nil
    then
        tpEffect2_ftp100 = 1
        -- print('tpeffect2_100 = 1')
        tpEffect2_ftp200 = 1
        -- print('tpeffect2_200 = 1')
        tpEffect2_ftp300 = 1
        -- print('tpeffect2_300 = 1')
    end

    if critPerc == nil then
        critPerc = 0
        -- print('critPerc = 0')
    end

    if attMod == nil then
        attMod = 1 -- Default to 1 unless set otherwise.
        -- print('attMod = 1')
    end

    ----------------------------------
    -- Get dSTR (bias to monsters, so no fSTR) (ASB)
    ----------------------------------
    if
        tpEffect1 == xi.mobskills.physicalTpBonus.RANGED or
        tpEffect2 == xi.mobskills.physicalTpBonus.RANGED
    then
        fStr = xi.mobskills.fSTR2(mob:getStat(xi.mod.STR), target:getStat(xi.mod.VIT))
    else
        fStr = xi.mobskills.fSTR(mob:getStat(xi.mod.STR), target:getStat(xi.mod.VIT))
    end
    ----------------------------------
    -- Calculate Base Damage
    ----------------------------------
    local base = 0 -- (ASB)
    if
        tpEffect1 == xi.mobskills.physicalTpBonus.RANGED or
        tpEffect2 == xi.mobskills.physicalTpBonus.RANGED
    then
        base = math.floor(mob:getWeaponDmg() + fStr) -- TODO Seperate DMG rating based on equip slot.
    elseif 
        tpEffect1 == xi.mobskills.physicalTpBonus.DMG_FLAT or
        tpEffect2 == xi.mobskills.physicalTpBonus.DMG_FLAT
    then
        base = 100
    else
        base = math.floor(mob:getWeaponDmg() + fStr)
    end

    if base < 1 then --(ASB)
        base = 1
    end
    ----------------------------------
    -- Calculate hitrate for mobskill.
    ----------------------------------
    local hitrate = xi.weaponskills.getHitRate(mob, target, 0)

    if
        accMod and
        accMod ~= 0
    then
        hitrate = utils.clamp((hitrate * accMod), 0.2, 0.95)
    end

    --[[if
        tpEffect1 == xi.mobskills.physicalTpBonus.RANGED or
        tpEffect2 == xi.mobskills.physicalTpBonus.RANGED
    then -- (ASB)
        -- hitrate = xi.weaponskills.getRangedHitRate(mob, target, 0, 0) TODO: Need to build out in weaponskills or physical utilities.
    end]]

    ----------------------------------
    -- Calculate base damage for a single hit.
    ----------------------------------
    local hitdamage = math.max(1, base) * dmgMod

    if hitdamage < 1 then
        hitdamage = 0 -- If I hit below 1 I actually did 0 damage.
    end

    --apply ftp
    if tpEffect1 == xi.mobskills.physicalTpBonus.DMG_VARIES then
        hitdamage = hitdamage * xi.mobskills.fTP(skill:getTP(), tpEffect1_ftp100, tpEffect1_ftp200, tpEffect1_ftp300)
    elseif tpEffect2 == xi.mobskills.physicalTpBonus.DMG_VARIES then
        hitdamage = hitdamage * xi.mobskills.fTP(skill:getTP(), tpEffect2_ftp100, tpEffect2_ftp200, tpEffect2_ftp300)
    else
        hitdamage = hitdamage
    end

    ----------------------------------
    -- Start the hits
    ----------------------------------
    local finaldmg   = 0
    local hitsdone   = 1
    local hitslanded = 0
    local chance = math.random()

    -- If mobskill is not ranged, allow for Parry/Guard chance.
    if
        tpEffect1 ~= xi.mobskills.physicalTpBonus.RANGED and
        tpEffect2 ~= xi.mobskills.physicalTpBonus.RANGED
    then
        chance = xi.weaponskills.handleParry(mob, target, chance)
        chance = xi.weaponskills.handleGuard(mob, target, chance)
    end

    -- first hit has a higher chance to land
    -- local firstHitChance = hitrate * 1.5 (LSB)

    local firstHitChance = hitrate + 0.5 -- (ASB)

    --[[if
        tpEffect1 == xi.mobskills.magicalTpBonus.RANGED or
        tpEffect2 == xi.mobskills.magicalTpBonus.RANGED 
    then
        firstHitChance = hitrate * 1.2
    end]]

    if
        tpEffect1 == xi.mobskills.physicalTpBonus.RANGED or
        tpEffect2 == xi.mobskills.physicalTpBonus.RANGED
    then -- (ASB)
        firstHitChance = hitrate
    end

    -- firstHitChance = utils.clamp(firstHitChance, 35, 95)
    firstHitChance = utils.clamp(firstHitChance, 0.20, 0.95) -- (ASB)

    -- Getting PDIF
    if
        tpEffect1 == xi.mobskills.physicalTpBonus.ATK_VARIES
    then
        attMod = attMod * xi.mobskills.fTP(skill:getTP(), tpEffect1_ftp100, tpEffect1_ftp200, tpEffect1_ftp300)
    elseif
        tpEffect2 == xi.mobskills.physicalTpBonus.ATK_VARIES
    then
        attMod = attMod * xi.mobskills.fTP(skill:getTP(), tpEffect2_ftp100, tpEffect2_ftp200, tpEffect2_ftp300)
    end

    -- print(attMod)

    -- TODO: coffratioMod for cannonball
    
    -- Calculate Critical Hit rate
    local critRate = 0 -- if no CritPerc value set in mobskill, critRate = 0.

    if critPerc == nil then
        critPerc = 0 -- Default to 0 unless set otherwise.
    end

    if critPerc then -- Base Critical Hit Rate for Mobskill
        critRate = critPerc
        --apply ftp
        if tpEffect1 == xi.mobskills.physicalTpBonus.CRIT_VARIES then
            critRate = critRate * xi.mobskills.fTP(skill:getTP(), tpEffect1_ftp100, tpEffect1_ftp200, tpEffect1_ftp300)
        elseif tpEffect2 == xi.mobskills.physicalTpBonus.CRIT_VARIES then
            critRate = critRate * xi.mobskills.fTP(skill:getTP(), tpEffect2_ftp100, tpEffect2_ftp200, tpEffect2_ftp300)
        else
            critRate = critRate
        end
    end
    local weaponType = mob:getWeaponSkillType(xi.slot.MAIN)
    local pdif = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod)

    if chance <= firstHitChance then -- A hit landed (ASB)
        local isCrit = math.random() < critRate

        -- print(critRate)
        -- print(critFTP)

        if isCrit then
            pdif = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod, isCrit)
            -- print('crit true')
            -- target:printToPlayer(string.format('The attack scores a critical hit!', mob:getName()), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.

        else
            pdif = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod)
        end

        finaldmg = finaldmg + hitdamage * pdif
        finaldmg = xi.weaponskills.handleBlock(mob, target, finaldmg) -- (ASB)
        hitslanded = hitslanded + 1
    end

    while hitsdone < numHits do -- (ASB)
        chance = math.random()
        -- If mobskill is not ranged, allow for Parry/Guard chance on the following hit attempts.
        if
            tpEffect1 ~= xi.mobskills.physicalTpBonus.RANGED and
            tpEffect2 ~= xi.mobskills.physicalTpBonus.RANGED
        then
            chance = xi.weaponskills.handleParry(mob, target, chance)
            chance = xi.weaponskills.handleGuard(mob, target, chance)
        end
        
        if chance <= hitrate then --it hit
        local isCrit = math.random() < critRate

        -- print(critRate)
        -- print(critFTP)

        if isCrit then
            pdif = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod, isCrit)
            -- target:printToPlayer(string.format('The %s attack scores a critical hit!', mob:getName()), xi.msg.channel.SYSTEM_3) -- Debug to see modifier of each hit in a weapon skill.
        else
            pdif = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod)
        end
        
            finaldmg = finaldmg + (hitdamage * pdif)
            finaldmg = xi.weaponskills.handleBlock(mob, target, finaldmg) -- (ASB)
            hitslanded = hitslanded + 1
        end
        hitsdone = hitsdone + 1
    end

    -- print(hitslanded)
    -- Handle Phalanx 'Phalanx now applies per hit - Umeboshi'
    if finaldmg > 0 then
        finaldmg = utils.clamp(finaldmg - (target:getMod(xi.mod.PHALANX) * hitslanded), 0, 99999)
    end

    -- if an attack landed it must do at least 1 damage
    if hitslanded >= 1 and finaldmg < 1 then
        -- finaldmg = 1
        finaldmg = 0 -- If I hit below 1 I actually did 0 damage. (ASB)
    end

    -- all hits missed
    if target:hasStatusEffect(xi.effect.YAEGASUMI) then
        local yaegasumiEffect      = target:getStatusEffect(xi.effect.YAEGASUMI)
        local yaegasumiEffectPower = yaegasumiEffect:getPower()
        finaldmg   = 0
        hitslanded = 0
        yaegasumiEffect:setPower(yaegasumiEffectPower + 1) -- 1 power = 20% Damage Increase
        skill:setMsg(xi.msg.basic.EVADES)
    elseif hitslanded == 0 or finaldmg == 0 then
        finaldmg   = 0
        hitslanded = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    -- calculate tp return of mob skill and add if hit primary target
    elseif skill:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(mob, target)
        tpReturn = tpReturn + 10 * (hitslanded - 1) -- extra hits give 10 TP each
        mob:addTP(tpReturn)
    end

    
    --[[if -- ASB Pet damage reduction
        tpeffect ~= xi.mobskills.physicalTpBonus.RANGED and
        target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) ~= 0
    then
        finaldmg = finaldmg * (target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) / 100)
    end]]

    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo
end

-- MAGICAL MOVE
-- Call this on every magical move!
-- mob/target/skill should be passed from onMobWeaponSkill.
-- dmg is the base damage (V value), accmod is a multiplier for accuracy (1 default, more than 1 = higher macc for mob),
-- ditto for dmg mod but more damage >1 (equivalent of M value)
-- tpeffect is an enum from one of:
-- 0 = xi.mobskills.magicalTpBonus.NO_EFFECT
-- 1 = xi.mobskills.magicalTpBonus.MACC_BONUS
-- 2 = xi.mobskills.magicalTpBonus.MAB_BONUS
-- 3 = xi.mobskills.magicalTpBonus.DMG_BONUS
-- tpvalue affects the strength of having more TP along the following lines:
-- xi.mobskills.magicalTpBonus.NO_EFFECT -> tpvalue has no xi.effect.
-- xi.mobskills.magicalTpBonus.MACC_BONUS -> direct multiplier to macc (1 for default)
-- xi.mobskills.magicalTpBonus.MAB_BONUS -> direct multiplier to mab (1 for default)
-- xi.mobskills.magicalTpBonus.DMG_BONUS -> direct multiplier to damage (V+dINT) (1 for default)
--Examples:
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 100, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1) / 100 = 150
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 200, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1) / 100 = 300
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 100, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2) / 100 = 300
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 200, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2) / 100 = 600

xi.mobskills.mobMagicalMove = function(actor, target, action, baseDamage, actionElement, damageModifier, tpEffect, tpMultiplier, ignoreresist, ftp100, ftp200, ftp300, dStatMult)

    if tpMultiplier == nil then
        tpMultiplier = 1
    end

    if ignoreresist == 0 then
        ignoreresist = false
    end

    -- Calculating with the known era pdif ratio for weaponskills.
    if ftp100 == nil or ftp200 == nil or ftp300 == nil then -- Nil gate, will default mtp for each level to 1.
        ftp100 = 1.0
        ftp200 = 1.0
        ftp300 = 1.0
    end

    local tp          = action:getTP()
    local ignoreres   = ignoreresist or false
    local ftpMult     = xi.mobskills.fTP(tp, ftp100, ftp200, ftp300)
    local finalDamage = math.floor(baseDamage * ftpMult)

    -- Base damage
    if tpEffect == xi.mobskills.magicalTpBonus.DMG_BONUS then
        finalDamage = math.floor(finalDamage * action:getTP() * tpMultiplier / 1000)
    end

    -- Get bonus macc.
    local petAccBonus = 0
    if actor:isPet() and actor:getMaster() ~= nil then
        local master = actor:getMaster()
        if actor:isAvatar() then
            petAccBonus = utils.clamp(master:getSkillLevel(xi.skill.SUMMONING_MAGIC) - master:getMaxSkillLevel(actor:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC), 0, 200)
        end

        local skillchainTier, _ = xi.magicburst.formMagicBurst(actionElement, target)
        if
            actor:getPetID() > 0 and
            skillchainTier > 0
        then
            petAccBonus = petAccBonus + 25
        end
    end

    -- Multipliers.
    local sdt                         = xi.spells.damage.calculateSDT(target, actionElement)
    local resist                      = xi.mobskills.applyPlayerResistance(actor, nil, target, actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), petAccBonus, actionElement)
    local dayAndWeather               = xi.spells.damage.calculateDayAndWeather(actor, 0, actionElement)
    local magicBonusDiff              = xi.spells.damage.calculateMagicBonusDiff(actor, target, 0, 0, actionElement)
    local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(target, actionElement)

    -- Calculate final damage.
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * resist)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * targetMagicDamageAdjustment)
    finalDamage = math.floor(finalDamage * damageModifier)

    if target:hasStatusEffect(xi.effect.YAEGASUMI) then
        local yaegasumiEffect      = target:getStatusEffect(xi.effect.YAEGASUMI)
        local yaegasumiEffectPower = yaegasumiEffect:getPower()

        finalDamage  = 0
        yaegasumiEffect:setPower(yaegasumiEffectPower + 1)
        action:setMsg(xi.msg.basic.EVADES)
    end

    --Handle Magic Stoneskin - Umeboshi
    local magicSS = target:getMod(xi.mod.MAGIC_STONESKIN)
    if magicSS > 0 then
        if finalDamage >= magicSS then
            target:setMod(xi.mod.MAGIC_STONESKIN, 0)
            finalDamage = finalDamage - magicSS
        else
            target:setMod(xi.mod.MAGIC_STONESKIN, magicSS - finalDamage)
            finalDamage = 0
        end
    end

    -- magical mob skills are single hit so provide single Melee hit TP return if primary target
    -- TODO: This should probably be moved to AFTER all damage is calculated, since this is not the final step.
    if finalDamage > 0 and action:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(actor, target)
        actor:addTP(tpReturn)
    end

    return finalDamage
end

-- effect = xi.effect.WHATEVER if enfeeble
-- statmod = the stat to account for resist (INT, MND, etc) e.g. xi.mod.INT
-- This determines how much the monsters ability resists on the player.
xi.mobskills.applyPlayerResistance = function(actor, effect, target, diff, bonusMacc, element)
    local isEnfeeble = false

    if
        effect and
        effect > 0
    then
        isEnfeeble = true
    end

    if not bonusMacc then
        bonusMacc = 0
    end

    if diff > 10 then
        bonusMacc = bonusMacc + 10 + (diff - 10) / 2
    else
        bonusMacc = bonusMacc + diff
    end

    local magicAcc     = xi.combat.magicHitRate.calculateNonSpellMagicAccuracy(actor, target, 0, xi.skill.NONE, element, bonusMacc)
    local magicEva     = xi.combat.magicHitRate.calculateTargetMagicEvasion(actor, target, element, isEnfeeble, 0, 0) -- false = not an enfeeble.
    local magicHitRate = xi.combat.magicHitRate.calculateMagicHitRate(magicAcc, magicEva)
    local resistRate   = xi.combat.magicHitRate.calculateResistRate(actor, target, xi.skill.NONE, element, magicHitRate, 0)

    return resistRate
end

xi.mobskills.mobAddBonuses = function(actor, target, damage, element, skill) -- used for SMN magical bloodpacts, despite the name.
    local burst = xi.mobskills.calculateMobMagicBurst(actor, element, target)

    if
        skill and
        burst > 1 and
        actor:getPetID() > 0 -- all pets except charmed pets can get magic burst message, but only with petskill action
    then
        skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
    end

    damage = math.floor(damage * burst)

    return damage
end

-- Calculates breath damage
-- mob is a mob reference to get hp and lvl
-- percent is the percentage to take from HP
-- base is calculated from main level to create a minimum
-- Equation: (HP * percent) + (LVL / base)
-- cap is optional, defines a maximum damage
xi.mobskills.mobBreathMove = function(mob, target, skill, percent, base, element, cap)
    local damage = (mob:getHP() * percent) + (mob:getMainLvl() / base)

    if not cap then
        -- cap max damage
        cap = math.floor(mob:getHP() / 5)
    end

    -- Deal bonus damage vs mob ecosystem
    local systemBonus = utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem())
    damage = damage + damage * (systemBonus * 0.25)
    damage = utils.clamp(damage, 1, cap)

    -- elemental resistence
    if element and element > 0 then
        -- no skill available, pass nil
        local resist  = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, element)
        local defense = getElementalDamageReduction(target, element)

        damage = damage * resist * defense
    end

    damage = utils.clamp(damage, 1, cap)

    local liement = target:checkLiementAbsorb(xi.damageType.ELEMENTAL + element) -- check for Liement.
    if liement < 0 then -- skip BDT/DT etc for Liement if we absorb.
        return math.floor(damage * liement)
    end

    -- The values set for this modifiers are base 10000.
    -- -2500 in item_mods.sql means -25% damage recived.
    -- 2500 would mean 25% ADDITIONAL damage taken.
    -- The effects of the "Shell" spells are also included in this step. The effect also aplies a negative value.

    local globalDamageTaken   = target:getMod(xi.mod.DMG) / 10000          -- Mod is base 10000
    local breathDamageTaken   = target:getMod(xi.mod.DMGBREATH) / 10000    -- Mod is base 10000
    local combinedDamageTaken = 1.0 + utils.clamp(breathDamageTaken + globalDamageTaken, -0.5, 0.5) -- The combination of regular "Damage Taken" and "Breath Damage Taken" caps at 50%. There is no BDTII known as of yet.

    damage = math.floor(damage * combinedDamageTaken)

    -- Handle Phalanx
    if damage > 0 then
        damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle Stoneskin
    if damage > 0 then
        damage = utils.clamp(utils.stoneskin(target, damage), -99999, 99999)
    end

    --Handle Magic Stoneskin - Umeboshi
    local magicSS = target:getMod(xi.mod.MAGIC_STONESKIN)
    if magicSS > 0 then
        if damage >= magicSS then
            target:setMod(xi.mod.MAGIC_STONESKIN, 0)
            damage = damage - magicSS
        else
            target:setMod(xi.mod.MAGIC_STONESKIN, magicSS - damage)
            damage = 0
        end
    end

    if mob:getMobMod(xi.mobMod.BREATH_ATTACK_LINEAR) == 1 then
        local mobScalingHP = mob:getMaxHP() / mob:getHP()
        damage = (damage / mobScalingHP)
    end

    if target:hasStatusEffect(xi.effect.YAEGASUMI) then
        local yaegasumiEffect      = target:getStatusEffect(xi.effect.YAEGASUMI)
        local yaegasumiEffectPower = yaegasumiEffect:getPower()
        damage = 0
        yaegasumiEffect:setPower(yaegasumiEffectPower + 1)
        skill:setMsg(xi.msg.basic.EVADES)
    end

    -- breath mob skills are single hit so provide single Melee hit TP return if primary target
    if damage > 0 and skill:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(mob, target)
        mob:addTP(tpReturn)
    end

    return damage
end

xi.mobskills.mobFinalAdjustments = function(dmg, mob, skill, target, attackType, damageType, shadowbehav)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end

    -- physical attack missed, skip rest
    if skill:hasMissMsg() then
        return 0
    end

    --handle pd
    if
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        attackType == xi.attackType.PHYSICAL
    then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    if mob:getCurrentAction() == xi.action.PET_MOBABILITY_FINISH then
        if skill:getMsg() ~= xi.msg.basic.JA_MAGIC_BURST then
            skill:setMsg(xi.msg.basic.USES_JA_TAKE_DAMAGE)
        end
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    --Handle shadows depending on shadow behaviour / attackType
    if
        shadowbehav ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowbehav ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then --remove 'shadowbehav' shadows.

        if skill:isAoE() or skill:isConal() then
            shadowbehav = MobTakeAoEShadow(mob, target, shadowbehav)
        end

        dmg = utils.takeShadows(target, dmg, shadowbehav)

        -- dealt zero damage, so shadows took hit
        if dmg == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
            return shadowbehav
        end

    elseif shadowbehav == xi.mobskills.shadowBehavior.WIPE_SHADOWS then --take em all!
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    if
        attackType == xi.attackType.PHYSICAL or
        attackType == xi.attackType.RANGED
    then
        if not skill:isSingle() then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        -- Handle Third Eye using shadowbehav as a guide.
        if utils.thirdeye(target) then
            skill:setMsg(xi.msg.basic.ANTICIPATE)

            return 0
        end
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    if target:getMod(xi.mod.AUTO_ANALYZER) > 0 then
        local analyzerSkill = target:getLocalVar('analyzer_skill')
        local analyzerHits = target:getLocalVar('analyzer_hits')
        if
            analyzerSkill == skill:getID() and
            target:getMod(xi.mod.AUTO_ANALYZER) > analyzerHits
        then
            -- Successfully mitigating damage at a fixed 40%
            dmg = dmg * 0.6
            analyzerHits = analyzerHits + 1
        else
            target:setLocalVar('analyzer_skill', skill:getID())
            analyzerHits = 0
        end

        target:setLocalVar('analyzer_hits', analyzerHits)
    end

    if attackType == xi.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(dmg, damageType)
    elseif attackType == xi.attackType.MAGICAL then
        dmg = target:magicDmgTaken(dmg, damageType - xi.damageType.ELEMENTAL)
    elseif attackType == xi.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg)
    elseif attackType == xi.attackType.RANGED then
        dmg = target:rangedDmgTaken(dmg)
    end

    if dmg < 0 then
        return dmg
    end

    -- Handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    if attackType == xi.attackType.MAGICAL then
        dmg = utils.oneforall(target, dmg)

        if dmg < 0 then
            return 0
        end
    end

    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:updateEnmityFromDamage(mob, dmg)
        target:handleAfflatusMiseryDamage(dmg)
    end

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
xi.mobskills.mobPhysicalHit = function(skill)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:hasMissMsg() == false
end

xi.mobskills.mobDrainMove = function(mob, target, drainType, drain, attackType, damageType)
    if not target:isUndead() then
        if drainType == xi.mobskills.drainType.MP then
            drain = math.min(drain, target:getMP())

            target:delMP(drain)
            mob:addMP(drain)

            return xi.msg.basic.SKILL_DRAIN_MP
        elseif drainType == xi.mobskills.drainType.TP then
            drain = math.min(drain, target:getTP())

            target:delTP(drain)
            mob:addTP(drain)

            return xi.msg.basic.SKILL_DRAIN_TP
        elseif drainType == xi.mobskills.drainType.HP then
            drain = math.min(drain, target:getHP())

            target:takeDamage(drain, mob, attackType, damageType)
            mob:addHP(drain)

            return xi.msg.basic.SKILL_DRAIN_HP
        end
    else
        drain = math.min(drain, target:getHP())

        target:takeDamage(drain, mob, attackType, damageType)
        return xi.msg.basic.DAMAGE
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobPhysicalDrainMove = function(mob, target, skill, drainType, drain)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        return xi.msg.basic.NONE
    end

    if xi.mobskills.mobPhysicalHit(skill) then
        return xi.mobskills.mobDrainMove(mob, target, drainType, drain)
    end

    return xi.msg.basic.SKILL_MISS
end

local drainEffectCorrelation =
{
    [xi.effect.STR_DOWN] = xi.effect.STR_BOOST,
    [xi.effect.DEX_DOWN] = xi.effect.DEX_BOOST,
    [xi.effect.AGI_DOWN] = xi.effect.AGI_BOOST,
    [xi.effect.VIT_DOWN] = xi.effect.VIT_BOOST,
    [xi.effect.MND_DOWN] = xi.effect.MND_BOOST,
    [xi.effect.INT_DOWN] = xi.effect.INT_BOOST,
    [xi.effect.CHR_DOWN] = xi.effect.CHR_BOOST,
}

xi.mobskills.mobDrainAttribute = function(mob, target, typeEffect, power, tick, duration)
    if not drainEffectCorrelation[typeEffect] then
        return xi.msg.basic.SKILL_NO_EFFECT
    end

    local results = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

    if results == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:addStatusEffect(drainEffectCorrelation[typeEffect], power, tick, duration)

        return xi.msg.basic.ATTR_DRAINED
    end

    return xi.msg.basic.SKILL_MISS
end

xi.mobskills.mobDrainStatusEffectMove = function(mob, target)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        return xi.msg.basic.NONE
    end

    -- try to drain buff
    local effect = mob:stealStatusEffect(target)

    if effect ~= 0 then
        return xi.msg.basic.EFFECT_DRAINED
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

-- Adds a status effect to a target
xi.mobskills.mobStatusEffectMove = function(mob, target, typeEffect, power, tick, duration, subType, subPower, tier)
    if target:canGainStatusEffect(typeEffect, power) then
        local statmod = xi.mod.INT
        local element = mob:getStatusEffectElement(typeEffect)
        local resist  = xi.mobskills.applyPlayerResistance(mob, typeEffect, target, mob:getStat(statmod)-target:getStat(statmod), 0, element)

        if resist >= 0.25 then
            local totalDuration = utils.clamp(duration * resist, 1)
            target:addStatusEffect(typeEffect, power, tick, totalDuration, subType, subPower, tier)

            return xi.msg.basic.SKILL_ENFEEB_IS
        end

        return xi.msg.basic.SKILL_MISS -- resist !
    end

    return xi.msg.basic.SKILL_NO_EFFECT -- no effect
end

-- similar to status effect move except, this will not land if the attack missed
xi.mobskills.mobPhysicalStatusEffectMove = function(mob, target, skill, typeEffect, power, tick, duration)
    if xi.mobskills.mobPhysicalHit(skill) then
        return xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return xi.msg.basic.SKILL_MISS
end

-- similar to statuseffect move except it will only take effect if facing
xi.mobskills.mobGazeMove = function(mob, target, typeEffect, power, tick, duration)
    if
        target:isFacing(mob) and
        mob:isInfront(target)
    then
        return xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobBuffMove = function(mob, typeEffect, power, tick, duration, subType, subPower)

    if subType == nil then
        subType = 0
    end

    if subPower == nil then
        subPower = 0
    end
    if mob:addStatusEffect(typeEffect, power, tick, duration, subType, subPower) then
        return xi.msg.basic.SKILL_GAIN_EFFECT
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobHealMove = function(target, healAmount)
    healAmount = math.min(healAmount, target:getMaxHP() - target:getHP())

    target:wakeUp()
    target:addHP(healAmount)

    return healAmount
end

xi.mobskills.calculateDuration = function(tp, minimum, maximum)
    if tp <= 1000 then
        return minimum
    end

    return minimum + (maximum - minimum) * ((tp - 1000) / 1000)
end

--[[xi.mobskills.ftP = function(tp, ftp100, ftp200, ftp300)
    tp = math.max(tp, 1000)

    if tp >= 1000 and tp < 2000 then
        return ftp100 + (((ftp200 - ftp100) / 1000) * (tp - 1000))
    elseif tp >= 2000 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp200 + (((ftp300 - ftp200) / 1000) * (tp - 2000))
    else
        print("fTP error: TP value is not between 1000-3000!")
    end

    return (ftp100 / 2) -- fail safe
end]]


xi.mobskills.fTP = function(tp, ftp1, ftp2, ftp3)
    tp = math.max(tp, 1000)

    if tp >= 1000 and tp < 1500 then
        return ftp1 + (((ftp2 - ftp1) / 500) * (tp - 1000))
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (((ftp3 - ftp2) / 1500) * (tp - 1500))
    end

    return 1 -- no ftp mod
end

xi.mobskills.fSTR = function(atk_str, def_vit)
    local fSTR = math.floor((atk_str - def_vit + 4) / 4)

    return utils.clamp(fSTR, -20, 24)
end

xi.mobskills.fSTR2 = function(atk_str, def_vit)
    local fSTR = math.floor((atk_str - def_vit + 4) / 2)

    return utils.clamp(fSTR, -20, 24)
end


xi.mobskills.handleMobBurstMsg = function(mob, target, skill, element)
    if element and element ~= xi.element.NONE then
        local magicBurst = xi.mobskills.calculateMobMagicBurst(mob, element, target)
        if target:hasStatusEffect(xi.effect.SKILLCHAIN) and (magicBurst > 1) then -- Gated as this is run per target.
            skill:setMsg(xi.msg.basic.PET_MAGIC_BURST)
        end
    end
end