-----------------------------------
-- Cacophony
-- Description:
-- Gives the user the effect of counterstance and haste
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 30, 0, 60)
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 30, 0, 60)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
