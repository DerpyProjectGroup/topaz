-----------------------------------
-- Area: Arrapago Reef
--   NM: Zareehkl the Jubilant
-----------------------------------
mixins = { 
require('scripts/mixins/families/qutrub'),
require('scripts/mixins/job_special')
}

-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)

    -- sometimes triple attack
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)

    -- immune to stun and slow/elegy
    mob:setMod(xi.mod.STUNRES, 100)
    mob:setMod(xi.mod.SLOWRES, 100)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 4500)
    -- prevent weapon breaking and start w/o sword
    mob:setLocalVar('qutrubBreakChance', 0)

    -- starts w/o weapon
    mob:setAnimationSub(1)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMobSkillAttack(0)
    mob:setMod(xi.mod.DELAY, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 303)
    mob:setLocalVar('cleaves', 0)

    -- last phase/blood weapon mechanic
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.BLOOD_WEAPON,
                duration = 30,
                hpp = math.random(25, 33),
                chance = 100,
                endCode = function(mob)
                    -- will not use any magic or tp move during blood weapon
                    mob:setAnimationSub(2)
                    mob:setAutoAttackEnabled(true)
                    mob:setMagicCastingEnabled(false)
                    mob:setMobAbilityEnabled(false)
                    mob:setMobSkillAttack(0)

                    -- will just spam leaping cleave and unblest jambiya until death after BW is over
                    mob:addListener('EFFECT_LOSE', 'BLOOD_WEAPON', function(mob, effect)
                        if effect:getTypeMask() == xi.effect.BLOOD_WEAPON then
                            mob:removeListener('BLOOD_WEAPON')
                            mob:setMobAbilityEnabled(true)
                            mob:setMobSkillAttack(5303)
                            mob:setMod(xi.mod.DELAY, 2750)
                            mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
                            -- gets really angry at everyone attacking
                            mob:addListener('TAKE_DAMAGE', 'DMG_TAKE', function(mob, _, attacker, attackType)
                                if attackType == xi.attackType.PHYSICAL and ( attacker:isPC() or attacker:isPet() ) then
                                    mob:addEnmity(attacker, 1, 3000)
                                end
                            end)
                            mob:addListener('MAGIC_TAKE', 'MDMG_TAKE', function(target, caster)
                                if caster:isPC() or caster:isPet() then
                                    target:addEnmity(caster, 1, 3000)
                                end
                            end)
                            mob:addListener('WEAPONSKILL_TAKE', 'WSDMG_TAKE', function(target, attacker)
                                if attacker:isPC() or attacker:isPet() then
                                    target:addEnmity(attacker, 1, 3000)
                                end
                            end)
                        end
                    end)
                end,
            },
        },
    })
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getMobMod(xi.mobMod.SKILL_LIST) == 0 then
        local cleaves = mob:getLocalVar('cleaves')
        if cleaves >= math.random(8, 16) then
            mob:useMobAbility(1784)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 1784 then
        -- reset cleaves after unblest jambiya
        mob:setLocalVar('cleaves', 0)
    elseif skillID == 2363 then
        -- keep track of every cleaves to trigger jambiya every once in a while
        mob:setLocalVar('cleaves', mob:getLocalVar('cleaves') + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- remove every listeners
    local listeners = { 'BLOOD_WEAPON', 'DMG_TAKE', 'MDMG_TAKE', 'WSDMG_TAKE', }
    for _, v in ipairs(listeners) do
        mob:removeListener(v)
    end
end

return entity
