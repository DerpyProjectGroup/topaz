-----------------------------------
-- Venom Breath
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if  target:checkDistance(mob) > 10  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end

    local damage = mob:getWeaponDmg() * 4
    local dmgmod   = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGIC, xi.damageType.WATER)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2500, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120)
    
    return damage
end

return mobskillObject
