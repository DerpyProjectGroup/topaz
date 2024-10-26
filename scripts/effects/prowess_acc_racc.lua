-----------------------------------
-- xi.effect.PROWESS
-- Enhanced accuracy and ranged accuracy
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    -- This might not be % in retail. If not a % just change ACCP to just ACC
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.ACC, effect:getPower())
        effect:addMod(xi.mod.RACC, effect:getPower())
    else
        effect:addMod(xi.mod.ACC, 0)
        effect:addMod(xi.mod.RACC, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
