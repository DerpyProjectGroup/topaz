-----------------------------------
-- Brain Drain
-- Deals damage to a single target. Additional effect: INT Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()
    local dmgmod = 1
    local power = target:getStat(xi.mod.INT) * 0.25
    
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, power, 10, 120)
    mob:addStatusEffect(xi.effect.INT_BOOST, power, 10, 120)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return damage
end

return mobskillObject
