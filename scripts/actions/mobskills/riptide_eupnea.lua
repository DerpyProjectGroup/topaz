-----------------------------------
-- Riptide Eupnea
-- Deals water damage to enemies within range. Additional effect: Max HP Down, Encumberance, Bind.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()
    local dmgmod = 4
    local power    = 33
    local duration = 120
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, power, 0, duration)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 30) -- Locks all slots but does not unequip.
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return damage
end

return mobskillObject
