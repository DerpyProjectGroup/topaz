-----------------------------------
-- Heat Wave
-- Applies potent Burn effect to targets in range
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 2.05)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 180)

    return xi.effect.BURN
end

return mobskillObject
