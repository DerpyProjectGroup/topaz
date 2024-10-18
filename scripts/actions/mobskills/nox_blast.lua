-----------------------------------
--  Nox Blast
--  Description: Dark Damage (Conal Front)
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
        -- animsub 1 = standing, animsub 0 = all fours
        if mob:getAnimationSub() == 0 then
            return 1
        end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    target:setTP(0)

    return damage
end

return mobskillObject
