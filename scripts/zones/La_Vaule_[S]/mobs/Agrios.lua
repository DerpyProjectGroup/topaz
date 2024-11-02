-----------------------------------
-- Area: La Vaule [S]
--   NM: Agrios
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addMod(xi.mod.DEF, 125)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.ACC, 20)
end

entity.onMobFight = function(mob, target)
    local mobSkillCounter = mob:getLocalVar('mobSkillCounter')
    local mobSkillMax = mob:getLocalVar('mobSkillMax')

    if mobSkillCounter == mobSkillMax and mobSkillMax > 0 then
        mob:setLocalVar('mobSkillCounter', 0)
        mob:setLocalVar('mobSkillMax', 0)
    end

    if mobSkillMax > 0 and mob:canUseAbilities() then
        if mobSkillCounter > mobSkillMax then
            mob:setLocalVar('mobSkillCounter', 0)
            mob:setLocalVar('mobSkillMax', 0)
        elseif mob:getTarget() ~= nil then
            mob:setLocalVar('mobSkillCounter', mobSkillCounter + 1)
            mob:useMobAbility()
        end
    end
end

entity.onMobWeaponSkillPrepare = function (mob, target)
    local mobSkillCounter = mob:getLocalVar('mobSkillCounter')
    local mobSkillMax = mob:getLocalVar('mobSkillMax')

    if mobSkillCounter == 0 and mobSkillMax == 0 then
        mobSkillMax = math.random(2, 3)
        mob:setLocalVar('mobSkillMax', mobSkillMax)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobEngage = function(mob)
end


entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
    mob:resetLocalVars()
end

return entity
