-----------------------------------
-- Area: Bibiki Bay
--  Mob: Eft
-- Note: PH for Intulo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 3, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    -- PH is the 10th Eft entry in the zone
    local eftId    = mob:getZone():queryEntitiesByName('Eft')[10]:getID()
    local intuloId = mob:getZone():queryEntitiesByName('Intulo')[1]:getID()
    local intuloPh =
    {
        [eftId] = intuloId, -- 480 -3 743
    }
    xi.mob.phOnDespawn(mob, intuloPh, 10, 3600) -- 1 hour
end

return entity
