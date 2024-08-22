-----------------------------------
-- Acid Mist
-- Deals Water damage to enemies within an area of effect. Additional effect: Attack Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg() * 3.2
    local power    = 50
    local duration = math.random(60, 120)

    if mob:getName() == 'Nightmare_Leech' then
        power = 999
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3.2, 3.75, 4)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)

    return damage
end

return mobskillObject
