-----------------------------------
-- ID: 4254
-- Item: Megalixir
-- Item Effect: Instantly restores 100% of HP and MP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    local mHP = target:getMaxHP()
    local cHP = target:getHP()
    local mMP = target:getMaxMP()
    local cMP = target:getMP()

    if mHP == cHP and mMP == cMP then
        result = 56 -- Does not let player use item if their hp and mp are full
    end

    return result
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.CURSE_II) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
        return 1
    end
    
    target:addHP(target:getMaxHP())
    target:addMP(target:getMaxMP())
    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
