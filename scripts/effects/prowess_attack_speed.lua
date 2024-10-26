-----------------------------------
-- xi.effect.PROWESS
-- Increased attack speed
-- Note: Doesn't alter TP gain like -delay would, and
-- doesn't alter JA timers like other sources of haste.
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.HASTE_ABILITY, effect:getPower())
    else
        effect:addMod(xi.mod.HASTE_ABILITY, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
