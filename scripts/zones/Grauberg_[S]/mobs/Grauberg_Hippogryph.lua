-----------------------------------
-- Area: Grauberg [S]
--  Mob: Grauberg Hippogryph
-- Note: PH for Kotan-kor Kamuy
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
local entity = {}

local kotanPHTable =
{
    [ID.mob.KOTAN_KOR_KAMUY - 4] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY - 3] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY - 2] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 1] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 2] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 3] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 4] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 5] = ID.mob.KOTAN_KOR_KAMUY,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, kotanPHTable, 5, 10800) -- 3 hours
end

return entity
