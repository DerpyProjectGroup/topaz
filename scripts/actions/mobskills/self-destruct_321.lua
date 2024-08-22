-----------------------------------
-- self_destruct_321
-- Weapon skill for Time Bomb (BCNM 50 3, 2, 1...)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = 99999

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return damage
end

return mobskillObject
