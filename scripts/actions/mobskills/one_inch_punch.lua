-----------------------------------
-- One-Inch Punch
-- Description: Damage varies with TP.
-- Type: Physical
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local modifier = (target:getMod(xi.mod.DEF) / 150)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5 + modifier
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    return dmg
end

return mobskillObject
