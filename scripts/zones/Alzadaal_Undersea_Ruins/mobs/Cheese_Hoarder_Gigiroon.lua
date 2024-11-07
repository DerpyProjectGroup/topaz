-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Cheese Hoarder Gigiroon
-- TODO: Running around mechanic and dropping bombs
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}
local PathingPoints = {
    {x = -193.5, y = -8.0, z = 73.5}, -- Index 1 - 6 North Room
    {x = -166.5, y = -8.0, z = 73.5},
    {x = -171.0, y = -8.0, z = 60.0},
    {x = -189.0, y = -8.0, z = 60.0},
    {x = -193.5, y = -8.0, z = 46.5},
    {x = -166.5, y = -8.0, z = 46.5},
    {x = -183.5, y = -8.0, z = 20.0}, -- Index 7 - 8 - Hallway
    {x = -176.5, y = -8.0, z = 20.0}, 
    {x = -166.5, y = -8.0, z = -6.5}, -- Index 9 - 14 South Room
    {x = -193.5, y = -8.0, z = -6.5},
    {x = -171.0, y = -8.0, z = -20.0},
    {x = -189.0, y = -8.0, z = -20.0},
    {x = -193.5, y = -8.0, z = -33.5},
    {x = -166.5, y = -8.0, z = -33.5},
    {x = -60.0, y = -8.0, z = -60.0},
    {x = -60.0, y = -8.0, z = 100}
}

local function pickStartingRunPoint(mob)
    -- because of the curved nature of the undersea ruins - cheese gets stuck trying to path through the walls rather than around.
    -- this position based choice route allows him to get back on track for most cases
    local mobPos = mob:getPos()
    if (mobPos.x > -120 and mobPos.x < -72 and mobPos.z <= 20 and mobPos.z > -29) then
        mob:setLocalVar('RunDestination', 15)
    elseif (mobPos.x > -120 and mobPos.x < -72 and mobPos.z <= 68 and mobPos.z > 20) then
        mob:setLocalVar('RunDestination', 16)
    else
        mob:setLocalVar('RunDestination', math.random(1,14))
    end
end

local function getAvailbleMine()
    local possibleMines = {17072173, 17072174, 17072175, 17072176, 17072177}
    local availableMine = nil
    for _,v in pairs(possibleMines) do
        local possibleMine = GetMobByID(v)
        if (possibleMine ~= nil and (not possibleMine:isSpawned())) then
            availableMine = possibleMine
            break
        end
    end

    return availableMine
end

local function spawnMine(cheese)
    local mine = getAvailbleMine()
    if (mine == nil) then
        -- no mine found
        return
    end

    -- update position
    local pos = cheese:getPos()
    mine:setSpawn(pos.x, pos.y, pos.z)

    SpawnMob(mine:getID())

    -- Cheese has 2 run modes
    if (cheese:getLocalVar('RunType') == 1) then
        -- shorter run with 500 dmg mines being planted
        mine:setLocalVar('MineDamage', 500)
    else
        -- longer run with faster dropping of 100 dmg mines
        mine:setLocalVar('MineDamage', 100)
    end

    
end

local function runForIt(mob)
    local destination = mob:getLocalVar('RunDestination')
    mob:pathTo(PathingPoints[destination].x, PathingPoints[destination].y, PathingPoints[destination].z, 9)

    -- captures show him alternating north/south via offsets in the middle hallway
    if (mob:checkDistance(PathingPoints[destination]) <= 2) then
        if (destination == 7 or destination == 8) then
            if (mob:getLocalVar('PrevRunDest') < 7) then
                mob:setLocalVar('RunDestination', math.random(9, 14))
            else
                mob:setLocalVar('RunDestination', math.random(1, 6))
            end
        elseif (destination == 15) then
            mob:setLocalVar('RunDestination', math.random(9, 14))
        elseif (destination == 16) then
            mob:setLocalVar('RunDestination', math.random(1, 6))
        else 
            mob:setLocalVar('RunDestination', math.random(7, 8))
        end
        mob:setLocalVar('PrevRunDest', destination)
    end

end


entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('TimeToRun', os.time() + 10) -- Cheese runs 3 mins after engaging.  Not hp% based (capture has him in the single digits before running)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMod(xi.mod.ATT, 400)
end

entity.onMobFight = function(mob, target)
    local now = os.time()
    if (mob:getLocalVar('RunType') == 0) then -- not running
        if (now > mob:getLocalVar('TimeToRun')) then
            -- initiate a run
            local runType = math.random(1,2)
            mob:setLocalVar('RunType', runType)
            mob:setLocalVar('MineTime', now)
            mob:setMod(xi.mod.MOVE_SPEED_STACKABLE, 40)

            pickStartingRunPoint(mob)

            if (runType == 1) then
                mob:setLocalVar('MineDelay', 12)
                mob:setLocalVar('TimeToStop', now + math.random(45, 60))
            else
                mob:setLocalVar('MineDelay', 1)
                mob:setLocalVar('TimeToStop', now + math.random(105, 120))
            end
        end
    else -- running
        if (now > mob:getLocalVar('TimeToStop')) then
            -- done running for now
            mob:setLocalVar('RunType', 0)
            mob:setLocalVar('TimeToRun', now + math.random(90,120))
            mob:setMod(xi.mod.MOVE_SPEED_STACKABLE, 1)
        else
            if (now > mob:getLocalVar('MineTime')) then
                spawnMine(mob)
                mob:setLocalVar('MineTime', now + mob:getLocalVar('MineDelay'))
            end
            runForIt(mob)
        end
    end
end


entity.onMobDeath = function(mob)
end

return entity
