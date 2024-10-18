-----------------------------------
-- Plenilune Embrace Up
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
        -- animsub 1 = standing, animsub 0 = all fours
        if mob:getAnimationSub() == 1 then
            return 1
        end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration    = 90
    local attBoost    = 1
    local magAttBoost = 1
    local moonPhase   = VanadielMoonPhase()
    local divisor     = 1
    if moonPhase <= 5 then
        magAttBoost = 15
        attBoost = 1
        divisor  = 0.05
    elseif moonPhase <= 25 then
        magAttBoost = 12
        attBoost = 3
        divisor  = 0.10
    elseif moonPhase <= 40 then
        magAttBoost = 10
        attBoost = 5
        divisor  = 0.15
        mob:eraseStatusEffect()
    elseif moonPhase <= 60 then
        magAttBoost = 7
        attBoost = 7
        divisor  = 0.20
        mob:eraseStatusEffect()
    elseif moonPhase <= 75 then
        magAttBoost = 5
        attBoost = 10
        divisor  = 0.25
        mob:eraseStatusEffect()
        mob:eraseStatusEffect()
    elseif moonPhase <= 90 then
        magAttBoost = 3
        attBoost = 12
        divisor  = 0.35
        mob:eraseStatusEffect()
        mob:eraseStatusEffect()
        mob:eraseStatusEffect()
    elseif moonPhase <= 100 then
        magAttBoost = 1
        attBoost = 15
        divisor  = 0.40
        mob:eraseAllStatusEffect()
    end

    mob:addStatusEffect(xi.effect.ATTACK_BOOST, attBoost, 0, duration)
    mob:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, magAttBoost, 0, duration)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * divisor)
end

return mobskillObject
