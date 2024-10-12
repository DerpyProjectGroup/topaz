-----------------------------------
--  MOB: Eiri Samasriri
-- Area: Nyzul Isle
-- Info: Enemy Leader, Spams Frog Song
-----------------------------------
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob, target)
        return 1957 -- Frog Song
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
        local instance = mob:getInstance()
        local chars    = instance:getChars()

        for _, entities in ipairs(chars) do
            if entities:hasStatusEffect(xi.effect.COSTUME) then
                entities:delStatusEffect(xi.effect.COSTUME)
            end
        end
    end
end

return entity
