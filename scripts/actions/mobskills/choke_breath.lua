---------------------------------------------
--  Choke Breath
--
--  Description: Damages enemies in a fan-shaped area of effect. Additional effect: Paralysis & Silence
--  Type: Magical
---------------------------------------------



---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage        = mob:getWeaponDmg() * 2
    local dmgmod        = 1
    local element       = xi.element.WIND
    local typeEffectOne = xi.effect.PARALYSIS
    local typeEffectTwo = xi.effect.SILENCE
    local resPara       = xi.mobskills.applyPlayerResistance(mob, typeEffectOne, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local resSilence    = xi.mobskills.applyPlayerResistance(mob, typeEffectTwo, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local durationOne   = 60 * resPara
    local durationTwo   = 60 * resSilence

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, element, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 0, durationOne)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, durationTwo)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return damage
end

return mobskillObject
