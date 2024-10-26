-----------------------------------
-- xi.effect.PROWESS
-- 'Killer' effects bonus
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:delEffectFlag(xi.effectFlag.ON_ZONE)
    if target:getZoneID() == effect:getSubPower() then
        effect:addMod(xi.mod.VERMIN_KILLER, effect:getPower())
        effect:addMod(xi.mod.BIRD_KILLER, effect:getPower())
        effect:addMod(xi.mod.AMORPH_KILLER, effect:getPower())
        effect:addMod(xi.mod.LIZARD_KILLER, effect:getPower())
        effect:addMod(xi.mod.AQUAN_KILLER, effect:getPower())
        effect:addMod(xi.mod.PLANTOID_KILLER, effect:getPower())
        effect:addMod(xi.mod.BEAST_KILLER, effect:getPower())
        effect:addMod(xi.mod.UNDEAD_KILLER, effect:getPower())
        effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
        effect:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
        effect:addMod(xi.mod.DEMON_KILLER, effect:getPower())
        effect:addMod(xi.mod.EMPTY_KILLER, effect:getPower())
        effect:addMod(xi.mod.HUMANOID_KILLER, effect:getPower())
        effect:addMod(xi.mod.LUMINIAN_KILLER, effect:getPower())
        effect:addMod(xi.mod.LUMINION_KILLER, effect:getPower())
    else
        effect:addMod(xi.mod.VERMIN_KILLER, 0)
        effect:addMod(xi.mod.BIRD_KILLER, 0)
        effect:addMod(xi.mod.AMORPH_KILLER, 0)
        effect:addMod(xi.mod.LIZARD_KILLER, 0)
        effect:addMod(xi.mod.AQUAN_KILLER, 0)
        effect:addMod(xi.mod.PLANTOID_KILLER, 0)
        effect:addMod(xi.mod.BEAST_KILLER, 0)
        effect:addMod(xi.mod.UNDEAD_KILLER, 0)
        effect:addMod(xi.mod.ARCANA_KILLER, 0)
        effect:addMod(xi.mod.DRAGON_KILLER, 0)
        effect:addMod(xi.mod.DEMON_KILLER, 0)
        effect:addMod(xi.mod.EMPTY_KILLER, 0)
        effect:addMod(xi.mod.HUMANOID_KILLER, 0)
        effect:addMod(xi.mod.LUMINIAN_KILLER, 0)
        effect:addMod(xi.mod.LUMINION_KILLER, 0)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
