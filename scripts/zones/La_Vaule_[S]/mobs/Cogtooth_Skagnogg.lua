-----------------------------------
-- Area: La Vaule [S]
--   NM: Cogtooth Skagnogg
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(true)
    mob:setMod(xi.mod.REGAIN, 3000)
    mob:resetLocalVars()
end

entity.onMobFight = function(mob, target)
    -- Re-enable mob abilities if cooldown has expired
    if mob:getLocalVar('cooldown') == 1 then
        local cooldownStart = mob:getLocalVar('cooldownStart')
        if os.time() >= cooldownStart + 13 then
            mob:setLocalVar('cooldown', 0) -- Reset cooldown variable
            mob:setMobAbilityEnabled(true)
            print('Cooldown ended. Mob can use skills again.')
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local mobHPP = mob:getHPP()

    -- Define skill tables based on health percentage
    local skills = {
        { 635, 637, 639, 638 },  -- Skills for at 100% health
        { 635, 637, 639, 638 },  -- Skills for above 80% health
        { 637, 638, 639 },       -- Skills for above 60% health
        { 637, 638 },            -- Skills for above 40% health
        { 638 },                 -- Skills for above 20% health
        { 2350, 2351, 2352 }     -- Unique skills below 20% health
    }

    -- Define number of unique skills to use based on HPP
    local uniqueSkillsCount = {
        [100] = 1,
        [80]  = 2,
        [60]  = 3,
        [40]  = 4,
        [20]  = 5,
        [0]   = 6,  -- Use 6 unique skills when health is below 20%
    }

    -- Get unique skills count for current HPP
    local uniqueCount = uniqueSkillsCount[math.floor(mobHPP / 20) * 20] or 0

    local skillIndex
    if mobHPP == 100 then
        skillIndex = 1
    elseif mobHPP > 80 then
        skillIndex = 2
    elseif mobHPP > 60 then
        skillIndex = 3
    elseif mobHPP > 40 then
        skillIndex = 4
    elseif mobHPP > 20 then
        skillIndex = 5
    else
        skillIndex = 6 -- Unique skills
    end

    -- Check if the mob is currently in cooldown
    if mob:getLocalVar('cooldown') == 1 then
        return 0 -- Prevent skill usage if still in cooldown
    end

    -- Initialize the skill index and cycle state if they don't exist
    if mob:getLocalVar('lastSkillIndex') == 0 then
        mob:setLocalVar('lastSkillIndex', 1)   -- Start with the first skill
        mob:setLocalVar('skillCycleState', 0)  -- 0 for normal, 1 for unique
        mob:setLocalVar('uniqueSkillsUsed', 0) -- Track how many unique skills have been used
    end

    local selectedSkill
    local currentIndex = mob:getLocalVar('lastSkillIndex')
    local cycleState = mob:getLocalVar('skillCycleState')

    -- Print available unique skills for debugging
    -- print(string.format('Available Unique Skills: %s', table.concat(skills[6], ', ')))

    -- Check the cycle state
    if cycleState == 0 then
        -- Get the current skill to use
        selectedSkill = skills[skillIndex][currentIndex]

        --[[ Debugging output to trace skill selection
        if selectedSkill then
            print(string.format('Mob HPP: %d, Selected Skill: %d, Current Index: %d', mobHPP, selectedSkill, currentIndex))
        else
            print(string.format('Error: selectedSkill is nil for skillIndex: %d, currentIndex: %d', skillIndex, currentIndex))
        end]]

        -- Increment the index and wrap around if necessary
        currentIndex = currentIndex + 1

        -- Check if we've cycled through all skills in the selected skills
        if currentIndex > #skills[skillIndex] then
            currentIndex = 1 -- Reset to the first skill if exceeded
            mob:setLocalVar('skillCycleState', 1) -- Switch to unique skills after cycling through normal skills
            print('Switching to unique skills!')
        end
    elseif cycleState == 1 then
        -- Check how many unique skills to use
        local uniqueSkillsUsed = mob:getLocalVar('uniqueSkillsUsed')

        print(string.format('Unique Skills Used: %d, Unique Count: %d', uniqueSkillsUsed, uniqueCount))

        if uniqueSkillsUsed < uniqueCount then
            -- Randomly select a skill from uniqueSkills
            selectedSkill = skills[6][math.random(#skills[6])]
            mob:setLocalVar('uniqueSkillsUsed', uniqueSkillsUsed + 1) -- Increment the unique skills counter

            --[[ Debugging output for unique skills
            if selectedSkill then
                print(string.format('Using Unique Skill: %d', selectedSkill))
            else
                print('Error: Selected unique skill is nil')
            end]]
        else
            -- After using the defined number of unique skills, set cooldown
            mob:setLocalVar('cooldown', 1)               -- Mark that we are in cooldown
            mob:setLocalVar('cooldownStart', os.time())  -- Record the time cooldown started
            mob:setMobAbilityEnabled(false)              -- Disable mob skills
            mob:setLocalVar('skillCycleState', 0)        -- Return to normal state
            mob:setLocalVar('lastSkillIndex', 1)         -- Reset lastSkillIndex to start again
            mob:setLocalVar('uniqueSkillsUsed', 0)       -- Reset unique skills used counter
            print('Returning to normal skill cycling and entering cooldown.')
        end
    end

    -- Set the updated index back to the mob's local variable
    mob:setLocalVar('lastSkillIndex', currentIndex)

    if selectedSkill == nil then
        selectedSkill = skills[1][1]  -- Fallback to the first skill if no skill is selected
        print('Warning: Selected skill was nil, falling back to default skill:', selectedSkill)
    end

    print('Selected Skill', selectedSkill)
    return selectedSkill
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Check if the mob has just used a skill and if it's in the unique skill cycle
    local uniqueSkillsUsed = mob:getLocalVar('uniqueSkillsUsed')

    if uniqueSkillsUsed >= 3 then
        mob:setLocalVar('cooldown', 1)
        mob:setLocalVar('cooldownStart', os.time())
        mob:setMobAbilityEnabled(false)
        mob:setLocalVar('skillCycleState', 0)
        mob:setLocalVar('lastSkillIndex', 1)
        mob:setLocalVar('uniqueSkillsUsed', 0)
        -- print('Cooldown initiated after unique skill usage.')
    end
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(7200, 14400)) -- 2 to 4 hours
end

return entity