-----------------------------------
-- Pestilent Plume
-- Deals Dark damage to targets in front of mob. Additional Effect: Plague, Blind, Magic Defense Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    local power = mob:getMainLvl() / 4 * 0.6 + 7
    local duration = math.random(30, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, power, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 50, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 50, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 50, 0, duration)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end

return mobskillObject
