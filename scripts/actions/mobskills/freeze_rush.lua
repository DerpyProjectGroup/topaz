-----------------------------------
--  Freeze Rush
--  Description: Makes an icy charge at a single target.
--  Type: Magical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3
    local shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    if mob:getName() == 'Nightmare_Snoll' then
        shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, 2, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, shadowBehavior)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return damage
end

return mobskillObject
