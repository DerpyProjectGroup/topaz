-----------------------------------
-- Power Attack
-- Deals damage based off TP.
-- 100% TP: ??? / 250% TP: ??? / 300% TP: ???
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
    local crit           = 1.00
    local attmod         = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 1.25, 2.25, 3.25, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.REVERBERATION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    return dmg
end

return mobskillObject
