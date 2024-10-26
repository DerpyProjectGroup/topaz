-----------------------------------
-- xi.effect.PROWESS
-- Increased weapon skill damage
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.ALL_WSDMG_ALL_HITS, effect:getPower())
    else
        effect:addMod(xi.mod.ALL_WSDMG_ALL_HITS, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
