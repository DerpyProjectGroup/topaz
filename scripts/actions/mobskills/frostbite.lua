-----------------------------------
-- Frostbite
-- Great Sword weapon skill
-- Delivers an ice elemental attack. Damage varies with TP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return damage
end

return mobskillObject
