-----------------------------------
-- Orcish Counterstance
-- Used only by Orcs in Wings of the Goddess Areas.
-- Certain NMs may have a higher power version of the xi.effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- local power = 10
    -- local duration = 60

    -- if Conquerer Bakgodek then
        -- power = 50? He's not implemented yet anyway :P
    -- end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 50, 0, math.random(30, 60)))

    return xi.effect.COUNTERSTANCE
end

return mobskillObject
