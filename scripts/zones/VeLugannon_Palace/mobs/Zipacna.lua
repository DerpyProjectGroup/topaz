-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Zipacna
-----------------------------------
---@type TMobEntity
local entity = {}
local ID = zones[xi.zone.VELUGANNON_PALACE]

local firstBlueDoorCoord = { x = -160, y = -2.974, z = 380 }
local middleBlueDoorCoord = { x = -80, y = -2.974, z = 460 }
local middleYellowDoorCoord = { x = 80, y = -2.974, z = 460 }
local firstYellowDoorCoord = { x = 160, y = -2.974, z = 380 }

-----------------------------------
---Doors are named from West to East
---1st Blue Door | Middle Blue Door | Middle Yellow Door | 1st Yellow Door
-----------------------------------

    -- From blue side spawn point to the first blue door
local blueShortSideSpawnPath =
{
    { x = -195, z = 395 },
    { x = -192, z = 390 },
    { x = -189, z = 384 },
    { x = -183, z = 380 },
    { x = -165, z = 380 },
    { x = -162, z = 380 },
}

    -- From the blue side basement to the first blue door
local blueBasementSpawnPath =
{
    { x = -134, y = 16, z = 380 },
    { x = -150, y = 16, z = 379 },
    { x = -220, y = 16, z = 379 },
    { x = -220, y = 16, z = 416 },
    { x = -232, y = 16, z = 419 },
    { x = -240, y = 16, z = 419 }, -- bottom of steps going back upstairs
    { x = -255, y = 12, z = 418 },
    { x = -260, y = 11, z = 412 },
    { x = -260, y = 8, z = 401 },
    { x = -259, y = 5, z = 388 },
    { x = -255, y = 3, z = 380 },
    { x = -239, y = 0, z = 380 },
    { x = -215, y = 0, z = 380 },
    { x = -204, y = 0, z = 389 },
    { x = -197, y = 0, z = 391 },
    { x = -186, y = 0, z = 382 },
    { x = -177, y = 0, z = 380 },
    { x = -162, y = 0, z = 380 }, --first blue door
}

    -- From the short yellow side spawn point to the first yellow door
local yellowShortSideSpawnPath =
{
    { x = 191, y = 0, z = 399 },
    { x = 192, y = 0, z = 389 },
    { x = 186, y = 0, z = 381 },
    { x = 182, y = 0, z = 379 },
    { x = 174, y = 0, z = 379 },
    { x = 161, y = 0, z = 379 },
}

    -- From the yellow basement to the first yellow door
local yellowBasementSpawnPath =
{
    { x = 173, y = 16, z = 458 },
    { x = 178, y = 16, z = 460 },
    { x = 210, y = 16, z = 460 },
    { x = 215, y = 16, z = 457 },
    { x = 219, y = 16, z = 452 },
    { x = 219, y = 16, z = 442 },
    { x = 219, y = 16, z = 420 },
    { x = 240, y = 16, z = 419 },
    { x = 258, y = 12, z = 417 },
    { x = 259, y = 4, z = 384 },
    { x = 254, y = 3, z = 380 },
    { x = 239, y = 0, z = 379 },
    { x = 214, y = 0, z = 380 },
    { x = 208, y = 0, z = 386 },
    { x = 208, y = 0, z = 398 },
    { x = 206, y = 0, z = 405 },
    { x = 198, y = 0, z = 409 },
    { x = 191, y = 0, z = 405 },
    { x = 192, y = 0, z = 395 },
    { x = 193, y = 0, z = 389 },
    { x = 187, y = 0, z = 382 },
    { x = 184, y = 0, z = 380 },
    { x = 176, y = 0, z = 379 },
    { x = 157, y = 0, z = 380 },
}

    -- From first blue door to the blue basement loop
