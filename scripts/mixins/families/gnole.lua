-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Delay table indexed by stance (0 = quadrupedal, 1 = bipedal)
local delays =
{
    [0] = { -- Quadrupedal
        { minPhase = 90, delay = 2600 }, -- 156 Delay
        { minPhase = 60, delay = 3166 }, -- 190 Delay
        { minPhase = 39, delay = 3633 }, -- 218 Delay
        { minPhase = 11, delay = 4266 }, -- 256 Delay
        { minPhase = 0,  delay = 4766 }, -- 286 Delay
    },
    [1] = { -- Bipedal
        { minPhase = 90, delay = 4166 }, -- 250 Delay
        { minPhase = 60, delay = 5000 }, -- 300 Delay
        { minPhase = 39, delay = 5833 }, -- 350 Delay
        { minPhase = 11, delay = 6833 }, -- 410 Delay
        { minPhase = 0,  delay = 7666 }, -- 460 Delay
    }
}

-- Function to get delay based on moon phase
local function getDelay(moonPhase, stance)
    for _, phaseData in ipairs(delays[stance]) do
        if moonPhase >= phaseData.minPhase then
            return phaseData.delay
        end
    end
end

local function changeStance(mob, forceStanceChange)
    local moonPhase = VanadielMoonPhase()
    local hour = VanadielHour()

    forceStanceChange = forceStanceChange or false
    local isNighttime = hour <= 4 or hour > 20

    if not forceStanceChange then
        if moonPhase >= 90 or (moonPhase > 59 and isNighttime) then
            mob:setAnimationSub(1) -- Bipedal form
        elseif moonPhase > 38 and isNighttime then
            mob:setAnimationSub(1) -- Bipedal form
        else
            mob:setAnimationSub(0) -- Quadrupedal form
        end
    else
        mob:setAnimationSub(1) -- Force Bipedal form
    end

    -- Stance Mods and Delays
    local stance = mob:getAnimationSub() -- stance is now either 0 (quadrupedal) or 1 (bipedal)

    if stance == 0 then -- Quadrupedal stance
        mob:setMobMod(xi.mobMod.NO_LINK, 1)
        mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    else -- Bipedal stance
        mob:setMobMod(xi.mobMod.NO_LINK, 0)
        mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
        mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    end

    -- Set delay based on moon phase and stance
    mob:setDelay(getDelay(moonPhase, stance))

    -- Reset timer
    mob:setLocalVar('formTimer', os.time() + math.random(180, 240))
end

g_mixins.families.gnole = function(gnoleMob)
    local moonPhase = VanadielMoonPhase()
    -- Set default state.
    gnoleMob:addListener('SPAWN', 'GNOLE_SPAWN', function(mob)
        mob:setAnimationSub(0) -- Quadrupedal form.
        mob:setMobMod(xi.mobMod.SPAWN_ANIMATIONSUB, 0)
        changeStance(mob)
        mob:setLocalVar('formTimer', os.time())
    end)

    -- Handle regular changes on roam.
    gnoleMob:addListener('ROAM_TICK', 'GNOLE_ROAM', function(mob)
        local hour = VanadielHour()
        local isNighttime = hour >= 20 or hour <= 4
        mob:setMod(xi.mod.REGEN, isNighttime and 2 or 0)
        mob:setLocalVar('NIGHT_REGEN_ACTIVE', isNighttime and 1 or 0)

        if os.time() >= mob:getLocalVar('formTimer') then
            changeStance(mob)
        end
    end)

    gnoleMob:addListener('COMBAT_TICK', 'GNOLE_COMBAT', function(mob)
        local hour = VanadielHour()
        local isNighttime = hour >= 20 or hour <= 4
        if isNighttime and mob:getLocalVar('NIGHT_REGEN_ACTIVE') == 0 then
            mob:setMod(xi.mod.REGEN, 2)
            mob:setLocalVar('NIGHT_REGEN_ACTIVE', 1)
        elseif not isNighttime then
            mob:setMod(xi.mod.REGEN, 0)
            mob:setLocalVar('NIGHT_REGEN_ACTIVE', 0)
        end
    end)

    gnoleMob:addListener('ABILITY_TAKE', 'GNOLE_ABILITY_TAKE', function(mob, user, ability)
        if
            VanadielMoonPhase() >= 24 and
            ability:getID() == xi.jobAbility.PROVOKE
        then
            changeStance(mob, true)
        elseif
            VanadielMoonPhase() >= 24 and
            mob:getVE(user) > 600
        then
            changeStance(mob, true)
        end
    end)

    gnoleMob:addListener('WEAPONSKILL_TAKE', 'GNOLE_WEAPONSKILL_TAKE', function(mob, user, wsid)
        if
            VanadielMoonPhase() >= 24 and
            mob:getVE(user) > 600
        then
            changeStance(mob, true)
        end
    end)

    gnoleMob:addListener('MAGIC_TAKE', 'GNOLE_MAGIC_TAKE', function(target, caster, spell)
        if
            VanadielMoonPhase() >= 24 and
            target:getVE(caster) > 600
        then
            changeStance(target, true)
        end
    end)
end

return g_mixins.families.gnole