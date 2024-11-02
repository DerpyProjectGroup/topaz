-----------------------------------
-- Tornado Edge (Orcs)
-- Delivers a threefold attack. Additional Effects: 1st Hit: Max HP Down, 2nd Hit: Max MP Down, 3rd Hit: Max TP Down(Tp capped at 1000)
-- Effects only apply if their corresponding hits land.
-- 100% TP: ??? / 250% TP: ??? / 300% TP: ???
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 3
    local accmod    = 1
    local dmgmod    = 1
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.ENFEEB_SPECIAL
    local crit      = 0
    local attmod    = 1
    local info      = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 1, 2, 3, tpEffect2, 1, 1, 1, crit, attmod)
    local dmg       = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.WIND, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.WIND)

    -- Status Effects handled in mobskill.lua (xi.mobskills.mobPhysicalMove)

    return dmg
end

return mobskillObject
