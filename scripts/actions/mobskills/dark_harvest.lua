-----------------------------------
--  Type: Magical (Dark)
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1, 2, 3)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end

return mobskillObject
