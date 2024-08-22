-----------------------------------
-- Charged Whisker
-- Deals Lightning damage to enemies within area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2.8
    local dmgmod = 1

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3, 3.75, 4)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)

    return damage
end

return mobskillObject
