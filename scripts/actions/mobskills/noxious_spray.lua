-----------------------------------
--  Noxious Spray (Tube)
--  Description: Poisons targets in range.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 30, 3, 60))

    return xi.effect.POISON
end

return mobskillObject
