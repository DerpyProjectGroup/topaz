-----------------------------------
-- Enfeebling Song Utilities
-- Used for songs that deal negative status effects upon targets.
-----------------------------------
require('scripts/globals/combat/element_tables')
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/combat/status_effect_tables')
require('scripts/globals/jobpoints')
require('scripts/globals/magicburst')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enfeebling = xi.spells.enfeebling or {}
-----------------------------------

-- Soul voice affects different songs differently.
local svType =
{
    POWER    = 1,
    DURATION = 2,
    ACCURACY = 3,
}
local soulVoiceMultiplier         = 2
local marcatoMultiplier           = 1.5
local troubadourMultiplier        = 2
local gearBoostDurationMultiplier = 0.10
local additionalClarionSeconds    = 2
local additionalTenutoSeconds     = 2

local pTable =
{   --                                                             |POWER         |
    --                                         1                   2      3    4     5         6       7                    8                       9                10                      11
    -- [Spell ID                         ] = { Effect,             Base, Mult, Cap,  Duration, Resist, Augment,             Modifier,               SoulVoice,       JobPoints,              GearAcc},

    -- Requiem (has job point effects)
    -- https://www.bg-wiki.com/ffxi/Requiem
    [xi.magic.spell.FOE_REQUIEM          ] = { xi.effect.REQUIEM,  1,    3,    999,  63,       0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_II       ] = { xi.effect.REQUIEM,  2,    3,    999,  79,       0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_III      ] = { xi.effect.REQUIEM,  3,    3,    999,  95,       0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_IV       ] = { xi.effect.REQUIEM,  4,    3,    999,  111,      0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_V        ] = { xi.effect.REQUIEM,  5,    3,    999,  127,      0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_VI       ] = { xi.effect.REQUIEM,  6,    3,    999,  143,      0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },
    [xi.magic.spell.FOE_REQUIEM_VII      ] = { xi.effect.REQUIEM,  8,    3,    999,  160,      0.5,    0,                   xi.mod.REQUIEM_EFFECT,  svType.POWER,    xi.jp.REQUIEM_EFFECT,   false },

    -- Lullaby (has job point effects)
    -- https://www.bg-wiki.com/ffxi/Category:Lullaby
    [xi.magic.spell.FOE_LULLABY          ] = { xi.effect.SLEEP_I,  1,    0,    1,    30,       0.5,    0,                   xi.mod.LULLABY_EFFECT,  svType.ACCURACY, xi.jp.LULLABY_DURATION, true },
    [xi.magic.spell.FOE_LULLABY_II       ] = { xi.effect.SLEEP_I,  1,    0,    1,    60,       0.5,    0,                   xi.mod.LULLABY_EFFECT,  svType.ACCURACY, xi.jp.LULLABY_DURATION, true },
    [xi.magic.spell.HORDE_LULLABY        ] = { xi.effect.SLEEP_I,  1,    0,    1,    30,       0.5,    0,                   xi.mod.LULLABY_EFFECT,  svType.ACCURACY, xi.jp.LULLABY_DURATION, true },
    [xi.magic.spell.HORDE_LULLABY_II     ] = { xi.effect.SLEEP_I,  1,    0,    1,    60,       0.5,    0,                   xi.mod.LULLABY_EFFECT,  svType.ACCURACY, xi.jp.LULLABY_DURATION, true },

    -- Finale
    -- https://www.bg-wiki.com/ffxi/Category:Finale
    [xi.magic.spell.MAGIC_FINALE         ] = { xi.effect.NONE,     1,    1,    1,    0,        0.9375, 0,                   xi.mod.FINALE_EFFECT,   svType.ACCURACY, 0,                      true },

    -- Elegy
    -- https://www.bg-wiki.com/ffxi/Category:Elegy
    [xi.magic.spell.BATTLEFIELD_ELEGY    ] = { xi.effect.ELEGY,    2500, 249,  5000, 120,      0.5,    0,                   xi.mod.ELEGY_EFFECT,    svType.POWER,    0,                      false },
    [xi.magic.spell.CARNAGE_ELEGY        ] = { xi.effect.ELEGY,    5000, 100,  5000, 180,      0.5,    0,                   xi.mod.ELEGY_EFFECT,    svType.POWER,    0,                      false },

    -- Threnody
    -- https://www.bg-wiki.com/ffxi/Category:Threnody
    [xi.magic.spell.FIRE_THRENODY        ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.FIRE_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.ICE_THRENODY         ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.ICE_MEVA,     xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.WIND_THRENODY        ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.WIND_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.EARTH_THRENODY       ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.EARTH_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.LIGHTNING_THRENODY   ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.THUNDER_MEVA, xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.WATER_THRENODY       ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.WATER_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.LIGHT_THRENODY       ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.LIGHT_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.DARK_THRENODY        ] = { xi.effect.THRENODY, 50,   5,    95,   60,       0.5,    xi.mod.DARK_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.FIRE_THRENODY_II     ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.FIRE_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.ICE_THRENODY_II      ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.ICE_MEVA,     xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.WIND_THRENODY_II     ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.WIND_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.EARTH_THRENODY_II    ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.EARTH_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.LIGHTNING_THRENODY_II] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.THUNDER_MEVA, xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.WATER_THRENODY_II    ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.WATER_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.LIGHT_THRENODY_II    ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.LIGHT_MEVA,   xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },
    [xi.magic.spell.DARK_THRENODY_II     ] = { xi.effect.THRENODY, 160,  5,    205,  90,       0.5,    xi.mod.DARK_MEVA,    xi.mod.THRENODY_EFFECT, svType.POWER,    0,                      false },

    -- Virelai
    [xi.magic.spell.MAIDENS_VIRELAI      ] = { xi.effect.CHARM_I,  0,    0,    0,    30,       0.5,    0,                   xi.mod.VIRELAI_EFFECT,  svType.ACCURACY, 0,                      true },

    -- Nocturne
    [xi.magic.spell.PINING_NOCTURNE      ] = { xi.effect.NOCTURNE, 15,   1.5,  25,   120,      0.5,    0,                   0,                      svType.POWER,    0,                      true },
}

