-----------------------------------
-- Area: Balga's Dais
--  Mob: Macan Gadangan
-- BCNM: Wild Wild Whiskers
-----------------------------------
local ID = require("scripts/zones/Balgas_Dais/IDs")
-----------------------------------
local entity = {}
-- ELEM
entity.onMobSpawn = function(mob)
    mob:setLocalVar("magicRank", 1)
    mob:setLocalVar("casts", 0)
    mob:setLocalVar("control", 0)

    mob:addListener("MAGIC_INTERRUPTED", "MACAN_MAGIC_INTERRUPTED", function(mobArg)
        mob:queue(0, function(m)
            m:useMobAbility(1336)
        end)
    end)
end

local function magicRankUp(mob)
    local amount = mob:getLocalVar("casts")

    -- Increase magic rank after every 3 casts
    if amount % 3 == 0 and mob:getLocalVar("magicRank") ~= 5 then
        mob:setLocalVar("magicRank", mob:getLocalVar("magicRank") + 1)
        mob:addMod(xi.mod.MATT, 100)
    end
end

entity.onMobMagicPrepare = function(mob, target, spell)
    mob:setLocalVar("casts", mob:getLocalVar("casts") + 1)

    magicRankUp(mob)
    local rank = mob:getLocalVar("magicRank")

    if rank == 1 then
        mob:messageText(target, ID.text.MACAN_WHISKERS_SLIGHTLY, false)
    elseif rank == 2 then
        mob:messageText(target, ID.text.MACAN_WHISKERS_RAPIDLY, false)
    elseif rank == 3 then
        mob:messageText(target, ID.text.MACAN_WHISKERS_WILDLY, false)
    elseif rank == 4 then
        mob:messageText(target, ID.text.MACAN_WHISKERS_VIOLENTLY, false)
    elseif rank == 5 then
        mob:messageText(target, ID.text.MACAN_WHISKERS_UNCONTROLLABLY, false)
        return 212 -- Burst
    end
end

entity.onMobFight = function(mob)
    local rank = mob:getLocalVar("magicRank")

    if mob:hasStatusEffect(xi.effect.SILENCE) then
        mob:setLocalVar("magicRank", 5)
        mob:setMod(xi.mod.MATT, 400)
    end

    if mob:getCurrentAction() == xi.act.MAGIC_CASTING and mob:getLocalVar("control") == 0 and rank == 5 then
        mob:setLocalVar("control", 1)
        mob:queue(0, function(m)
            m:useMobAbility(480)
            mob:setLocalVar("control", 0)
        end)
    end
end

entity.onMobDeath = function(mob)
end

return entity
