-----------------------------------
-- Disruptor
-----------------------------------
require('scripts/globals/automatonweaponskills')



-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)
    -- Dispel
    if spellEffect == xi.effect.NONE then
        spellEffect = target:dispelStatusEffect()

        if spellEffect == xi.effect.NONE then
            skill:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            skill:setMsg(xi.msg.basic.MAGIC_ERASE)
        end
    end

        return spellEffect
end

return abilityObject
