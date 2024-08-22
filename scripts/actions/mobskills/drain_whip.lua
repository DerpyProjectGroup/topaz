-----------------------------------
-- Drain Whip
-- Description: Drains HP, MP, or TP from the target.
-- Type: Magical
-- Utsusemi/Blink absorb: ignores shadows
-- Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage      = mob:getWeaponDmg() * 3
    local drainTable  = { xi.mobskills.drainType.HP, xi.mobskills.drainType.MP, xi.mobskills.drainType.TP }
    local numhits     = 1
    local accmod      = 1
    local dmgmod      = 1.0
    local tpEffect1   = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2   = xi.mobskills.physicalTpBonus.NONE
    local crit        = 0.00
    local attmod      = 1.0
    local info        = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 3, 5, 6, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg         = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    local rnd         = math.random(1, 3)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, drainTable[math.random(1, 3)], damage))

    return damage
end

return mobskillObject
