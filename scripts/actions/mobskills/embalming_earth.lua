-----------------------------------
-- Deals Earth damage to enemies within range. Additional effect: Slow.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg() * 6
    local dmgmod   = 1
    local power    = 33
    local duration = 120
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, power, 0, duration)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return damage
end

return mobskillObject
