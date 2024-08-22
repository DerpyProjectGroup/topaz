-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK, { breakBind = false })

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 15, 0, 120)

    return damage
end

return mobskillObject
