-----------------------------------
-- xi.effect.PROWESS
-- Increased crystal yield
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.CRYSTAL_YIELD, effect:getPower())
    else
        effect:addMod(xi.mod.CRYSTAL_YIELD, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