-----------------------------------
-- Casts an enfeebling song.
-- TODO: https://github.com/LandSandBoat/server/pull/6677#issuecomment-2580655974
-----------------------------------
---@param caster CBaseEntity
---@param target CBaseEntity
---@param spell CSpell
---@return xi.effect
-----------------------------------
xi.spells.enfeebling.useEnfeeblingSong = function(caster, target, spell)
    local spellId         = spell:getID()
    local spellEffect     = pTable[spellId][1]
    local resistThreshold = pTable[spellId][6]
    local augmentStat     = pTable[spellId][7]
    local songModifier    = pTable[spellId][8]
    local soulVoiceType   = pTable[spellId][9]
    local jobPointEffect  = pTable[spellId][10]
    local spellElement    = spell:getElement()
    local spellGroup      = xi.magic.spellGroup.SONG
    local skillType       = xi.skill.SINGING
    local spellStat       = xi.mod.CHR
    local bonusMagicAcc   = 0
    local dotTick         = 0

    -- Check the amount of Song+ and All_Song+ gear.
    local gearBoost = caster:getMod(songModifier) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

    ------------------------------
    -- STEP 1: Check spell nullification.
    ------------------------------
    if xi.spells.enfeebling.handleEffectNullification(caster, target, spell, spellEffect) then
        return spellEffect
    end

    ------------------------------
    -- STEP 2: Check if spell resists.
    -- Songs cannot Immunobreak. (https://www.bg-wiki.com/ffxi/Category:Enfeebling_Magic#Immunobreak)
    -- TODO: Add BRD job point support to magicAccuracyFromJobPoints in magic_hit_rate.lua. (https://www.bg-wiki.com/ffxi/Bard#Job_Points)
    -- TODO: Add Troubadour support to magicAccuracyFromMerits in magic_hit_rate.lua. (https://www.bg-wiki.com/ffxi/Troubadour)
    ------------------------------
    -- Finale has innate +175 to magic accuracy.
    -- https://www.bg-wiki.com/ffxi/Magic_Finale
    if spellEffect == xi.effect.NONE then
        bonusMagicAcc = 175
    end

    local resistRate = xi.combat.magicHitRate.calculateResistRate(caster, target, spellGroup, skillType, 0, spellElement, spellStat, spellEffect, bonusMagicAcc)
    if resistRate < resistThreshold then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return spellEffect
    end

    ------------------------------
    -- STEP 3: Calculate power and duration.
    ------------------------------
    local power    = xi.spells.enfeebling.calculateSongPower(caster, spellId, gearBoost, jobPointEffect, spellEffect, soulVoiceType) or 0
    local duration = xi.spells.enfeebling.calculateSongDuration(caster, spellId, gearBoost, jobPointEffect, spellEffect, soulVoiceType) or 0

    ------------------------------
    -- STEP 4: Special cases.
    ------------------------------
    local finalValues = xi.spells.enfeebling.processSongExceptions(caster, target, spell, power, duration, dotTick, resistRate, spellEffect)
    if finalValues.earlyQuit then
        return finalValues.effect
    end

    ------------------------------
    -- STEP 5: Attempt to apply the status effect. Check for magic burst.
    ------------------------------
    if target:addStatusEffect(finalValues.effect, finalValues.power, finalValues.dotTick, finalValues.duration, 0, augmentStat) then
        local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target)
        if skillchainCount > 0 then
            spell:setMsg(xi.msg.basic.MAGIC_BURST_ENFEEB)
            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        else
            -- Lullaby has a different application message than the rest of the song debuffs.
            if finalValues.effect == xi.effect.SLEEP_I then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            end
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return finalValues.effect
end

-----------------------------------
-- Calculates song power.
-----------------------------------
---@param caster CBaseEntity
---@param spellId xi.magic.spell
---@param gearBoost integer the amount of Song+ and All Song from gear
---@param jobPointType integer TODO: This is not enum'd yet.
---@param spellEffect xi.effect
---@param soulVoiceType integer
---@return number
-----------------------------------
xi.spells.enfeebling.calculateSongPower = function(caster, spellId, gearBoost, jobPointType, spellEffect, soulVoiceType)
    local power          = pTable[spellId][2]
    local powerBoostMult = pTable[spellId][3]
    local powerCap       = pTable[spellId][4]

    -- Boost from Song+ and All_Song+ gear.
    power = power + gearBoost * powerBoostMult

    -- Requiem gets a power boost from job points of 3 HP / tick per level.
    if spellEffect == xi.effect.REQUIEM and jobPointType ~= 0 then
        power = math.floor(power + caster:getJobPointLevel(jobPointType) * 3)
    end

    -- Apply Soul Voice or Marcato if appropriate.
    if soulVoiceType == svType.POWER then
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = power * soulVoiceMultiplier
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = power * marcatoMultiplier
        end
    end

    -- Cap power if necessary.
    power = utils.clamp(power, 0, powerCap)

    return power
end

-----------------------------------
-- Calculates song duration.
-----------------------------------
---@param caster CBaseEntity
---@param spellId xi.magic.spell
---@param gearBoost integer the amount of Song+ and All Song from gear
---@param jobPointType integer TODO: This is not enum'd yet.
---@param spellEffect xi.effect
---@param soulVoiceType integer
---@return integer
-----------------------------------
xi.spells.enfeebling.calculateSongDuration = function(caster, spellId, gearBoost, jobPointType, spellEffect, soulVoiceType)
    local duration = pTable[spellId][5]

    -- Duration boost of 10% per level of Song+ and All_Song+ gear plus song duration gear.
    duration = math.floor(duration * (1 + gearBoost * gearBoostDurationMultiplier))

    -- Job point gift duration bonus (5%) is captured by the SONG_DURATION_BONUS mod.
    -- Virelai is not affected by song duration bonus or BRD gifts.
    -- https://www.bg-wiki.com/ffxi/Category:Virelai
    local songDurationBonus = caster:getMod(xi.mod.SONG_DURATION_BONUS)
    if songDurationBonus > 0 and spellEffect ~= xi.effect.CHARM_I then
        duration = math.floor(duration * (1 + songDurationBonus / 100))
    end

    -- Lullaby gets a duration boost from job points of 1 second per level.
    if spellEffect == xi.effect.SLEEP_I and jobPointType ~= 0 then
        duration = duration + caster:getJobPointLevel(xi.jp.LULLABY_DURATION)
    end

    -- Add duration from job points for Clarion Call and Tenuto.
    if caster:hasStatusEffect(xi.effect.CLARION_CALL) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * additionalClarionSeconds)
    end

    if caster:hasStatusEffect(xi.effect.TENUTO) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.TENUTO_EFFECT) * additionalTenutoSeconds)
    end

    -- Apply Soul Voice or Marcato if appropriate.
    if soulVoiceType == svType.DURATION then
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            duration = math.floor(duration * soulVoiceMultiplier)

        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            duration = math.floor(duration + caster:getJobPointLevel(xi.jp.MARCATO_EFFECT))
            duration = math.floor(duration * marcatoMultiplier)
            caster:delStatusEffect(xi.effect.MARCATO)
        end
    end

    -- Troubadour does not affecte Virelai.
    -- https://www.bg-wiki.com/ffxi/Category:Virelai
    if
        caster:hasStatusEffect(xi.effect.TROUBADOUR) and
        spellEffect ~= xi.effect.CHARM_I
    then
        duration = math.floor(duration * troubadourMultiplier)
    end

    return duration
