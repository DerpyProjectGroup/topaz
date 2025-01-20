-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
---@type TMobEntity
local entity = {}

local mobRegen = function(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour <= 20 then
        mob:setMod(xi.mod.REGEN, 125)
    else
        mob:setMod(xi.mod.REGEN, 250)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
end

entity.onMobDisengage = function(mob)
    local weather = mob:getWeather()

    if weather ~= xi.weather.DUST_STORM and weather ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()
    mobRegen(mob)

    if weather ~= xi.weather.DUST_STORM and weather ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VINEGAR_EVAPORATOR)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > -540,
            target:getXPos() < -350,
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    mobRegen(mob)
end

entity.onMobSkillTarget = function(target, mob, mobskill)
    if mobskill:isAoE() then
        for _, member in ipairs(target:getAlliance()) do
            mob:drawIn(member)
        end
    end
end

return entity
