-----------------------------------
--  Chaos Blade
--
--  Description: Deals Dark damage to enemies within a fan-shaped area. Additional effect: Curse
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores Shadows
--  Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getLocalVar('debuff_Talon') == 1
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3
    local power = 25

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 2, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    if mob:getPool() == 1100 or mob:getPool() == 1101 then
        power = mob:getLocalVar('chaosBladeLevel')
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, power, 0, 420)

    return damage
end

return mobskillObject
