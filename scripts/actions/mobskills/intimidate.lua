-----------------------------------
-- Intimidate
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power      = 2500
    local duration   = 120
    local master     = mob:getMaster()
    local skillID    = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 90
            duration = math.max(140, duration * (tp/1000)) -- Minimum 2:20 minutes. Maximum 4.5 minutes.
        end
    end
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS and not mob:isPet() then
        power = 6600
    end
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLOW, power, 0, duration))
    return xi.effect.SLOW
end

return mobskillObject
