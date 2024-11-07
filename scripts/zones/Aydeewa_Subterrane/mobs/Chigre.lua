-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Chigre
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}
-- Todo: add enailments, Drain samba on target if all ailments on, very fast enmity decay, capture speed

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- Blind, Poison, Paralyze, Slow, Petrification, Silence, Drain, Curse, and Plague.

    local effects = { } 
    if not target:hasStatusEffect(xi.effect.BLINDNESS) then
        table.insert(effects, xi.mob.ae.BLIND)
    end
    if not target:hasStatusEffect(xi.effect.POISON) then
        table.insert(effects, xi.mob.ae.POISON)
    end
    if not target:hasStatusEffect(xi.effect.PARALYSIS) then
        table.insert(effects, xi.mob.ae.PARALYZE)
    end
    if not target:hasStatusEffect(xi.effect.SLOW) then
        table.insert(effects, xi.mob.ae.SLOW)
    end
    if not target:hasStatusEffect(xi.effect.PETRIFICATION) then
        table.insert(effects, xi.mob.ae.PETRIFY)
    end
    if not target:hasStatusEffect(xi.effect.SILENCE) then
        table.insert(effects, xi.mob.ae.SILENCE)
    end
    if not target:hasStatusEffect(xi.effect.CURSE_I) then
        table.insert(effects, xi.mob.ae.CURSE)
    end
    if not target:hasStatusEffect(xi.effect.PLAGUE) then
        table.insert(effects, xi.mob.ae.PLAGUE)
    end
    
    --printf('effectscount %s', #effects)
    if #effects == 0 then
        local params = { }
        params.chance = 100
        params.power = 80
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, params)
    end

    local params = { }
    params.duration = 120
    local effect = effects[math.random(#effects)]
    if (effect == xi.mob.ae.SLOW) then params.power = 1501 end -- force overwrite haste
    return xi.mob.onAddEffect(mob, target, damage, effect, params)
end

return entity
