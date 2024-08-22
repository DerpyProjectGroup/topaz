-----------------------------------
--  Needleshot
--  Description: Fires a needle at a single target.
--  Type: Ranged
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Unknown
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 1
    local accmod    = 0.8
    local dmgmod    = 2
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.RANGED
    local crit      = 0.00
    local attmod    = 1.0
    local info      = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 2.5, 3, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg       = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    
    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.TRANSFIXION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end
    
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
