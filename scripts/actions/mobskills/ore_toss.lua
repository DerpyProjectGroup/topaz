-----------------------------------
--  Ore Toss
--
--  Description: Deals high damage in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: Yes
--  Range: Unknown range
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits  = 1
    local accmod   = 1
    local distance = mob:checkDistance(target)
    -- xi.mobskills.calculate_fTP(distance, min_fTP, mid_fTP, max_fTP, min_distance, mid_distance, max_distance)
    local dmgmod   = xi.mobskills.calculate_fTP(distance, 1, 2, 3, 0, 5, 10)

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)

    if (skill:getID()==1123) then
        -- Skill ID is Ore Toss used by Dynamis Quadavs as a ranged attack.
        -- against a 298 defense character - dmgmod of 1 produces hits of low 100s to high 100s by Masons in Bastok.
        dmgmod = 1
        info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)

    return dmg
end

return mobskillObject
