-----------------------------------
-- Area: Mount Zhayolm
--   NM: Wamoura Prince
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
mixins = { require('scripts/mixins/families/wamouracampa') }
-----------------------------------
local entity = {}

function canEvolve(mob)
    local canPrinceEvolve = false
    local mobId = mob:getID()

    for i,v in pairs(ID.mob.EVOLVING_WAMOURA_PRINCES) do
        if mobId == v then   
            canPrinceEvolve = true
        end
    end

    return canPrinceEvolve    
end

entity.onMobSpawn = function(mob)
    if canEvolve(mob) then
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:setLocalVar("evolveTime", os.time() + math.random(3500, 3600)) -- Evolves in approx 1 Vana'diel day
    end
end

entity.onMobRoam = function(mob)
    if canEvolve(mob) then
        local evolveTime = mob:getLocalVar("evolveTime")
        if os.time() > evolveTime then
            local princeID = mob:getID()
            local wamoura = GetMobByID(princeID + 1)
            wamoura:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
            mob:hideName(true)
            mob:setUntargetable(true)
            DespawnMob(princeID)
            wamoura:spawn()
            DisallowRespawn(princeID, true)
        end
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
