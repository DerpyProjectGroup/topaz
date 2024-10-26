-----------------------------------
-- xi.effect.PROWESS
-- Increased combat and magic skill gain
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.COMBAT_SKILLUP_RATE, effect:getPower())
        effect:addMod(xi.mod.MAGIC_SKILLUP_RATE, effect:getPower())
    else
        effect:addMod(xi.mod.COMBAT_SKILLUP_RATE, 0)
        effect:addMod(xi.mod.MAGIC_SKILLUP_RATE, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
