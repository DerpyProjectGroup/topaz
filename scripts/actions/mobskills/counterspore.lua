-----------------------------------
-- Counterspore (datmod)
-- Deals ranged water damage that causes knockback.
-- Used by pugils in BCNM: Shooting Fish
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    skill:setMsg(xi.msg.basic.HIT_DMG)
    return damage
end

return mobskillObject
