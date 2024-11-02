-----------------------------------
-- xi.effect.CASCADE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Main Damage modifiers handled in damage_spell.lua
    effect:addMod(xi.mod.MAGIC_DAMAGE, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
