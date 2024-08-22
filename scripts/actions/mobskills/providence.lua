-----------------------------------
-- Providence
-- Description: Grants additional spells.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
 -- Being silenced does not stop this skill, but does prevent casting of the spell associated
end


mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local random = math.random(1,100)
    local spellID = 0

    if (random <= 5) then
        spellID = 367 -- Death
    elseif (random <= 15) then
        spellID = 365-- Breakga
    elseif (random <= 35) then
        spellID = 361-- Blindga
    elseif (random <= 55) then
        spellID = 366 -- Graviga
    elseif (random <= 75) then
        spellID = 357 -- Slowga
    elseif (random <= 100) then
        spellID = 362 -- Bindga
    end

    local fastCastMod = mob:getMod(xi.mod.UFASTCAST)
    mob:setLocalVar('fastCastMod', fastCastMod)
    mob:setMod(xi.mod.UFASTCAST, 150)
    mob:castSpell(spellID, mob)
    mob:timer(3000, function(mob)
    mob:setMod(xi.mod.UFASTCAST, mob:getLocalVar('fastCastMod'))
    end)
    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
