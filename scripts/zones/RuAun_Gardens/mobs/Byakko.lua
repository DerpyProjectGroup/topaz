-----------------------------------
-- Area: Ru'Aun Gardens
-- NM: Byakko
-- ID: 17309982
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob, target)
    mob:setMod(xi.mod.ATT, 391)
    mob:setMod(xi.mod.DEF, 345)
    mob:addMod(xi.mod.VIT, 43)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EVA, 397)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMagicCastingEnabled(false)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 8):setAnimation(xi.anim.CLOSE_DOOR)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 11)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENLIGHT)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 12)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 8):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 8):setAnimation(xi.anim.OPEN_DOOR)
end

return entity