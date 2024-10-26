-----------------------------------
-- xi.effect.PROWESS
-- Increased treasure casket discovery.
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
    -- This might not be % in retail. If not a % just change ATTP to just ATT
    effect:addMod(xi.mod.ATT, effect:getPower())
    effect:addMod(xi.mod.RATT, effect:getPower())
    else
        effect:addMod(xi.mod.ATT, 0)
        effect:addMod(xi.mod.RATT, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
