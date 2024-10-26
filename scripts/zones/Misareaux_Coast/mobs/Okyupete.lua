-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 250)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Uses Triple Attack followed by Gliding Spike
    if skill:getID() == 400 then
        mob:useMobAbility(401)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
    xi.magian.onMobDeath(mob, player, optParams, set{ 221, 649, 715, 946 })
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

return entity
