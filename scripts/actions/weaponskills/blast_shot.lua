-----------------------------------
-- Blast Shot
-- Marksmanship weapon skill
-- Skill Level: 200
-- Delivers a melee-distance ranged attack. params.accuracy varies with TP.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.0, 2.0 }
    params.agi_wsc = 0.3
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.numHits = 2
        params.ftpMod = { 1.0, 1.0, 1.0 }
        params.multiHitfTP = true
        params.agi_wsc = 0.8
    end

    params.meleedmg = 0
    params.melee = true

    local weaponDamage       = 4
    local weaponType         = player:getWeaponSkillType(xi.slot.MAIN)
    local meleeWeapon        = player:getWeaponDmg() * 0.9
    local meleeWeaponOffhand = player:getOffhandDmg() * 0.35
    local rangedWeapon       = player:getRangedDmg()

    if weaponType == xi.skill.HAND_TO_HAND then
        weaponDamage = math.floor(player:getSkillLevel(1) * 110 / 276) -- +130 at capped A+ h2h
	else
        weaponDamage = meleeWeapon + rangedWeapon + meleeWeaponOffhand
	end
	
	if weaponDamage < 4 then
		weaponDamage = 4
	end
	
	params.meleedmg = math.ceil(weaponDamage * 5.0)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    local chance = (tp - 1000) * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) > math.random() * 150
    if damage > 0 and not target:hasStatusEffect(xi.effect.STUN) and chance and not target:hasImmunity(xi.immunity.STUN) then
        local duration = 6 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0)
        target:addStatusEffect(xi.effect.STUN, 1, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.STUN)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
