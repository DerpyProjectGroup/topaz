-----------------------------------
-- Area: La Vaule [S]
--   NM: Falsespinner Bhudbrodd
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, cooldown = 3600, hpp = 20 },
        },
    })

    mob:setMobMod(xi.mobMod.SKILL_LIST, 5412)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setLocalVar('skill_tp', 0)
end

entity.onMobFight = function(mob, target)
    local danceTimer  = mob:getLocalVar('danceTimer')
    if
        os.time() > danceTimer + math.random(30, 60) and
        mob:canUseAbilities()
    then
        mob:setLocalVar('danceTimer', os.time())
        mob:setLocalVar('skill_tp', mob:getTP())
        mob:useMobAbility(609) -- Battle Dance
    end

    if mob:getHPP() < 20 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 5413) -- Below 20% HP, can use Fanatic Dance
    else
        mob:setMobMod(xi.mobMod.SKILL_LIST, 5412) -- Default skill list
    end
end

entity.onMobWeaponSkillPrepare = function (mob, target)
end

entity.OnMobSkillCheck = function (target, mob, skill)
end

entity.onMobWeaponSkill = function(target, mob, skill)
        -- Don't lose TP from battle dance.
        if skill:getID() == 609 then
            mob:addTP(mob:getLocalVar('skill_tp')) -- Restore TP
            mob:setLocalVar('skill_tp', 0) -- Reset stored TP to 0
        end
end

entity.onMobRoam = function (mob)
    mob:setLocalVar('skill_tp', 0) -- Reset stored TP to 0 if not in combat
end

entity.OnMobEngage = function (mob, target)
    mob:setLocalVar('skill_tp', os.time() + 10) -- 10 second delay on combat start
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
