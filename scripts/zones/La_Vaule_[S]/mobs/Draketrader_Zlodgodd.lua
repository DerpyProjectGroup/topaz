-----------------------------------
-- Area: La Vaule [S]
--   NM: Draketrader Zlodgodd
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Above 50% HP, mob will spam Jump three times in succession with the third Jump having a long delay.
    -- Once his HP dips below 50%, he will add additional 'short' jumps at 10% intervals.
    -- His attack also becomes notably higher at this point.
    mob:setMod(xi.mod.REGAIN, 400)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)

    mob:addListener('WEAPONSKILL_USE', 'TRIPLE_JUMP', function(mobArg, target, wsid, tp, action)
        local mobHPP        = mobArg:getHPP()
        local longJump      = 1064
        local reuseMobskill = mobArg:getLocalVar('reuseMobskill')

        if wsid == longJump then
            mobArg:setLocalVar('reuseMobskill', 0)
        else
            if
                mobHPP > 50 and
                reuseMobskill < 1 or
                mobHPP < 50 and
                reuseMobskill < 5 or
                mobHPP < 40 and
                reuseMobskill < 6 or
                mobHPP < 30 and
                reuseMobskill < 7 or
                mobHPP < 20 and
                reuseMobskill < 8 or
                mobHPP < 10 and
                reuseMobskill < 9
            then
                mobArg:setTP(3000)
            else
                -- Third jump should have longer delay.
                mobArg:useMobAbility(longJump)
            end

            mobArg:setLocalVar('reuseMobskill', reuseMobskill + 1)
        end

        if
            mobArg:getHPP() <= 50 and
            mobArg:getLocalVar('rage') ~= 1
        then
            mobArg:setLocalVar('rage', 1)
            mobArg:addMod(xi.mod.ATT, 100)
        end
    end)
end

entity.onMobFight = function(mob, target)
    if mob:getCurrentAction() == xi.action.MOBABILITY_USING then
        mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    else
        if mob:hasStatusEffect(xi.effect.ALL_MISS) then
            mob:delStatusEffectSilent(xi.effect.ALL_MISS)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('TRIPLE_JUMP')
    mob:resetLocalVars()
    mob:setRespawnTime(math.random(7200, 18000)) -- 2 to 5 hours
end

return entity
