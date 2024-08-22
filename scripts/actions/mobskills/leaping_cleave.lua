-----------------------------------
--  Leaping Cleave
--  Family: Qutrub
--  Description: Performs a jumping slash on a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Used only when wielding their initial sword.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 2.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = xi.mobskills.calculateDuration(mob:getTP(), 15, 30)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, duration)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    -- Zareehkl the Jubilant's Leaping Cleave
    if skill:getID() == 2363 then
        -- has a chance to stun
        if math.random() > 0.25 then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
        end

        -- does not display the regular message (mimics auto attack)
        skill:setMsg(xi.msg.basic.DAMAGE_SECONDARY)
    end

    return dmg
end

return mobskillObject
