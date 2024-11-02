-----------------------------------
-- Area: La Vaule [S]
--   NM: All-seeing Onyx Eye
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 33)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobFight = function(mob, target)
    local charmTimer  = mob:getLocalVar('charmTimer')
    local fastCastMod = xi.mod.UFASTCAST
    local mobHPP      = mob:getHPP()

    -- Scale fastCastMod based on mobHPP (1-100), higher effect as HP gets lower
    local scaledFastCast = 100 - mobHPP -- e.g., at 100% HP, fastCastMod is 0, at 0% HP, fastCastMod is 100
    mob:setMod(fastCastMod, scaledFastCast)

    if
        os.time() > charmTimer + 20 and
        mob:canUseAbilities()
    then
        mob:setLocalVar('charmTimer', os.time())
        mob:useMobAbility(2383) -- Charm
    end
end

entity.onMobWeaponSkillPrepare = function (mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    skillID = skill:getID()
    if skillID == 557 then
        mob:resetEnmity(target)
    end
end

entity.onSpellPrecast = function(mob, spell)
    spellID = spell:getID()
    if
        spellID == xi.magic.spell.QUAKE or
        spellID == xi.magic.spell.FLOOD or
        spellID == xi.magic.spell.TORNADO or
        spellID == xi.magic.spell.FLARE or
        spellID == xi.magic.spell.FREEZE or
        spellID == xi.magic.spell.BURST or
        spellID == xi.magic.spell.ASPIR
    then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setRadius(10)
    end
end

entity.onMobEngage = function(mob)
    local charmTimer = mob:setLocalVar('charmTimer', os.time() + 10)
end


entity.onMobDisengage = function(mob)
    local charmTimer = mob:setLocalVar('charmTimer', 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
