-----------------------------------
-- xi.effect.PROWESS
-- Enhanced magic acc. and magic atk
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.MATT, effect:getPower())
        effect:addMod(xi.mod.MACC, effect:getPower())
    else
        effect:addMod(xi.mod.MATT, 0)
        effect:addMod(xi.mod.MACC, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
