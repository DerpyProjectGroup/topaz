-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:checkDistance(mob) > 10  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end

    local damage = mob:getWeaponDmg() * 5
    local dmgmod   = 1
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 25, 3, 120)
    
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return damage
end

return mobskillObject
