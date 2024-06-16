-----------------------------------
-- ID: 26166
-- Item: Invisible Ring
-- Item Effect: Invisible
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = math.random(130, 310)
    if target:hasStatusEffect(xi.effect.INVISIBLE) then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end
    duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)
    
    target:addStatusEffect(xi.effect.INVISIBLE, 1, 10, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return itemObject
