-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Dynamis Lord
-- Note: Mega Boss
-- Spawned by trading a Shrouded Bijou to the ??? in front of Castle Zvahl.
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_ARCH_DYNAMIS_LORD', function(mobArg, loot)
        if mob:getID() == ID.mob.ARCH_DYNAMIS_LORD then
            loot:addItem(17669, xi.drop_rate.COMMON)
            loot:addItem(10975, xi.drop_rate.COMMON)
            loot:addItem(11674, xi.drop_rate.COMMON)
        end
    end)
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 300,
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS,  hpp = 100 },
            { id = xi.jsa.MIGHTY_STRIKES, hpp = 100 },
            { id = xi.jsa.BLOOD_WEAPON,   hpp = 100 },
            { id = xi.jsa.CHAINSPELL,     hpp = 100 },
        },
    })
    mob:delImmunity(xi.immunity.GRAVITY)
    if mob:getID(ID.mob.ARCH_DYNAMIS_LORD) then
    mob:setLocalVar('initial_Split', 0)
    end
end

entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime()

    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end

    if mob:getHP() < 40000 then
        mob:setSpellList(5086)
    else
        mob:setSpellList(5085)
    end

    for i = 0, 1 do
        local petId = ID.mob.DYNAMIS_LORD_CLONE_OFFSET + i
        local pet = GetMobByID(petId)
        local master = GetMobByID(ID.mob.ARCH_DYNAMIS_LORD)
        local masterHP = master:getHP()

        if battleTime % 45 == 0 and battleTime >= 45 and not pet:isSpawned() and mob:getLocalVar('initial_Split') == 0 then
            local pos = mob:getPos()
            pet:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
            pet:spawn()
            pet:setHP(masterHP)
            pet:updateEnmity(target)
            mob:setLocalVar('initial_Split', 1)
        end

        if pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDespawn = function(mob)
    local petId = mob:getID(ID.mob.DYNAMIS_LORD_CLONES)
    local pet = GetMobByID(petId)
    local master = GetMobByID(ID.mob.ARCH_DYNAMIS_LORD)
    local masterHP = master:getHP()
    local pos = mob:getPos()

    if mob:getID() ~= ID.mob.ARCH_DYNAMIS_LORD and master:isSpawned() then
        mob:timer(1000, function(mob)
            pet:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
            pet:spawn()
            pet:setHP(masterHP)
            pet:updateEnmity()
            for i = 0, 2 do
                local dynamisLordsID = ID.mob.ARCH_DYNAMIS_LORD + i
                local dynamisLords = GetMobByID(dynamisLordsID)
                dynamisLords:setStatus(xi.status.INVISIBLE)
                dynamisLords:setAutoAttackEnabled(false)
                dynamisLords:setMagicCastingEnabled(false)
                dynamisLords:setMobAbilityEnabled(false)
                dynamisLords:timer(1000, function(mob)
                    dynamisLords:setStatus(xi.status.UPDATE)
                    dynamisLords:setAutoAttackEnabled(true)
                    dynamisLords:setMagicCastingEnabled(true)
                    dynamisLords:setMobAbilityEnabled(true)
                end)
            end
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getID() == ID.mob.ARCH_DYNAMIS_LORD then
        for i = 0, 6 do
            local cloneId = ID.mob.DYNAMIS_LORD_CLONE_OFFSET + i
            local clones = GetMobByID(cloneId)
           DespawnMob(cloneId)
        end
    end
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
