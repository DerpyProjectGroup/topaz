-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Cavanneche
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1500)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 75,
        delay = 15,
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON, cooldown = 120, hpp = 100 },
            { id = xi.jsa.MANAFONT, cooldown = 120, hpp = 100 },
        },
    })
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        mob:setSpellList(2)
    else
        mob:setSpellList(5)
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