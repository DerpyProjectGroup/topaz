-----------------------------------
-- Area: Mamook
--  Mob: Darting Kachaal Ja
-- Note: Does not auto attack. Will run away when current target
--  draws near. Casts either bindga, stun, or sleepga II before running.
--  appears to run in a track rather than to random distance away from player.
--  Does not approach his target in order to cast. Will continuously run around track.
--
--  Appears to have two types of engagement: A fleeing mode, and an aggressive mode.
--  Under some time of being untouched, Kachaal Ja will become aggressive and no longer
--  flee from its target and begin to spam aeroga iii. It also regains the ability to
--  auto-attack. However, it begins fleeing again after taking damage.
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -8, y = 18,   z = -413 },
    { x = 5,  y = 19,   z = -425 },
    { x = 18, y = 19,   z = -438 },
    { x = 40, y = 17.5, z = -440 },
    { x = 45, y = 18,   z = -412 },
    { x = 1,  y = 17.5, z = -400 },
    { x = 21, y = 19,   z = -397 },
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP) -- Needs verification

    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setMobAbilityEnabled(false) -- Not witnessed to use any mob abilities
    mob:setLocalVar('nextPoint', 1)
    -- mob:setMobMod(xi.mobMod.SPELL_LIST, 5095)
end

entity.onMobEngage = function(mob)
    -- Find nearest point in path
    for i = 2, #pathNodes do
        local nearest = pathNodes[mob:getLocalVar('nextPoint')]
        local next = pathNodes[i]

        if mob:checkDistance(next.x, next.y, next.z) < mob:checkDistance(nearest.x, nearest.y, nearest.z) then
            mob:setLocalVar('nextPoint', i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local pos = pathNodes[mob:getLocalVar('nextPoint')]

    -- Doesn't run out of MP
    mob:setMP(mob:getMaxMP())

    -- Update to next destination for flee path. If out of range of
    -- table, reset to 1
    if mob:checkDistance(pos.x, pos.y, pos.z) < 3 then
        mob:setLocalVar('nextPoint', mob:getLocalVar('nextPoint') + 1)

        if mob:getLocalVar('nextPoint') > #pathNodes then
            mob:setLocalVar('nextPoint', 1)
        end

        pos = pathNodes[mob:getLocalVar('nextPoint')]
    end

    if mob:checkDistance(target) <= 10 then
        mob:setLocalVar('fleeMode', 1)

        -- Only stops running after certain amount of time
    elseif mob:getLocalVar('fleeTimer') < os.time() then
        mob:setLocalVar('fleeTimer', os.time() + math.random(15, 30))
        mob:setLocalVar('fleeMode', 0)
    end

    -- Spam aeroga 3
    if mob:getLocalVar('fleeMode') == 0 then
        -- mob:setMobMod(xi.mobMod.SPELL_LIST, 5095)
        mob:setSpellList(5095)
        mob:setAutoAttackEnabled(true)

    -- Path around and cast mob control spells
    else
        -- mob:setMobMod(xi.mobMod.SPELL_LIST, 5094)
        mob:setSpellList(5094)
        mob:setAutoAttackEnabled(true)
        -- Leave room to cast spells
        if mob:getLocalVar('fleeTimer') < os.time() then
            mob:setLocalVar('fleeTimer', os.time() + 2)
            mob:pathTo(pos.x, pos.y, pos.z)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Reduces Mamool Ja Savages' military force by 1
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(100800, 259200)) -- 28 to 72 hours **Needs verification**
end

return entity
