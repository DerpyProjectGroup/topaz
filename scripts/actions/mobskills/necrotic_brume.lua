-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg() * 4
    local dmgmod   = 1
    local duration = math.random(10, 15)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 25, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_II, 200, 0, duration)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end

return mobskillObject
