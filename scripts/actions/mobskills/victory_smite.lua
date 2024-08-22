-----------------------------------
-- Victory Smite
-- Description: Delivers a fourfold attack. Chance of params.critical hit varies with TP.
-- Type: Physical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits        = 4
    local accmod         = 1
    local dmgmod         = 2.25
    local tpEffect1      = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2      = xi.mobskills.physicalTpBonus.CRIT_VARIES
    local crit           = 0.25
    local attmod         = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 1.1, 1.25, 1.45, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    return dmg
end

return mobskillObject
