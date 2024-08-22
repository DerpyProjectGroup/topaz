---------------------------------------------
--  Impulsion
--
--  Description: Deals heavy magical damage to enemies within an area of effect. Additional effects: Petrification, Blind, and Knockback
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes Shadows
--  Note: Used by Bahamut in The Wyrmking Descends
---------------------------------------------



---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4
    local dmgmod = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.NONE, dmgmod, xi.mobskills.magicalTpBonus.TP_NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    local typeEffect1 = xi.effect.PETRIFICATION
    local typeEffect2 = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect1, 1, 0, 30)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 15, 0, 60)

    return damage
end

return mobskillObject
