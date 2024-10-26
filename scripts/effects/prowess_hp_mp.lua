-----------------------------------
-- xi.effect.PROWESS
-- Increased HP and MP
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        target:addMod(xi.mod.HPP, effect:getPower())
        target:addMod(xi.mod.MPP, effect:getPower())
    else
        target:addMod(xi.mod.HPP, 0)
        target:addMod(xi.mod.MPP, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
