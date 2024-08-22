-----------------------------------
-- Frog Kick
-- Deals damage to a single target.
-- Type: Physical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
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
    local tpEffect2 = xi.mobskills.physicalTpBonus.ATK_VARIES
    local crit      = 0.00
    local attmod    = 1

    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 2.3, 2.6, tpEffect2, 1.25, 2.25, 3.25, crit, attmod)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.COMPRESSION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
