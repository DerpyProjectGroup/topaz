-----------------------------------
-- Hypnic Lamp
-- Description: Attempts to hypnotize targets in an area of effect.
-- Type: Enfeebling
-- Notes: Can't use this if its eyestalks are destroyed.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        if mob:getID() == 16998874 then -- TODO: Shift Proof This
            if math.random(1,100) > 50 then
                return 0
            else
                return 1
            end
        end
    else
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getID() == 16998874 then
        mob:setLocalVar('Phase', 2)
        mob:setLocalVar('Changed',1)
    end
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 120, 180)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end

return mobskillObject
