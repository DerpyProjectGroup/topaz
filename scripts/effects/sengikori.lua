-----------------------------------
-- xi.effect.SENGIKORI
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Effect handled in core (battleutils), lua (Weaponskills/damage_spell)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
