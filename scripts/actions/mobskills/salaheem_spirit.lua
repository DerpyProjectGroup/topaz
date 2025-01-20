-----------------------------------
-- Salaheem Spirit
-- Description: Provides a bonus to base attributes for party members in area of effect. Duration varies by TP
-- Only available to Abquhbah Trust
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 4)
    local tick = 10
    local duration = 50
    local bonusTime = math.floor(mob:getTP() / 10) + 5
    local effects = {xi.effect.STR_BOOST, xi.effect.DEX_BOOST, xi.effect.DEX_BOOST, xi.effect.AGI_BOOST, xi.effect.INT_BOOST, xi.effect.MND_BOOST, xi.effect.CHR_BOOST,}

        for i = 1, #effects do
            if target:hasStatusEffect(effects[i]) then
               target:delStatusEffect(effects[i])
               target:addStatusEffect(effects[i], power, tick, duration + bonusTime)
            end
        end

    skill:setMsg(xi.msg.basic.STATUS_BOOST_2)

    return 0
end

return mobskillObject
