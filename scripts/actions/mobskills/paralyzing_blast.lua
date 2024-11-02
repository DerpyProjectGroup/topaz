-----------------------------------
--  Paralyzing Blast (Tube)
--  Description: Paralyzes targets in range.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 60))

    return xi.effect.PARALYSIS
end

return mobskillObject
