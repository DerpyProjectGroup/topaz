-----------------------------------
-- xi.effect.COUNTERSTANCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.COUNTER, effect:getPower())
    effect:addMod(xi.mod.DEFP, -effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
