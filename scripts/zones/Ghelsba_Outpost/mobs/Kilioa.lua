-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Kilioa
-- BCNM: Petrifying Pair
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 1000)
    mob:setMod(xi.mod.LULLABYRES, 1000)
    mob:setRoamFlags(xi.roamFlag.EVENT)
end

entity.onMobEngaged = function(mob, target)
    GetMobByID(mob:getID() - 1):updateEnmity(target) -- link Kalamainu
    mob:useMobAbility(373) -- secretion
end

entity.onMobWeaponSkill = function(mob, target, skill)
    if math.random() < 0.5 then
        return 370 -- favor baleful gaze
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
