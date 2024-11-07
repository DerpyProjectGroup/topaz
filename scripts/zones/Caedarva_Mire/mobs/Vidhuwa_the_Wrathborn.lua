-----------------------------------
-- Area: Caedarva Mire
--   NM: Vidhuwa the Wrathborn
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.SILENCERES, 100)
    -- takes ~3s to cast AOE flood
    mob:setMod(xi.mod.UFASTCAST, 75)
    -- said to spam tp moves/barrage of tp moves
    mob:setMod(xi.mod.REGAIN, 100)
    -- this NM casts an AOE flood in 3s, every ~20 seconds
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, {chance = 65, power = 40})
end

entity.onMobFight = function(mob, target)
    -- Immortal Shield should also reduce physical damage
    if (mob:getMod(xi.mod.MAGIC_STONESKIN) >= 1001) then
            mob:setAnimationSub(2)
    elseif (mob:getMod(xi.mod.MAGIC_STONESKIN) >= 1) then
            mob:setAnimationSub(1)
    else
            mob:setAnimationSub(0)
    end
end
entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 5)
    mob:setSpellList(720)
end

entity.onSpellPrecast = function(mob, spell)
    -- flood casted by Vidhuwa is AOE
    spell:setAoE(xi.magic.aoe.RADIAL)
    spell:setRadius(10)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
        -- only uses Immortal Shield and Mind Blast
        if ((mob:getMod(xi.mod.MAGIC_STONESKIN) == 0) and (math.random(1,2) == 2)) then
            return 1965 -- Immortal Shield
        end
    
        return 1963 -- Mind Blast
    end
    
entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 471)
    mob:setAnimationSub(0) -- If he dies with Immortal Shield up, the shield effect will go down on death.
end

return entity
