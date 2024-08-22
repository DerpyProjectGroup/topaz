-----------------------------------
-- Rending Deluge
-- Deals water damage to enemies within range. Additional effect: Dispel.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()
    local numDispels = 0

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    if damage > 0 then
        numDispels = math.random(1, 3)
    end

    for i = 1, numDispels do
        target:dispelStatusEffect()
    end

    return damage
end

return mobskillObject
