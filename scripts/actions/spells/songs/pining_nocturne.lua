-----------------------------------
-- Spell: Pining Nocturne
-- Main effect: Increases the casting time of the target.
-- Sub effect : Lowers target magic accuracy.
-- Does not stack with Addle. Is overwrriten by Addle.
-----------------------------------
---@type TSpell
local spellObject = {}

-- Soul voice affects different songs differently.
local soulVoiceBoostType =
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

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- https://www.bg-wiki.com/ffxi/Category:Nocturne
    -- TODO: Current state may be a precursor to general BRD song handling.
    -- TODO: Enhancing and Enfeeble songs should have their own separate handling (see below comment for details).
    -- TODO: https://github.com/LandSandBoat/server/pull/6677#issuecomment-2580655974

    -- Spell parameters
    local songEffect      = xi.effect.NOCTURNE
    local power           = 15
    local powerCap        = 25
    local powerBoostMult  = 1.5
    local soulVoiceType   = soulVoiceBoostType.POWER
    local duration        = 120     -- This is the base duration.
    local resistThreshold = 0.5
    local modifierStat    = 0       -- Song+ modifier.
    local augmentStat     = 0       -- Most songs only augment their own effect, but others (like Etudes) augment different stats.
    local jobPointEffect  = 0
    local dotTick         = 0

    -- Check to see if the player has any elemental affinity gear like an elemental staff.
    local actionElement     = spell:getElement()
    local elementalAccBonus = caster:getMod(xi.combat.element.elementalMagicAcc[actionElement]) + caster:getMod(xi.combat.element.strongAffinityAcc[actionElement]) * 10

    -- Check the amount of Song+ and All_Song+ gear.
    local gearBoost = caster:getMod(modifierStat) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

    -- BG Wiki doesn't say explicitly that Song+ gear affects accuracy for threnodies.
    if songEffect ~= xi.effect.THRENODY then
        elementalAccBonus = elementalAccBonus + gearBoost
    end

    -- TODO: Resistance can be modularlized.
    -- TODO: Add handling for job point song accuracy bonus (xi.jp.SONG_ACC_BONUS)
    -- TODO: Add handling for job point gifts for magic accuracy. (5 @ 60, 8 @ 360, 10 @ 910, 13 @ 1710)
    -- Check for resistance.
    local resistParams = {}
    resistParams.attribute = xi.mod.CHR
    resistParams.skillType = xi.skill.SINGING
    resistParams.bonus     = elementalAccBonus
    if applyResistanceEffect(caster, target, spell, resistParams) < resistThreshold then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return songEffect
    end

    -- TODO: Power calculation can be modularized.
    power = utils.clamp(power, 0, powerCap)     -- Cap power if necessary. (Applied before Merits, Job-Points and Status-Effects)
    power = power + gearBoost * powerBoostMult  -- Boost from Song+ and All_Song+ gear.

    -- Requiem gets a power boost from job points of 3 HP / tick per level.
    if songEffect == xi.effect.REQUIEM and jobPointEffect ~= 0 then
        power = math.floor(power + caster:getJobPointLevel(jobPointEffect) * 3)
    end

    -- Multiply power from effects that affect power like Soul Voice and Macarato.
    if soulVoiceType == soulVoiceBoostType.POWER then
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = power * soulVoiceMultiplier
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = power * marcatoMultiplier
        end
    end

    -- TODO: Song duration can be modularlized.
    -- Duration boost of 10% per level of Song+ and All_Song+ gear plus song duration gear.
    duration = math.floor(duration * (gearBoost * gearBoostDurationMultiplier + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100 + 1))

    -- Lullaby gets a duration boost from job points of 1 second per level.
    if songEffect == xi.effect.SLEEP_I and jobPointEffect ~= 0 then
        duration = duration + caster:getJobPointLevel(xi.jp.LULLABY_DURATION)
    end

    -- Add duration from job points for Clarion Call and Tenuto.
    if caster:hasStatusEffect(xi.effect.CLARION_CALL) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * additionalClarionSeconds)
    end

    if caster:hasStatusEffect(xi.effect.TENUTO) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.TENUTO_EFFECT) * additionalTenutoSeconds)
    end

    -- Soul Voice and Marcato affect different song families differently.
    if soulVoiceType == soulVoiceBoostType.DURATION then
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            duration = math.floor(duration * soulVoiceMultiplier)

        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            duration = math.floor(duration + caster:getJobPointLevel(xi.jp.MARCATO_EFFECT))
            duration = math.floor(duration * marcatoMultiplier)
            caster:delStatusEffect(xi.effect.MARCATO)
        end
    end

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = math.floor(duration * troubadourMultiplier)
    end

    -- TODO: Return to the specific spell lua here with power, duration, etc. The spell lua will apply the effects and do any spell specific work.

    -- TODO: Addle will overwrite Nocturne, but Nocturne will not overwrite ADDLE.
    -- TODO: Nocturne can be successfully applied, but the effect (nocturne.lua) is not implemented so it will not impact the mob in current state.
    -- Set spell message and apply status effect.
    if target:addStatusEffect(songEffect, power, dotTick, duration, 0, augmentStat) then
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return songEffect
end

return spellObject
