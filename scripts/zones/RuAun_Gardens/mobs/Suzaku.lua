-----------------------------------
-- Area: Ru'Aun Gardens
-- NM: Suzaku
-- ID: 17309983
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob, target)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:addMod(xi.mod.ATT, 155)
    mob:addMod(xi.mod.DEF, 94)
    mob:setMod(xi.mod.EVA, 377)
    mob:addMod(xi.mod.VIT, 77)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 53)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.anim.CLOSE_DOOR)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 7)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

-- Return the selected spell ID.
entity.onMobMagicPrepare = function(mob, target, spellId)
    -- Suzaku uses     Burn, Fire IV, Firaga III, Flare
    -- Let's give -ga3 a higher distribution than the others.
    local rnd = math.random()

    if rnd < 0.5 then
        return 176 -- firaga 3
    elseif rnd < 0.7 then
        return 147 -- fire 4
    elseif rnd < 0.9 then
        return 204 -- flare
    else
        return 235 -- burn
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 8)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.anim.OPEN_DOOR)
end

return entity