-----------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits            = 1
    local accmod             = 1
    local distance           = mob:checkDistance(target)
    local dmgmod             = 1
    local distanceCorrection = 1
    local trueShotMod        = mob:getMod(xi.mod.TRUE_SHOT_MODIFIER) / 100

    if mob:getMainJob() == xi.job.RNG then
        distanceCorrection = xi.combat.distanceCorrection.applyCurve(distance, xi.combat.distanceCorrection.table.LONGBOW)
        dmgmod = dmgmod * distanceCorrection
        if distanceCorrection == 1 then
            dmgmod = dmgmod + trueShotMod
        end
    elseif mob:getMainJob() == xi.job.NIN then
        distanceCorrection = xi.combat.distanceCorrection.throwing(distance)
        dmgmod = dmgmod * distanceCorrection
        if distanceCorrection == 1 then
            dmgmod = dmgmod + trueShotMod
        end
    else
        distanceCorrection = xi.combat.distanceCorrection.applyCurve(distance, xi.combat.distanceCorrection.table.CROSSBOW)
        dmgmod = dmgmod * distanceCorrection
        if distanceCorrection == 1 then
            dmgmod = dmgmod + trueShotMod
        end
    end

    local info     = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)
    local dmg      = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if
        skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB and
        skill:getMsg() ~= xi.msg.basic.ANTICIPATE
    then

        if dmg > 0 and distanceCorrection == 1.0 then
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_TRUE)
            target:addTP(20)
            mob:addTP(80)
        elseif dmg > 0 and distanceCorrection > 0.95 then
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_SQUARE)
            target:addTP(20)
            mob:addTP(80)
        elseif dmg > 0 then
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_HIT)
            target:addTP(20)
            mob:addTP(80)
        else
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_MISS)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end

return mobskillObject
