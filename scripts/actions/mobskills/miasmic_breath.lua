-----------------------------------
-- Miasmic Breath
-- Description: A toxic odor is exhaled on any players in a fan-shaped area of effect.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' Conal
-- Notes: Only used by Cirrate Christelle
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4
    local power = 50

    if mob:getName() == 'Arch_Christelle' then
        power = 100
    end

    if mob:getLocalVar('itemDebuff_Fungus') == 0 then
        power = 25
        if mob:getName() == 'Arch_Christelle' then
            power = 75
        end
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)

    return damage
end

return mobskillObject