local firstBlueToBasement =
{
    { x = -162, y = 0, z = 380 }, --First Blue Door
    { x = -171, y = 0, z = 379 },
    { x = -178, y = 0, z = 380 },
    { x = -187, y = 0, z = 381 },
    { x = -192, y = 0, z = 387 },
    { x = -193, y = 0, z = 395 },
    { x = -194, y = 0, z = 405 },
    { x = -201, y = 0, z = 408 },
    { x = -208, y = 0, z = 403 },
    { x = -208, y = 0, z = 395 },
    { x = -208, y = 0, z = 388 },
    { x = -212, y = 0, z = 382 },
    { x = -220, y = 0, z = 379 },
    { x = -238, y = 0, z = 380 }, --start of steps down to basement
    { x = -245, y = 1, z = 380 },
    { x = -251, y = 2, z = 380 },
    { x = -257, y = 4, z = 381 },
    { x = -260, y = 5, z = 386 },
    { x = -260, y = 7, z = 396 },
    { x = -260, y = 8, z = 402 },
    { x = -259, y = 10, z = 411 },
    { x = -256, y = 12, z = 417 },
    { x = -250, y = 13, z = 419 },
    { x = -239, y = 16, z = 420 }, --bottom of steps
    { x = -221, y = 16, z = 420 },
    { x = -219, y = 16, z = 457 },
    { x = -203, y = 16, z = 460 },
    { x = -136, y = 16, z = 458 },
    { x = -130, y = 16, z = 456 },
    { x = -124, y = 16, z = 446 },
    { x = -125, y = 16, z = 389 },
    { x = -134, y = 16, z = 380 },
    { x = -150, y = 16, z = 379 },
    { x = -220, y = 16, z = 379 },
    { x = -220, y = 16, z = 416 },
    { x = -232, y = 16, z = 419 },
    { x = -240, y = 16, z = 419 }, -- bottom of steps going back upstairs
    { x = -255, y = 12, z = 418 },
    { x = -260, y = 11, z = 412 },
    { x = -260, y = 8, z = 401 },
    { x = -259, y = 5, z = 388 },
    { x = -255, y = 3, z = 380 },
    { x = -239, y = 0, z = 380 },
    { x = -215, y = 0, z = 380 },
    { x = -204, y = 0, z = 389 },
    { x = -197, y = 0, z = 391 },
    { x = -186, y = 0, z = 382 },
    { x = -177, y = 0, z = 380 },
    { x = -162, y = 0, z = 380 }, --first blue door
}

    -- Path from the First blue door to the middle blue door
local firstBluetoBlueMiddle =
{
    { x = -157, y = 0, z = 380 },-- first blue door
    { x = -134, y = 0, z = 380 },
    { x = -132, y = 0, z = 382 },
    { x = -129, y = 0, z = 385 },
    { x = -127, y = 0, z = 393 },
    { x = -125, y = 0, z = 404 },
    { x = -124, y = 0, z = 413 },
    { x = -123, y = 0, z = 423 },
    { x = -118, y = 0, z = 436 },
    { x = -111, y = 0, z = 452 },
    { x = -108, y = 0, z = 458 },
    { x = -091, y = 0, z = 460 },
    { x = -084, y = 0, z = 460 },-- middle blue door
}

    -- Path from the middle blue door to the middle yellow door
local middleBlueToMiddleYellow =
{
    { x = -76, y = 0.0, z = 459 },-- Middle blue door
    { x = -70, y = 0.0, z = 459 },
    { x = -62, y = 0.0, z = 455 },
    { x = -59, y = 0.3, z = 449 },
    { x = -60, y = 0.5, z = 433 },
    { x = -60, y = 0.0, z = 420 },
    { x = -50, y = 0.0, z = 420 },
    { x = -45, y = 0.0, z = 419 },
    { x = -18, y = 0.0, z = 420 },
    { x = 60, y = 0.0, z = 419 },
    { x = 60, y = 0.0, z = 450 },
    { x = 62, y = 0.0, z = 456 },
    { x = 67, y = 0.0, z = 459 },
    { x = 74, y = 0.0, z = 460 },
    { x = 78, y = 0.0, z = 460 },-- Middle yellow door
}

    -- Path from the middle yellow door to the first yellow door
