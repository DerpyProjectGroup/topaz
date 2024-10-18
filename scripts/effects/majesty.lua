-----------------------------------
-- xi.effect.MAJESTY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CURE_POTENCY_II, effect:getPower())
    effect:addMod(xi.mod.WHITE_MAGIC_RECAST, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
