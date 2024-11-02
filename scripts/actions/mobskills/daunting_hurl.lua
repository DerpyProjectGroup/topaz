-----------------------------------
-- Daunting Hurl
-- Deals a ranged attack to a single target. Additional Effect: Terror
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getName() == 'Agrios' and
        mob:getHPP() > 40
    then
        return 1
    else
        return 0
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits            = 1
    local accmod             = 1
    local dmgmod             = 1.0

    local info    = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 6, 6, 6)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    if
        skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB and
        skill:getMsg() ~= xi.msg.basic.ANTICIPATE
    then
        if dmg > 0 and mob:getName() == 'Agrios' then
            target:addTP(20)
            mob:addTP(80)
            xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.TERROR, 1, 0, 15)
            mob:resetEnmity(target)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
