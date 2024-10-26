-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura
-- Note: PH for Ignamoth
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
local entity = {}

local ignamothPHTable =
{
    [ID.mob.IGNAMOTH - 2] = ID.mob.IGNAMOTH, -- -567.6 -15.35 252.201
    [ID.mob.IGNAMOTH - 1] = ID.mob.IGNAMOTH, -- -544.3 -14.8 262.992
}

function evolvedFromPrince(mob)
    local evolved = false
    local mobId = mob:getID()

    for i,v in pairs(ID.mob.EVOLVING_WAMOURA_PRINCES) do
        if mobId == v+1 then
            evolved = true
        end
    end

    return evolved    
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ignamothPHTable, 10, 7200) -- 2 hours
    if evolvedFromPrince(mob) then
        local princeID = mob:getID() - 1
        DisallowRespawn(princeID, false)
    end
end

return entity
