-----------------------------------
-- Charm
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 0
    local msg = xi.msg.basic.NONE

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return xi.effect.CHARM_I
    end

    if mob:getName() == 'All-seeing_Onyx_Eye' then
        msg = xi.mobskills.mobGazeMove(mob, target, xi.effect.CHARM_I, 0, 3, 5)
    else
        msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, power, 3, 150)
    end
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end

return mobskillObject
