-----------------------------------
-- Thunder Break
-- Channels the power of Thunder toward targets in an area of effect. Additional effect: Stun
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 3.2)
    local dmgmod = 1
    if mob:getName() == 'Lost_Suttung' then
        dmgmod = 1.5
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    return damage
end

return mobskillObject
