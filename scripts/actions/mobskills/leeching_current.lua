-----------------------------------
-- Leeching Current
-- Description: Steals HP with a water current from targets in an area of effect.
-- Type: Magical (Water)
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local hpp = mob:getHPP() -- TODO: Move this to mob script?
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
    -- We use a var here so that mobs can use different values
    local base = mob:getLocalVar('leechingCurrent')
    if base == 0 then
        base = 1000
    end

    local damage = base / skill:getTotalTargets()
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.WATER)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    return damage
end

return mobskillObject
