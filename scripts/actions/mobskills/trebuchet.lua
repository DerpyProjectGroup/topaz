-----------------------------------
-- Trebuchet
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Ranged attack only used when target is out of range
    if mob:checkDistance(target) > 6 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits            = 1
    local accmod             = 1
    local distance           = mob:checkDistance(target)
    local dmgmod             = 3.0
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

    local info    = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)
    if dmg > 0 then
        target:addTP(20)
        mob:addTP(80)
    end

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