local middleYellowToFirstYellow =
{
    { x = 82, y = 0, z = 459 },-- Middle yellow door
    { x = 96, y = 0, z = 459 },
    { x = 103, y = 0, z = 459 },
    { x = 107, y = 0, z = 457 },
    { x = 112, y = 0, z = 452 },
    { x = 114, y = 0, z = 446 },
    { x = 116, y = 0, z = 437 },
    { x = 119, y = 0, z = 427 },
    { x = 120, y = 0, z = 418 },
    { x = 123, y = 0, z = 408 },
    { x = 128, y = 0, z = 388 },
    { x = 131, y = 0, z = 383 },
    { x = 135, y = 0, z = 380 },
    { x = 140, y = 0, z = 379 },
    { x = 147, y = 0, z = 379 },
    { x = 157, y = 0, z = 380 },-- first yellow door
}

    -- Path from the first yellow door to the basement and back to the first yellow door
local firstYellowToBasement =
{
    { x = 185, y = 0, z = 380 }, --First Yellow door
    { x = 193, y = 0, z = 390 },
    { x = 191, y = 0, z = 402 },
    { x = 199, y = 0, z = 407 },
    { x = 207, y = 0, z = 408 },
    { x = 209, y = 0, z = 399 },
    { x = 206, y = 0, z = 390 },
    { x = 209, y = 0, z = 384 },
    { x = 216, y = 0, z = 380 },
    { x = 221, y = 0, z = 379 },
    { x = 239, y = 0, z = 379 },
    { x = 254, y = 3, z = 380 },
    { x = 259, y = 4, z = 384 }, -- Top of stairs
    { x = 259, y = 11, z = 415 },
    { x = 254, y = 12, z = 419 },
    { x = 219, y = 16, z = 420 },
    { x = 219, y = 16, z =  387},
    { x = 215, y = 16, z = 380 },
    { x = 211, y = 16, z = 380 },
    { x = 142, y = 16, z = 380 },
    { x = 139, y = 16, z = 384 },
    { x = 139, y = 16, z = 419 },
    { x = 145, y = 16, z = 427 },
    { x = 173, y = 16, z = 458 },
    { x = 178, y = 16, z = 460 },
    { x = 210, y = 16, z = 460 },
    { x = 215, y = 16, z = 457 },
    { x = 219, y = 16, z = 452 },
    { x = 219, y = 16, z = 442 },
    { x = 219, y = 16, z = 420 },
    { x = 240, y = 16, z = 419 },
    { x = 258, y = 12, z = 417 },
    { x = 259, y = 4, z = 384 },
    { x = 254, y = 3, z = 380 },
    { x = 239, y = 0, z = 379 },
    { x = 214, y = 0, z = 380 },
    { x = 208, y = 0, z = 386 },
    { x = 208, y = 0, z = 398 },
    { x = 206, y = 0, z = 405 },
    { x = 198, y = 0, z = 409 },
    { x = 191, y = 0, z = 405 },
    { x = 192, y = 0, z = 395 },
    { x = 193, y = 0, z = 389 },
    { x = 187, y = 0, z = 382 },
    { x = 184, y = 0, z = 380 },
    { x = 164, y = 0, z = 380 },
}

    -- path from the first yellow door to the middle yellow door
local firstYellowToMiddleYellow =
{
    { x = 156, y = 0, z = 379 },-- first yellow door
    { x = 144, y = 0, z = 379},
    { x = 133, y = 0, z = 380 },
    { x = 129, y = 0, z = 384 },
    { x = 124, y = 0, z = 399 },
    { x = 124, y = 0, z = 410 },
    { x = 117, y = 0, z = 424 },
    { x = 114, y = 0, z = 439 },
    { x = 111, y = 0, z = 451 },
    { x = 109, y = 0, z = 456 },
    { x = 106, y = 0, z = 458 },
    { x = 100, y = 0, z = 460 },
    { x = 94, y = 0, z = 459 },
    { x = 82, y = 0, z = 459 },-- Middle yellow door
}

    -- path from the yellow middle door to the middle blue door
