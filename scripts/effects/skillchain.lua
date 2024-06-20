-----------------------------------
-- xi.effect.SKILLCHAIN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- If the skillchain window expires, reset to default state.
    target:setMod(xi.mod.SENGIKORI_DEBUFF, 0)
    target:setLocalVar('Sengikori_SC', 0)
end

return effectObject
