-----------------------------------
--  Typhoon Wing
--
--  Description: Deals darkness damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
--  Notes: Used only by Ouryu and Dragua. The blinding effect does not last long
--                but is very harsh. The attack is wide enough to generally hit an entire alliance.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()
    local dmgmod = 1
    local dmgBoost = 0

    if mob:getPool() == 3070 then -- CoP 4-2 The Savage Ouryu
        dmgBoost = 2.5
    else
        dmgBoost = 5
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage * dmgBoost, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 30)

    return damage
end

return mobskillObject