local middleYellowToMiddleBlue =
{
    { x = 77, y = 0, z = 460 },
    { x = 71, y = 0, z = 459 },
    { x = 66, y = 0, z = 458 },
    { x = 63, y = 0, z = 456 },
    { x = 60, y = 0, z = 450 },
    { x = 60, y = 0, z = 443 },
    { x = 60, y = 0, z = 419 },
    { x = 40, y = 0, z = 419 },
    { x = 21, y = 0, z = 419 },
    { x = -9, y = 0, z = 420 },
    { x = -59, y = 0, z = 420 },
    { x = -60, y = 0, z = 433 },
    { x = -60, y = 0, z = 450 },
    { x = -62, y = 0, z = 455 },
    { x = -67, y = 0, z = 458 },
    { x = -75, y = 0, z = 460 },
    { x = -76, y = 0, z = 460 },
}

    -- Path from the middle blue door to the first blue door
local middleBlueToFirstBlue =
{
    { x = -82, y = 0, z = 460 },
    { x = -93, y = 0, z = 459 },
    { x = -103, y = 0, z = 459 },
    { x = -106, y = 0, z = 458 },
    { x = -110, y = 0, z = 454 },
    { x = -116, y = 0, z = 434 },
    { x = -117, y = 0, z = 420 },
    { x = -121, y = 0, z = 409 },
    { x = -125, y = 0, z = 395 },
    { x = -129, y = 0, z = 385 },
    { x = -133, y = 0, z = 381 },
    { x = -141, y = 0, z = 380 },
    { x = -153, y = 0, z = 379 },
    { x = -157, y = 0, z = 379 },-- Middle blue door

}
entity.onMobSpawn = function(mob)
    local pos = mob:getPos()
    mob:setMod(xi.mod.REGAIN, 200)

    -- Zip popped on blue short side (!pos -196, 0, 396)
    if pos.x <= -195 then
        mob:pathThrough(blueShortSideSpawnPath, xi.path.flag.COORDS)

    -- Zip popped at the blue basement spawn point (!pos -121, 16, 420)
    elseif pos.x <= -120 then
        mob:pathThrough(blueBasementSpawnPath, xi.path.flag.COORDS)

    -- Zip popped at the Yellow Short Side Spawn Point - going to first yellow door (!pos 191, 0, 399)
    elseif pos.x >= 190 then
        mob:pathThrough(yellowShortSideSpawnPath, xi.path.flag.COORDS)

    -- Zip popped in the yellow side basement - going to first yellow door
    elseif pos.x >= 140 then
        mob:pathThrough(yellowBasementSpawnPath, xi.path.flag.COORDS)
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobRoam = function(mob)
    local pos              = mob:getPos()
    local firstBlueDoor    = GetNPCByID(ID.npc.B_DOOR_OFFSET + 1)
    local middleBlueDoor   = GetNPCByID(ID.npc.B_DOOR_OFFSET)
    local firstYellowDoor  = GetNPCByID(ID.npc.Y_DOOR_OFFSET + 1)
    local middleYellowDoor = GetNPCByID(ID.npc.Y_DOOR_OFFSET)
    local getLastDoor      = mob:getLocalVar('[Zipacna]lastDoor')

    -- begin of door checks. System in place is to check distance betwen mob and the NPC door (mapped to IDs.lua in local firstBlueDoorCoord, etc)
    if
        mob:checkDistance(firstBlueDoorCoord.x, firstBlueDoorCoord.y, firstBlueDoorCoord.z) <= 5
    then
        if -- POS from path to first blue door if Zip is coming from the basement
            pos.x <= -162.000 and
            pos.y <= 1 and
            pos.z >= 379 and
            getLastDoor ~= 1
        then
            if
                firstBlueDoor and
                firstBlueDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(firstBlueToBasement, xi.path.flag.COORDS)
            elseif
                firstBlueDoor and
                firstBlueDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(firstBluetoBlueMiddle, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 1)
            end
        elseif -- coming from middle blue door to first blue door
            pos.x >= -158.000 and
            pos.y <= 1 and
            pos.z >= 379 and
            getLastDoor >= 1
        then
            if
                firstBlueDoor and
                firstBlueDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(firstBluetoBlueMiddle, xi.path.flag.COORDS)
            elseif
                firstBlueDoor and
                firstBlueDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(firstBlueToBasement, xi.path.flag.COORDS)
            end
        end
    end

    -- middle blue door
    if
    mob:checkDistance(middleBlueDoorCoord.x, middleBlueDoorCoord.y, middleBlueDoorCoord.z) <= 5 then
        if
            pos.x <= -81 and
            pos.y <= 1 and
            pos.z >= 459 and
            getLastDoor == 1
        then
            if
                middleBlueDoor and
                middleBlueDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(middleBlueToFirstBlue, xi.path.flag.COORDS)
            elseif
                middleBlueDoor and
                middleBlueDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(middleBlueToMiddleYellow, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 2)
            end
        elseif
            pos.x >= -76 and
            pos.y <= 1 and
            pos.z >= 460 and
            getLastDoor >= 2
        then
            if
                middleBlueDoor and
                middleBlueDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(middleBlueToMiddleYellow, xi.path.flag.COORDS)
            elseif
                middleBlueDoor and
                middleBlueDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(middleBlueToFirstBlue, xi.path.flag.COORDS)
            end
        end
    end
    -- middle yellow door
    if
    mob:checkDistance(middleYellowDoorCoord.x, middleYellowDoorCoord.y, middleYellowDoorCoord.z) <= 5 then
        if
            pos.x <= 78 and
            pos.y <= 1 and
            pos.z <= 461 and
            getLastDoor <= 3
        then
            print ("12check distance to middle yellow door is a success! from blue middle door")
            if
                middleYellowDoor and
                middleYellowDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(middleYellowToMiddleBlue, xi.path.flag.COORDS)
            elseif
                middleYellowDoor and
                middleYellowDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(middleYellowToFirstYellow, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 3)
            end
        elseif
            pos.x >= 81 and
            pos.y <= 1 and
            pos.z >= 459 and
            getLastDoor == 4
        then
            if
                middleYellowDoor and
                middleYellowDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(middleYellowToFirstYellow, xi.path.flag.COORDS)
            elseif
                middleYellowDoor and
                middleYellowDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(middleYellowToMiddleBlue, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 3)
            end
        end
    end

    -- first yellow door
    if
        mob:checkDistance(firstYellowDoorCoord.x, firstYellowDoorCoord.y, firstYellowDoorCoord.z) <= 5 then
        if
            pos.x <= 161 and
            pos.y <= 1 and
            pos.z <= 380 and
            getLastDoor >= 3
        then
            if
                firstYellowDoor and
                firstYellowDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(firstYellowToMiddleYellow, xi.path.flag.COORDS)
            elseif
                firstYellowDoor and
                firstYellowDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(firstYellowToBasement, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 4)
            end
        elseif
            pos.x >= 156 and
            pos.y <= 1 and
            pos.z >= 380 and
            getLastDoor == 4  or
            getLastDoor == 0
        then
            if
                firstYellowDoor and
                firstYellowDoor:getAnimation() == xi.anim.CLOSE_DOOR
            then
                mob:pathThrough(firstYellowToBasement, xi.path.flag.COORDS)
            elseif
                firstYellowDoor and
                firstYellowDoor:getAnimation() == xi.anim.OPEN_DOOR
            then
                mob:pathThrough(firstYellowToMiddleYellow, xi.path.flag.COORDS)
                mob:setLocalVar('[Zipacna]lastDoor', 4)
            end
        end
    end
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(10800, 14400)) -- respawn 3-4 hrs
end

return entity
