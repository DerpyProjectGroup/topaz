-----------------------------------
--  Maelstrom
--  Description: Deals water damage to enemies within range. Additional effect: STR Down.
--  Type: Magical (Water)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 3.5)
    local dmgmod = 1

    if mob:getName() == 'Scolopendra' then
        dmgmod = 2
    elseif mob:getName() == 'Lost_Scolopendra' then
        dmgmod = 3
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return damage
end

return mobskillObject
