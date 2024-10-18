-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Arch Tzee Xicu Idol
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 800)
end

entity.onMobSpawn = function(mob)
    mob:setSpellList(5082)
    mob:setMod(xi.mod.REFRESH, 25)
    xi.mix.jobSpecial.config(mob, {
        between = 180,
        delay = 60,
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON, cooldown = 300, hpp = 100 },
        },
    })
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)

    if skill:getID() == 1116 then
        local stompCounter = mob:getLocalVar('stompCounter')

        stompCounter = stompCounter + 1
        mob:setLocalVar('stompCounter', stompCounter)

        if stompCounter > 1 then
            mob:setLocalVar('stompCounter', 0)
        elseif mob:checkDistance(target) < 6 then
            mob:useMobAbility(1116)
            mob:resetEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
