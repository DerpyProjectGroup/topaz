-----------------------------------
-- Rhino_Attack
-- Deals damage to a single target. Additional effect: Knockback
-- Utsusemi/Blink absorb: 1 shadow
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits        = 1
    local accmod         = 1
    local dmgmod         = 1.0
    local tpEffect1      = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2      = xi.mobskills.physicalTpBonus.NONE
    local crit           = 0.00
    local attmod         = 1
    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 3, 3, 3, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg            = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local power    = 10
    local duration = 120
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, duration)
    
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
