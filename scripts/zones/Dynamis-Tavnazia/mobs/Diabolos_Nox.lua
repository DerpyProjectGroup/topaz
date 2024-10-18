-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Nox
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 25)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.HP_SCALE, 500)
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 502 then
    -- kaustra casted by diabolos nox is AOE
    spell:setAoE(xi.magic.aoe.RADIAL)
    spell:setRadius(10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
