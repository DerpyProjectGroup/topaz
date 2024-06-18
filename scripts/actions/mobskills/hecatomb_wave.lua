-----------------------------------
--  Hecatomb Wave
--  Description: Deals wind damage to enemies within a fan-shaped area originating from the caster. Additional effect: Blindness.
--  Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, math.random(60, 120))

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.47, 1.5, xi.element.WIND, 260)

    if (skill:getID() == 1146) then
        dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.047, 1.5, xi.element.WIND, 260)
    end
    
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskillObject
