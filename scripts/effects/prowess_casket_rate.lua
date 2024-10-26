-----------------------------------
-- xi.effect.PROWESS
-- Increased treasure casket discovery
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.CASKET_RATE_INCREASE, effect:getPower())
    else
        effect:addMod(xi.mod.CASKET_RATE_INCREASE, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
