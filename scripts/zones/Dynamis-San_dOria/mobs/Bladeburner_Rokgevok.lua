-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Bladeburner Rokgevok
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setSpellList(2)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1500)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 75,
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 100 },
            { id = xi.jsa.MANAFONT, cooldown = 0, hpp = 100 },
        },
    })
end

entity.onMobFight = function(mob, target)
    local timeInterval = mob:getBattleTime() % 6

    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
            member:changeMusic(2, 88)
            member:changeMusic(3, 88)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
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

