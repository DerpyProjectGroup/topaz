-----------------------------------
-- Call of the Moon (up)
-- Description: Self Buff, Only used while standing.
-- Allows the user to intimidate players.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
        -- animsub 1 = standing, animsub 0 = all fours
        if mob:getAnimationSub() == 0 then
            return 1
        end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(30, 60)
    local humanoidKiller = 22
    xi.mobskills.mobBuffMove(mob, xi.effect.KILLER_INSTINCT, 30, 0, duration, 0, humanoidKiller)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
