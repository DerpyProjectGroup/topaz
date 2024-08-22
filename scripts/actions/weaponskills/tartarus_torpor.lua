-----------------------------------
-- Tartarus Topor
-- Staff weapon skill
-- Skill level: 150
-- Delivers an area of effect attack. Sleeps enemies. Duration of effect varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget.
-- Aligned with the Aqua Belt.
-- Element: None
-- Modifiers: STR:30%  MND:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.7 params.mnd_wsc = 0.3 params.chr_wsc = 0.0
    params.ele = xi.element.DARK
    params.skill = xi.skill.STAFF
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 then
        local duration = (tp / 1000 * 30) * applyResistanceAddEffect(player, target, xi.element.DARK, 0)
        if not target:hasStatusEffect(xi.effect.SLEEP_I) and not target:hasImmunity(xi.immunity.DARK_SLEEP) then
            target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
            player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.SLEEP_I)
        end
        target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 5, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.MAGIC_DEF_DOWN)
        target:addStatusEffect(xi.effect.MAGIC_EVASION_DOWN, 5, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.MAGIC_EVASION_DOWN)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
