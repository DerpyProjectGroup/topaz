---@meta

---@class TMobEntity
---@field onMobInitialize? fun(mob: CBaseEntity)
---@field onPath? fun(mob: CBaseEntity)
---@field onPathPoint? fun(mob: CBaseEntity)
---@field onPathComplete? fun(mob: CBaseEntity)
---@field onMobEngage? fun(mob: CBaseEntity, target: CBaseEntity)
---@field onMobDisengage? fun(mob: CBaseEntity)
---@field onMobFollow? fun(mob: CBaseEntity, target: CBaseEntity)
---@field onMobUnfollow? fun(mob: CBaseEntity, target: CBaseEntity)
---@field onMobDrawIn? fun(mob: CBaseEntity, target: CBaseEntity)
---@field onMobFight? fun(mob: CBaseEntity, target: CBaseEntity)
---@field onCriticalHit? fun(mob: CBaseEntity, attacker: CBaseEntity?)
---@field onMobDeath? fun(mob: CBaseEntity, killer: CBaseEntity?, optParams: { isKiller: boolean, noKiller: boolean, isWeaponSkillKill: boolean, weaponskillUsed: xi.weaponskill, weaponskillDamage: integer })
---@field onMobSpawn? fun(mob: CBaseEntity)
---@field onMobRoamAction? fun(mob: CBaseEntity)
---@field onMobRoam? fun(mob: CBaseEntity)
---@field onMobDespawn? fun(mob: CBaseEntity)
---@field onPlayerAbilityUse? fun(mob: CBaseEntity, player: CBaseEntity, ability: CAbility)
---@field onMobWeaponSkillPrepare? fun(mob: CBaseEntity, target: CBaseEntity): integer?
---@field onMobWeaponSkill? fun(target: CBaseEntity, mob: CBaseEntity, mobSkill: CMobSkill, action: CAction): integer?
---@field onMobSkillTarget? fun(target: CBaseEntity, mob: CBaseEntity, mobSkill: CMobSkill): CBaseEntity?
---@field onAdditionalEffect? fun(mob: CBaseEntity, target: CBaseEntity, damage: integer): (integer?, integer?, integer?)
---@field onMobMagicPrepare? fun(mob: CBaseEntity, target: CBaseEntity, spell: CSpell?): xi.magic.spell|0?
---@field onWeaponskillHit? fun(mob: CBaseEntity, attacker: CBaseEntity, weaponskillId: xi.weaponskill)
---@field onSpikesDamage? fun(mob: CBaseEntity, target: CBaseEntity, damage: integer): (integer?, integer?, integer?)
---@field onMagicHit? fun(caster: CBaseEntity, target: CBaseEntity, spell: CSpell)
---@field onSpellPrecast? fun(mob: CBaseEntity, spell: CSpell)
---@field onSteal? fun(player: CBaseEntity, target: CBaseEntity, ability: CAbility, action: CAction): integer?
---@field onMagicCastingCheck? fun(mob: CBaseEntity, target: CBaseEntity, spell: CSpell): integer?