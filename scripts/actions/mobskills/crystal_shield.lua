-----------------------------------
-- Crystal Shield
-- Protect II
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 50
    if mob:getName() == 'Lost_Suttung' then
        power = 100
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, power, 0, 300))

    return xi.effect.PROTECT
end

return mobskillObject
