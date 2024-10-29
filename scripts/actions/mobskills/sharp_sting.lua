-----------------------------------
--  Sharp Sting
--
--  Description: Deals high damage to target in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: 1 shadow
--  Range: 10' single
--  Notes: Appears to be very inaccurate.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 1
    local accmod    = 1.0
    local dmgmod    = 1.0
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.NONE
    local crit      = 0.00
    local attmod    = 1.0

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 2.75, 3.5, tpEffect2, 1, 1, 1, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
