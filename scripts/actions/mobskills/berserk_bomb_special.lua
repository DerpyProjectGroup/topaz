-----------------------------------
-- Berserk
-- Notes: This ability is used by both Big Bomb and bombs in the area
--  That drop the item to spawn Big Bomb
--
--  Berserk (Bomb Special) is observed to only be used when the bomb is in its default animation sub
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local anim = (mob:getAnimationSub() + 1) % 4

    if anim == 1 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 180))
    return xi.effect.BERSERK
end

return mobskillObject
