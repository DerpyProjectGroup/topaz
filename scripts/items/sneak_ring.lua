-----------------------------------
-- ID: 26167
-- Item: Sneak Ring
-- Item Effect: Sneak
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = math.random(130, 310)

    duration = duration + target:getMod(xi.mod.SNEAK_DURATION)

    if not target:hasStatusEffect(xi.effect.SNEAK) then
        target:addStatusEffect(xi.effect.SNEAK, 1, 10, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end

return itemObject
