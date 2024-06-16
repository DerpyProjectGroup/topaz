-----------------------------------------
-- ID: 15198
-- Sprout Beret
-- Enchantment: 60Min, Costume - Mandragora (white)
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemUse = function(target)
    local num = math.random(0,100)

    if num == 0  then 
        target:addStatusEffect(xi.effect.COSTUME, 301, 0, 3600)
    elseif num == 100 then 
        target:addStatusEffect(xi.effect.COSTUME, 2101, 0, 3600)
    elseif num >= 1 and num <= 49 then
        target:addStatusEffect(xi.effect.COSTUME, 31, 0, 3600)
    elseif num >= 50 and num <= 99 then
        target:addStatusEffect(xi.effect.COSTUME, 2247, 0, 3600)
    end
end

return itemObject
