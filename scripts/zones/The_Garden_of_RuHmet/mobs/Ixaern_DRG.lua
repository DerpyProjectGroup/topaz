-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('petCount', 0)
    mob:setLocalVar('petTimer', 0)
end

entity.onMobFight = function(mob, target)
    local petCount = mob:getLocalVar('petCount')
    local petTimer = mob:getLocalVar('petTimer')

    if
        petCount < 3 and
        petTimer < os.time() + 30
    then
        mob:useMobAbility(xi.jsa.CALL_WYVERN)
        mob:setLocalVar('petCount', 3)
        mob:setLocalVar('petTimer', os.time())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable('[SEA]IxAernDRG_PH', groups[math.random(1, #groups)] + math.random(0, 2))
end

return entity
