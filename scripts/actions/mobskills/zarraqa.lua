-----------------------------------
-- Ranged Attack (Trolls)
-- Deals a ranged attack to a single target.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.6

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if dmg > 0 then
        skill:setMsg(xi.msg.basic.RANGED_ATTACK_HIT)
        target:addTP(20)
        mob:addTP(80)
    else
        skill:setMsg(xi.msg.basic.RANGED_ATTACK_MISS)
    end

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
