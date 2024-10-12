-----------------------------------
-- Area: Ru'Aun Gardens
-- NM: Seiryu
-- ID: 17309981
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob, target)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:addMod(xi.mod.ATT, 50)
    mob:setMod(xi.mod.EVA, 367)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    -- TP move about every 9 seconds without TP feed
    mob:setMod(xi.mod.REGAIN, 750)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 9)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    -- adjust when below 50% and 25% as Seiryu has the same TP move rate
    if mob:getHPP() <= 25 and mob:getMod(xi.mod.REGAIN) ~= 250 then
        mob:setMod(xi.mod.REGAIN, 250)
    elseif
        mob:getHPP() > 25 and
        mob:getHPP() <= 50 and
        mob:getMod(xi.mod.REGAIN) ~= 500
    then
        mob:setMod(xi.mod.REGAIN, 500)
    elseif mob:getHPP() > 50 and mob:getMod(xi.mod.REGAIN) ~= 750 then
        mob:setMod(xi.mod.REGAIN, 750)
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    if not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS, 0) then
        local rnd = math.random()
        if rnd < 0.5 then
            return 186 -- aeroga 3
        elseif rnd < 0.7 then
            return 157 -- aero 4
        elseif rnd < 0.9 then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end

    return 0 -- Still need a return, so use 0 when not casting
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 10)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.OPEN_DOOR)
end

return entity