-----------------------------------
-- Smouldering Swarm
-- Deals Fire damage to targets around the mob. Additional Effect: Burn
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 5
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    local power = mob:getMainLvl() / 4 * 0.6 + 7
    local duration = math.random(30, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, duration)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return damage
end

return mobskillObject
