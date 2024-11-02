-----------------------------------
-- Orcish Counterstance
-- Used only by Orcs in Wings of the Goddess Areas.
-- Certain NMs may have a higher power version of the xi.effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- consider giving this a unique effect combining the two effects
    local hastePower = 4000 -- 40% haste: https://ffxiclopedia.fandom.com/wiki/Berserker_Dance
    local defDownPower = 25
    local duration = 60
    local hasteTypeEffect = xi.effect.HASTE
    local defDownTypeEffect = xi.effect.DEFENSE_DOWN

    -- add Haste
    skill:setMsg(xi.mobskills.mobBuffMove(mob, hasteTypeEffect, hastePower, 0, duration))
    local hasteEffect = mob:getStatusEffect(hasteTypeEffect)
    if (hasteEffect) then
        hasteEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    -- add def down
    mob:addStatusEffectEx(defDownTypeEffect, 0, defDownPower, 0, duration)
    local defDownTypeEffect = mob:getStatusEffect(defDownTypeEffect)
    if (defDownTypeEffect) then
        defDownTypeEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end


    return xi.effect.HASTE
end

return mobskillObject
