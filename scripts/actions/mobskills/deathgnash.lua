-----------------------------------
-- Deathgnash
-- Description: Chomps on a single target, reducing HP to one and resets enmity.
-- Type: Physical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local hpp = mob:getHPP()
    if mob:getID() == 16998874 then
        if hpp <= 50 then
    return 0
        else
            return 1
end
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = target:getHP() - 1
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)

    return damage
end

return mobskillObject
