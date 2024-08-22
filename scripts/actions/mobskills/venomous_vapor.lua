-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 30, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 30, 3, 120)
    
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return damage
end

return mobskillObject
