-----------------------------------
-- Wing Cutter
-- Deals Wind damage to targets in a fan-shaped area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:checkDistance(mob) > 10  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end

    local damage = mob:getWeaponDmg() * 5
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 25, 0, 120)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return damage
end

return mobskillObject
