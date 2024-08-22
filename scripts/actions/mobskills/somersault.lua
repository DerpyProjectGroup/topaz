-----------------------------------
-- Name: Somersault
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Single Target Attack
-- Notes: not known if multiplier based on TP
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 1
    local accmod    = 1
    local dmgmod    = 1.0
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.NONE
    local crit      = 0.00
    local attmod    = 1.50
    local info      = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 2.5, 3, tpEffect2, 1, 1, 1, crit, attmod)
    local dmg       = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
