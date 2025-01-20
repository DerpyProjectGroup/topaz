-----------------------------------
-- Area: Abyssea - Misareaux
--  Mob: Athamas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSkillTarget = function(target, mob, mobskill)
    if mobskill:isAoE() then
        for _, member in ipairs(target:getAlliance()) do
            mob:drawIn(member)
        end
    end
end

return entity
