-----------------------------------
-- Empty mob ecosystem mixin
-----------------------------------
require('scripts/globals/mixins')

-----------------------------------

g_mixins = g_mixins or {}

local setModel = function(mob, skin)
    -- Strays in Vahzl can also spawn as Weeper and Seether models
    if
        mob:getZone():getID() == xi.zone.PROMYVION_VAHZL and
        mob:getName() == 'Stray'
    then
        local chance = math.random(1, 10)
        if chance == 1 then -- Weeper
            mob:setLocalVar('strayType', 1)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 256)
        elseif chance == 2 then -- Seether
            mob:setLocalVar('strayType', 2)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 220)
        else -- Stray
            mob:setLocalVar('strayType', 3)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 255)
        end
    end

    -- Two elements per model
    local model = 0
    if skin < 3 then
        model = 1 -- Dark/Water
    elseif skin > 2 and skin < 5 then
        model = 2 -- Lightning/Earth
    elseif skin > 4 and skin < 7 then
        model = 3 -- Light/Fire
    elseif skin > 6 then
        model = 4 -- Ice/Wind
    end

    -- Set model depending on mob family
    if
        mob:getFamily() == 255 or
        (mob:getFamily() == 499 and
        mob:getLocalVar('strayType') == 3)
    then -- Wanderer/Stray
        if model == 4 then
            model = model + 1
        end
        if mob:getPool() == 2048 then -- Apex Idle Drifter
            mob:setModelId(3613 + model)
        else
            mob:setModelId(1105 + model)
        end
    elseif
        mob:getFamily() == 256 or
        (mob:getFamily() == 499 and
        mob:getLocalVar('strayType') == 1)
    then -- Weeper / Stray
        if mob:getPool() == 298 then -- Apex Idle Lamenter
            mob:setModelId(3618 + model)
        else
            mob:setModelId(1111 + model)
        end
    elseif
        mob:getFamily() == 220 or
        (mob:getFamily() == 499 and
        mob:getLocalVar('strayType') == 2)
    then -- Seether / Stray
        if model > 1 then
            model = model + 1
        end
        if mob:getPool() == 4527 then -- Apex Livid Rager
            mob:setModelId(3624 + model)
        else
            mob:setModelId(1116 + model)
        end
    elseif mob:getFamily() == 241 then -- Thinker
        if model > 2 then
            model = model + 1
        end

        mob:setModelId(1122 + model)
    elseif mob:getFamily() == 137 or mob:getFamily() == 138 then -- Gorger
        mob:setModelId(1128 + model)
    elseif mob:getFamily() == 78 then -- Craver
        if model > 2 then
            model = model + 1
        end

        mob:setModelId(1133 + model)
    end
end

g_mixins.families.empty = function(emptyMob)
    emptyMob:addListener('SPAWN', 'EMPTY_SPAWN', function(mob)
        -- Dark > Water > Lightning > Earth > Light > Fire > Ice > Wind
        local skin = math.random(1, 8)
        mob:setLocalVar('skin', skin)
        setModel(mob, skin)
    end)

    emptyMob:addListener('ROAM_TICK', 'EMPTY_ROAM_TICK', function(mob)
        local skin = mob:getLocalVar('skin')
        if skin % 2 == 0 and mob:getAnimationSub() ~= 2 then
            mob:setAnimationSub(2)
        elseif skin % 2 ~= 0 and mob:getAnimationSub() ~= 1 then
            mob:setAnimationSub(1)
        end

        -- Temporary solution until mods on spawn issue is corrected
        local buffed = mob:getLocalVar('buffed')
        if buffed == 0 then
            -- return EEM to neutral, overriding DB
            mob:setMod(xi.mod.FIRE_RES_RANK, 1)
            mob:setMod(xi.mod.ICE_RES_RANK, 1)
            mob:setMod(xi.mod.WIND_RES_RANK, 1)
            mob:setMod(xi.mod.EARTH_RES_RANK, 1)
            mob:setMod(xi.mod.THUNDER_RES_RANK, 1)
            mob:setMod(xi.mod.WATER_RES_RANK, 1)
            mob:setMod(xi.mod.LIGHT_RES_RANK, 1)
            mob:setMod(xi.mod.DARK_RES_RANK, 1)
        end

        if skin == 1 and buffed == 0 then -- Dark
            mob:setMod(xi.mod.DARK_RES_RANK, 11)
            mob:setMod(xi.mod.LIGHT_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5409)
            end

        elseif skin == 2 and buffed == 0 then -- Water
            mob:setMod(xi.mod.FIRE_RES_RANK, 11)
            mob:setMod(xi.mod.WATER_RES_RANK, 11)
            mob:setMod(xi.mod.THUNDER_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5408)
            end
        elseif skin == 3 and buffed == 0 then -- Lightning
            mob:setMod(xi.mod.WATER_RES_RANK, 11)
            mob:setMod(xi.mod.THUNDER_RES_RANK, 11)
            mob:setMod(xi.mod.EARTH_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5407)
            end
        elseif skin == 4 and buffed == 0 then -- Earth
            mob:setMod(xi.mod.THUNDER_RES_RANK, 11)
            mob:setMod(xi.mod.EARTH_RES_RANK, 11)
            mob:setMod(xi.mod.WIND_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5406)
            end
        elseif skin == 5 and buffed == 0 then -- Light
            mob:setMod(xi.mod.LIGHT_RES_RANK, 11)
            mob:setMod(xi.mod.DARK_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5405)
            end
        elseif skin == 6 and buffed == 0 then -- Fire
            mob:setMod(xi.mod.ICE_RES_RANK, 11)
            mob:setMod(xi.mod.FIRE_RES_RANK, 11)
            mob:setMod(xi.mod.WATER_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5402)
            end
        elseif skin == 7 and buffed == 0 then -- Ice
            mob:setMod(xi.mod.WIND_RES_RANK, 11)
            mob:setMod(xi.mod.ICE_RES_RANK, 11)
            mob:setMod(xi.mod.FIRE_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5403)
            end
        elseif buffed == 0 then -- Wind
            mob:setMod(xi.mod.EARTH_RES_RANK, 11)
            mob:setMod(xi.mod.WIND_RES_RANK, 11)
            mob:setMod(xi.mod.ICE_RES_RANK, -3)
            mob:setLocalVar('buffed', 1)
            if -- Weeper Elemental Skills
                mob:getFamily() == 256 or
                (mob:getFamily() == 499 and
                mob:getLocalVar('strayType') == 1)
            then
                mob:setMobMod(xi.mobMod.SKILL_LIST, 5404)
            end
        end
    end)
end

return g_mixins.families.empty