end

-----------------------------------
-- Adjusts power, duration, etc. to account for unique song needs.
-----------------------------------
---@param caster CBaseEntity
---@param target CBaseEntity
---@param spell CSpell
---@param power number
---@param duration integer
---@param dotTick integer
---@param resistRate number
---@param spellEffect xi.effect
---@return table
-----------------------------------
xi.spells.enfeebling.processSongExceptions = function(caster, target, spell, power, duration, dotTick, resistRate, spellEffect)
    local adjustedValues =
    {
        earlyQuit = false,
        power     = power,
        duration  = duration,
        dotTick   = dotTick,
        effect    = spellEffect,
    }

    -- Requiem is a DoT.
    if spellEffect == xi.effect.REQUIEM then
        adjustedValues.dotTick = 3

    -- Threnody applies a negative effect.
    elseif spellEffect == xi.effect.THRENODY then
        adjustedValues.power = power * -1

    -- Lullaby should only have a max of 1 power.
    elseif spellEffect == xi.effect.SLEEP_I then
        adjustedValues.power = utils.clamp(power, 1, 1)

    -- Elegy has a hard cap of 50%.
    elseif spellEffect == xi.effect.ELEGY then
        adjustedValues.power = utils.clamp(power, 0, 5000)

    -- Finale doesn't apply a debuff. Quit early.
    elseif spellEffect == xi.effect.NONE then
        -- TODO: This is actually message 342 which doesn't exist currently. The wording is identical.
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        -- If nothing was dispelled then the spell had no effect.
        local dispelledEffect = target:dispelStatusEffect()
        if dispelledEffect == xi.effect.NONE then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

        adjustedValues.effect = dispelledEffect
        adjustedValues.earlyQuit = true
        return adjustedValues

    -- Virelai applies a charm. Quit early.
    -- Shadow removal is taken care of by Maiden Virelai's onMagicCastingCheck function.
    -- https://www.bg-wiki.com/ffxi/Category:Virelai
    elseif spellEffect == xi.effect.CHARM_I then
        if caster:isMob() then
            -- Mobs charm players by first adding the charm status effect to the player.
            -- Note the duration of the status effect determines the charm length.
            target:addStatusEffect(xi.effect.CHARM_I, 0, 0, duration * resistRate)
            -- The charm function below simply changes the player AI
            caster:charm(target)
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        elseif
            caster:isPC() and
            target:isMob() and
            target:getMobMod(xi.mobMod.CHARMABLE) > 0
        then
            -- Players typically charm mobs by using job_utils.beastmaster however that uses BST assumptions
            -- Therefore instead we call charm directly with a duration based on resist of the spell
            caster:charm(target, math.floor(duration * resistRate))
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end

        adjustedValues.earlyQuit = true
        return adjustedValues
    end

    return adjustedValues
end
