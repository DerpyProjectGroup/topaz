-----------------------------------
-- Seismic Tail
-- Description: Crushes targets in an area of effect with its tail.
-- Type: Physical
-- Utsusemi/Blink absorb: 3 shadows
-- Range: 15' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob, 96) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local dmgmod = 1
    local tpeffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpeffect2 = xi.mobskills.physicalTpBonus.NONE
    local crit = 0.15
    local attmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, dmgmod, tpeffect1, 2, 3, 4, tpEffect2, 0, 0, 0, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    
    if mob:getName() == 'Nuhn' then
        mob:setLocalVar('Phase', 1)
        mob:setLocalVar('Changed', 1)
    end

    return dmg
end

return mobskillObject
