-----------------------------------
-- xi.effect.KILLER_INSTINCT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)

    -- Used for BST Killer Instinct. Automatically sets subPower as the pet's ecosystem when the ability is used to fetch the correct corresponding killer effect.
    -- Uses subPower xi.ecosystem.ENUM 1-21 where applicable.
    -- TODO: Implement potential item mods for items that augment this ability.
    if effect:getSubPower() == xi.ecosystem.AMORPH then
        effect:addMod(xi.mod.BIRD_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.AQUAN then
        effect:addMod(xi.mod.AMORPH_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.ARCANA then
        effect:addMod(xi.mod.UNDEAD_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.BEAST then
        effect:addMod(xi.mod.LIZARD_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.BIRD then
        effect:addMod(xi.mod.AQUAN_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.DEMON then
        effect:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.DRAGON then
        effect:addMod(xi.mod.DEMON_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.LUMINION then
        effect:addMod(xi.mod.LUMINIAN_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.PLANTOID then
        effect:addMod(xi.mod.BEAST_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.UNDEAD then
        effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
    elseif effect:getSubPower() == xi.ecosystem.VERMIN then
        effect:addMod(xi.mod.PLANTOID_KILLER, effect:getPower())
    -- Special cases for subPower > 21. This can be used for special mob buffs etc.
    -- Add more below

    --Gnole Mobskill: Call Of The Moon
    elseif effect:getSubPower() == 22 then
        effect:addMod(xi.mod.HUMANOID_KILLER, effect:getPower())
        effect:addEffectFlag(xi.effectFlag.NO_LOSS_MESSAGE)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
